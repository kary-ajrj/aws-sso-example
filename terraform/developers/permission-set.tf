resource "aws_ssoadmin_permission_set" "dev_permission_set" {
  instance_arn     = tolist(data.aws_ssoadmin_instances.sso.arns)[0]
  name             = "Developers"
  session_duration = "PT8H"
}

resource "aws_ssoadmin_managed_policy_attachment" "dev_policy_1" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.sso.arns)[0]
  managed_policy_arn = "arn:aws:iam::aws:policy/AmazonAPIGatewayAdministrator"
  permission_set_arn = aws_ssoadmin_permission_set.dev_permission_set.arn
}

resource "aws_ssoadmin_managed_policy_attachment" "dev_policy_2" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.sso.arns)[0]
  managed_policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
  permission_set_arn = aws_ssoadmin_permission_set.dev_permission_set.arn
}
#You can add more policies like above, with ARN of AWS managed policies.

resource "aws_ssoadmin_account_assignment" "dev_permission_set_and_aws_account_association" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.sso.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.dev_permission_set.arn

  principal_id   = aws_identitystore_group.sso_dev_group.group_id
  principal_type = "GROUP"

  target_id   = var.target_id
  target_type = "AWS_ACCOUNT"
}
