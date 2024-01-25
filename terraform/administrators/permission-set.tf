resource "aws_ssoadmin_permission_set" "admin_permission_set" {
  instance_arn     = tolist(data.aws_ssoadmin_instances.sso.arns)[0]
  name             = "SystemAdministrators"
  session_duration = "PT8H"
}

resource "aws_ssoadmin_managed_policy_attachment" "admin_policy_1" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.sso.arns)[0]
  managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  permission_set_arn = aws_ssoadmin_permission_set.admin_permission_set.arn
}

resource "aws_ssoadmin_account_assignment" "admin_permission_set_and_aws_account_association" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.sso.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.admin_permission_set.arn

  principal_id   = aws_identitystore_group.sso_admin_group.group_id # Group
  principal_type = "GROUP"

  target_id   = var.target_id   # Account ID
  target_type = "AWS_ACCOUNT"
  # target_type = "AWS_OU"      #incase you want to target OU.
}
