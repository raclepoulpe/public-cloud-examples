resource "openstack_compute_instance_v2" "mastodon" {
  name            = "mastodon"
  flavor_name     = "b2-7"
  image_name      = "Ubuntu 22.10"
  key_pair        = "keypairAdmin"
  
}

resource "openstack_compute_keypair_v2" "keypairAdmin" {
  name                  = "keypairAdmin"
  public_key		= var.keypairAdmin_publickey
}
