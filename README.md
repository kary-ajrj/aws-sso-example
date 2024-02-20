# To get access to AWS :
- Create a branch in this repo.
- Add yourself to `dev_user_information` list in `users.tfvars` in `developers` directory.
- Raise a PR and await approval / merge.

# To run project pipelines on different environments / accounts :
Replace variable `ROLE_ARN` in Gitlab settings (CI/CD) with :

`STAGING_ROLE_ARN` = `arn:aws:iam::<ACCOUNT_ID>:role/GitLab_CI_OIDC`

`PRODUCTION_ROLE_ARN` = `arn:aws:iam::<ACCOUNT_ID>:role/GitLab_CI_OIDC`

Use these variables in appropriate stages / jobs of your pipeline.

# AWS SSO link:
`<VALUE>`
