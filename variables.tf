
variable "profile" {
  type    = string
  default = "default"
}

variable "aws-region" {
  type    = string
  default = "us-east-1"
}

variable "ami_id" {
  type = string
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "subnet_A_cidr_block" {}
variable "subnet_B_cidr_block" {}
variable "subnet_C_cidr_block" {}

variable "instance_typee" {
  type = string
}

variable "instance_count" {
  type = number
}