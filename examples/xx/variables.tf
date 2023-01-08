# Region

variable "region" {
  description = "Region"
  type        = string
}

# SSH keypair

variable "keypair" {
  description = "Keypair"
  type = object({
    name                 = string
    main_region          = string
    to_reproduce_regions = list(string)
    keys_path            = string
  })
}

# Block Storage

variable "bs" {
  description = "Block Storage Parameters"
  type = object({
    name   = string
    region = string
  })
}

# Instance

variable "instance" {
  description = "Instance Parameters"
  type = object({
    region       = string
    network_name = string
    keypair_name = string
    name         = string
    flavor       = string
    image        = string
    user         = string
  })
}

# Minecraft Server

variable "mc_server" {
  description = "Minecraft Server"
  type = object({
    url = string
  })
}
