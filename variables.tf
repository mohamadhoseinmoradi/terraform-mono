
variable "profile" {
  type    = string
  default = "default"
}

variable "region-main" {
  type    = string
  default = "us-east-1"
}

variable "instance-type" {
  type = string
}

variable "instance-count" {
  type = number
}