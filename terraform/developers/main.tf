provider "aws" {
  region = "<VALUE>"
}

data "aws_ssoadmin_instances" "sso" {}
