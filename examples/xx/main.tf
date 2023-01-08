module "keypair" {
  source  = "../../modules/ssh_keypair"
  keypair = var.keypair
}

module "bs" {
  source = "../../modules/storage/block_storage"
  bs     = var.bs
}

module "instance" {
  source     = "../../modules/instance_simple"
  depends_on = [module.keypair]
  instance   = var.instance
}

resource "openstack_compute_volume_attach_v2" "attached" {
  region = var.region
  instance_id = module.instance.instance_id
  volume_id = module.bs.volume_id
}

# Ansible inventory file
resource "local_file" "ansible_config" {
  content = templatefile("./templates/hosts.tftpl", {
    instance_public_ip = module.instance.instance_private_ip
    instance_user_name = var.instance.user
    ssh_private_key_name = var.keypair.name
  })
  filename        = "${path.module}/apps/hosts"
  file_permission = "0644"
}

# Ansible Execution - Mongoshell Installation
resource "null_resource" "ansible_exec" {
  depends_on = [local_file.ansible_config]
  triggers   = { always_run = "${timestamp()}" }
  provisioner "local-exec" {
    command = "ansible-playbook -i apps/hosts apps/apps.yml"
  }
}
