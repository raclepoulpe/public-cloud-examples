output "volume_id" {
  description = "Block Storage Volume Id"
  value = openstack_blockstorage_volume_v3.bs_volume.id
}
