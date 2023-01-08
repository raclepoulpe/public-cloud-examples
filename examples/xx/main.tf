module "keypair" {
  source  = "../../modules/ssh_keypair"
  keypair = var.keypair
}

module "instance" {
  source     = "../../modules/instance_simple"
  depends_on = [module.keypair]
  instance   = var.instance
}

resource "openstack_compute_volume_attach_v2" "attached" {
  region      = var.region
  instance_id = module.instance.instance_id
  volume_id   = data.openstack_blockstorage_volume_v3.bs.id
}

# Ansible inventory file
resource "local_file" "ansible_config" {
  content = templatefile("./templates/hosts.tftpl", {
    instance_public_ip   = module.instance.instance_private_ip
    instance_user_name   = var.instance.user
    ssh_private_key_name = var.keypair.name
  })
  filename        = "${path.module}/apps/hosts"
  file_permission = "0644"
}

# Ansible variables file
resource "local_file" "ansible_vars" {
  content = templatefile("./templates/all.tftpl", {
    volume_device                 = openstack_compute_volume_attach_v2.attached.device
    user                          = var.instance.user
    minecraft_server_jar_file_url = var.mc_server.url
  })
  filename        = "${path.module}/apps/group_vars/all"
  file_permission = "0644"
}

# Ansible Execution - Apps Installation
resource "null_resource" "ansible_exec" {
  depends_on = [local_file.ansible_config, local_file.ansible_vars]
  triggers   = { always_run = "${timestamp()}" }
  provisioner "local-exec" {
    command = "ansible-playbook -i apps/hosts apps/apps.yml"
  }
}
