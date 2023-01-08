data "openstack_blockstorage_volume_v3" "bs" {
  region = var.bs.region
  name   = var.bs.name
}
