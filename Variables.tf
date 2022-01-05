
variable "profile" {
  type    = string
  default = "default"
}

variable "region-main" {
  type    = string
  default = "us-east-1"
}

variable "workers-count" {
  type    = number
  default = 1
}

variable "instance-type" {
  type    = string
  default = "t3.micro"
}

variable "instance-count" {
  type    = number
  default = 1

}