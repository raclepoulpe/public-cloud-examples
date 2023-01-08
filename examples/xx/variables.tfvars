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
  name   = "pciex-xx-data"
  region = "GRA7"
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

# Minecraft Server

mc_server = {
    url = "https://piston-data.mojang.com/v1/objects/c9df48efed58511cdd0213c56b9013a7b5c9ac1f/server.jar"
}
