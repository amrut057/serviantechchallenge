variable "rg_name" {
  type = string
  default = "servian-techchallenge-rg"
}

variable "location" {
  type = string
  default = "AustraliaEast"
}

variable "pg_server_name" {
  type = string
  default = "techchallenge-postgress-server"
}

variable "sku_name" {
  type = string
  default = "B_Gen5_1"
}

variable "pg_version" {
  type = number
  default = 9.5
}

variable "dbuser" {
  type = string
  default = "postgres"
}

variable "dbpassword" {
  type = string
}

variable "container_grp_name" {
  type = string
  default = "techchallenge-containers-grp"
}

variable "container_name" {
  type = string
  default = "techchallenge-container"
}

variable "image" {
  type = string
  default = "servian/techchallengeapp:latest"
}

variable "cpu" {
  type = string
  default = "1.0"
}

variable "memory" {
  type = string
  default = "1.5"
}