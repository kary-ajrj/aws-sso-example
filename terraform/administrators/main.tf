provider "aws" {
  region = "<VALUE>"
}

data "aws_ssoadmin_instances" "sso" {}
#IAM Identity center must be manually enabled and configured to be able to fetch the above data.
