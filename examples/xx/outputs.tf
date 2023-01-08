output "bs_device" {
  description = "Block Storage Device"
  value = openstack_compute_volume_attach_v2.attached.device
}
