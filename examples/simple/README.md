# Simple Example

```terraform
module "snowflake_shared_database" {
  source = "../.."

  name       = "SHARED_DATABASE"
  from_share = var.from_share
}

```

## Usage

1. Configure private sharing on producer Snowflake Account (remember that both producer and consumer accounts have to be deployed on the same Cloud Provider for. ex. AWS and in the same region for. ex. `eu-west-1`)

This step can be done manually using Snowsight UI or by running [create_share.sql](./create-share.sql) script on producer Snowflake account.

When using the script, please remember to properly define consumer account details in the last line:

```sql
ALTER SHARE sample_share ADD ACCOUNT="<orgname.accountname>";
```

2. With share configured in step 1., run terraform on consumer account using below commands

```shell
terraform init
terraform plan -out tfplan
terraform apply tfplan
```

**Please remember to pass share details (from step 1.) to `from_share` variable.**

```shell
$ terraform plan
var.from_share
  A fully qualified path to a share from which the database will be created. A fully qualified path follows the format of `<organization_name>.<account_name>.<share_name>`

  Enter a value: <orgname.accountname.sharename>
```

<!-- BEGIN_TF_DOCS -->




## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_from_share"></a> [from\_share](#input\_from\_share) | A fully qualified path to a share from which the database will be created. A fully qualified path follows the format of `<organization_name>.<account_name>.<share_name>` | `string` | n/a | yes |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_snowflake_shared_database"></a> [snowflake\_shared\_database](#module\_snowflake\_shared\_database) | ../.. | n/a |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_example_output"></a> [example\_output](#output\_example\_output) | Example output of the module |

## Providers

No providers.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_snowflake"></a> [snowflake](#requirement\_snowflake) | >= 0.95 |

## Resources

No resources.
<!-- END_TF_DOCS -->
