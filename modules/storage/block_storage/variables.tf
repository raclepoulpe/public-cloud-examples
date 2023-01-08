# Block Storage

variable "bs" {
  description = "Block Storage Parameters"
  type = object({
    name   = string
    region = string
    size   = string
  })
}
