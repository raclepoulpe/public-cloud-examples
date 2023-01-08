# Region

region = "GRA7"

# SSH Keypair

keypair = {
  name                 = "myMainKeypair"
  main_region          = "GRA7"
  to_reproduce_regions = []
  keys_path            = "."
}

# Block Storage

bs = {
  name   = "data"
  region = "GRA7"
  size   = "100"
}

# Instance

instance = {
  region       = "GRA7"
  network_name = "Ext-Net"
  keypair_name = "myMainKeypair"
  name         = "server"
  flavor       = "b2-7"
  image        = "Ubuntu 20.04"
  user         = "ubuntu"
}
