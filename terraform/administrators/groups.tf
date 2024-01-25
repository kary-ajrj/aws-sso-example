resource "aws_identitystore_group" "sso_admin_group" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.sso.identity_store_ids)[0]
  display_name      = "admin-group"
}
