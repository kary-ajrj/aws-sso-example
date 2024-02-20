resource "aws_identitystore_group" "sso_read_group" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.sso.identity_store_ids)[0]
  display_name      = "read-group"
}


resource "aws_ssoadmin_permission_set" "read_permission_set" {
  instance_arn     = tolist(data.aws_ssoadmin_instances.sso.arns)[0]
  name             = "ReadOnly"
  session_duration = "PT8H"
}

resource "aws_ssoadmin_managed_policy_attachment" "read_policy" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.sso.arns)[0]
  #  managed_policy_arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
  managed_policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  permission_set_arn = aws_ssoadmin_permission_set.read_permission_set.arn
}

resource "aws_ssoadmin_account_assignment" "read_permission_set_and_aws_account_association" {
  count              = length(var.read_target_id)
  instance_arn       = tolist(data.aws_ssoadmin_instances.sso.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.read_permission_set.arn

  principal_id   = aws_identitystore_group.sso_read_group.group_id
  principal_type = "GROUP"

  target_id   = var.read_target_id[count.index]
  target_type = "AWS_ACCOUNT"
}

resource "aws_identitystore_group_membership" "read_user_group_association" {
  count             = length(var.dev_user_information)
  identity_store_id = tolist(data.aws_ssoadmin_instances.sso.identity_store_ids)[0]
  group_id          = aws_identitystore_group.sso_read_group.group_id
  member_id         = aws_identitystore_user.sso_dev_user[count.index].user_id
}
