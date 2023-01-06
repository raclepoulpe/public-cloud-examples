// Openstack project Id

variable "serviceName" {
  type = string
}

// Region

variable "region" {
  type = string
}

// Key to access instances

variable "keypairAdmin" {
  type = string
}

// Database

variable "dbRegion" {
  type = string
}

variable "dbDescription" {
  type = string
}

variable "dbEngine" {
  type = string
}

variable "dbVersion" {
  type = string
}

variable "dbPlan" {
  type = string
}

variable "dbFlavor" {
  type = string
}

// Database User

variable "dbUserName" {
  type = string
}

variable "dbUserRole" {
  type = list(any)
}