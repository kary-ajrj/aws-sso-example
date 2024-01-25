resource "aws_identitystore_user" "sso_admin_user" {
  count             = length(var.admin_user_information)
  identity_store_id = tolist(data.aws_ssoadmin_instances.sso.identity_store_ids)[0]

  display_name = var.admin_user_information[count.index].email
  user_name    = var.admin_user_information[count.index].email

  name {
    given_name  = var.admin_user_information[count.index].first_name
    family_name = var.admin_user_information[count.index].last_name
  }

  emails {
    value = var.admin_user_information[count.index].email
  }
}

resource "aws_identitystore_group_membership" "admin_user_group_association" {
  count             = length(var.admin_user_information)
  identity_store_id = tolist(data.aws_ssoadmin_instances.sso.identity_store_ids)[0]
  group_id          = aws_identitystore_group.sso_admin_group.group_id
  member_id         = aws_identitystore_user.sso_admin_user[count.index].user_id
}
