provider "aws" {
  region = var.aws-region
}

provider "aws" {
  region = var.aws-region
  alias = "us_east"
}