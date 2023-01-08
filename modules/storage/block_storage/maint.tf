resource "openstack_blockstorage_volume_v3" "bs_volume" {
  region = var.bs.region
  name   = var.bs.name
  size   = var.bs.size
}
