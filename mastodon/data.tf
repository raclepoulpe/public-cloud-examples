data "template_file" "ansible_hosts_tpl" {
  template = file("${path.module}/templates/hosts.tpl")
  vars = {
    mastodonIP = openstack_compute_instance_v2.mastodon.network[0].fixed_ip_v4
  }
}
