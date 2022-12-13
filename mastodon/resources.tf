resource "openstack_compute_instance_v2" "mastodon" {
  name        = "mastodon"
  flavor_name = "b2-7"
  image_name  = "Ubuntu 22.10"
  key_pair    = "keypairAdmin"

}

resource "openstack_compute_keypair_v2" "keypairAdmin" {
  name       = "keypairAdmin"
  public_key = var.keypairAdmin
}

resource "local_file" "ansible_config" {
  content = templatefile("${path.module}/templates/hosts.tftpl", {
    mastodonIP = openstack_compute_instance_v2.mastodon.network[0].fixed_ip_v4
  })
  filename        = "${path.module}/ansible/hosts"
  file_permission = "0644"
}

resource "null_resource" "ansible" {
  depends_on = [openstack_compute_instance_v2.mastodon]
  triggers   = { always_run = "${timestamp()}" }
  provisioner "local-exec" {
    command = "ansible-playbook -i ansible/hosts ansible/playbook.yml"
  }
}
