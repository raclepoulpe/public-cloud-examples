output "pubIp" {
  value = openstack_compute_instance_v2.mastodon.network[0].fixed_ip_v4
}
output "debugIP" {
  value = openstack_compute_instance_v2.mastodon.network[0].fixed_ip_v4
}


