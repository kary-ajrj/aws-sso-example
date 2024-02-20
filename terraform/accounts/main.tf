provider "aws" {
  region = "<VALUE>"
}

resource "aws_organizations_account" "stage_account" {
  name  = "Staging"
  email = "value+stage@technogise.com"
  close_on_deletion = true
}

resource "aws_organizations_account" "pipeline_account" {
  name  = "CI"
  email = "value+pipeline@technogise.com"
  close_on_deletion = true
}
