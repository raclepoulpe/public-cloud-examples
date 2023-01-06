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

resource "ovh_cloud_project_database" "pgsqldb" {
  service_name = var.serviceName
  description  = var.dbDescription
  engine       = var.dbEngine
  version      = var.dbVersion
  plan         = var.dbPlan
  flavor       = var.dbFlavor
  nodes {
    region = var.dbRegion
  }
}

resource "ovh_cloud_project_database_postgresql_user" "user" {
  service_name = var.serviceName
  cluster_id   = ovh_cloud_project_database.pgsqldb.id
  name         = "mastodon"
  roles        = ["replication"]
}

resource "ovh_cloud_project_database_ip_restriction" "iprestriction" {
  service_name = var.serviceName
  cluster_id   = ovh_cloud_project_database.pgsqldb.id
  engine       = ovh_cloud_project_database.pgsqldb.engine
  ip           = "${openstack_compute_instance_v2.mastodon.network[0].fixed_ip_v4}/32"
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
