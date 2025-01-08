# Snowflake Database Terraform Module
![Snowflake](https://img.shields.io/badge/-SNOWFLAKE-249edc?style=for-the-badge&logo=snowflake&logoColor=white)
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)

![License](https://badgen.net/github/license/getindata/terraform-snowflake-shared-database/)
![Release](https://badgen.net/github/release/getindata/terraform-snowflake-shared-database/)

<p align="center">
  <img height="150" src="https://getindata.com/img/logo.svg">
  <h3 align="center">We help companies turn their data into assets</h3>
</p>

---

Terraform module for Snowflake Shared Database management.

* Creates Snowflake Shared database
* Can create custom Snowflake account roles with role-to-role assignments
* Can create a set of default account roles to simplify access management:
  * `READONLY` - granted `IMPORTED_PRIVILEGES` privilege on the database

## USAGE

```terraform
module "snowflake_shared_database" {
  source = "getindata/shared-database/snowflake"
  # version  = "x.x.x"

  name       = "SHARED_DATABASE"
  from_share = "<orgname.accountname.sharename>"

  create_default_roles = true
}

```

## EXAMPLES

- [Simple](examples/simple) - Basic usage of the module
- [Complete](examples/complete) - Advanced usage of the module

<!-- BEGIN_TF_DOCS -->




## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_catalog"></a> [catalog](#input\_catalog) | The database parameter that specifies the default catalog to use for Iceberg tables | `string` | `null` | no |
| <a name="input_comment"></a> [comment](#input\_comment) | Specifies a comment for the database | `string` | `null` | no |
| <a name="input_context_templates"></a> [context\_templates](#input\_context\_templates) | Map of context templates used for naming conventions - this variable supersedes `naming_scheme.properties` and `naming_scheme.delimiter` configuration | `map(string)` | `{}` | no |
| <a name="input_create_default_roles"></a> [create\_default\_roles](#input\_create\_default\_roles) | Whether the default roles should be created | `bool` | `false` | no |
| <a name="input_default_ddl_collation"></a> [default\_ddl\_collation](#input\_default\_ddl\_collation) | Specifies a default collation specification for all schemas and tables added to the database. | `string` | `null` | no |
| <a name="input_enable_console_output"></a> [enable\_console\_output](#input\_enable\_console\_output) | If true, enables stdout/stderr fast path logging for anonymous stored procedures | `bool` | `null` | no |
| <a name="input_external_volume"></a> [external\_volume](#input\_external\_volume) | The database parameter that specifies the default external volume to use for Iceberg tables | `string` | `null` | no |
| <a name="input_from_share"></a> [from\_share](#input\_from\_share) | A fully qualified path to a share from which the database will be created. A fully qualified path follows the format of `<organization_name>.<account_name>.<share_name>` | `string` | n/a | yes |
| <a name="input_log_level"></a> [log\_level](#input\_log\_level) | Specifies the severity level of messages that should be ingested and made available in the active event table. Valid options are: [TRACE DEBUG INFO WARN ERROR FATAL OFF] | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the resource | `string` | n/a | yes |
| <a name="input_name_scheme"></a> [name\_scheme](#input\_name\_scheme) | Naming scheme configuration for the resource. This configuration is used to generate names using context provider:<br/>    - `properties` - list of properties to use when creating the name - is superseded by `var.context_templates`<br/>    - `delimiter` - delimited used to create the name from `properties` - is superseded by `var.context_templates`<br/>    - `context_template_name` - name of the context template used to create the name<br/>    - `replace_chars_regex` - regex to use for replacing characters in property-values created by the provider - any characters that match the regex will be removed from the name<br/>    - `extra_values` - map of extra label-value pairs, used to create a name<br/>    - `uppercase` - convert name to uppercase | <pre>object({<br/>    properties            = optional(list(string), ["environment", "name"])<br/>    delimiter             = optional(string, "_")<br/>    context_template_name = optional(string, "snowflake-shared-database")<br/>    replace_chars_regex   = optional(string, "[^a-zA-Z0-9_]")<br/>    extra_values          = optional(map(string))<br/>    uppercase             = optional(bool, true)<br/>  })</pre> | `{}` | no |
| <a name="input_quoted_identifiers_ignore_case"></a> [quoted\_identifiers\_ignore\_case](#input\_quoted\_identifiers\_ignore\_case) | If true, the case of quoted identifiers is ignored | `bool` | `null` | no |
| <a name="input_replace_invalid_characters"></a> [replace\_invalid\_characters](#input\_replace\_invalid\_characters) | If true, invalid characters are replaced with the replacement character | `bool` | `null` | no |
| <a name="input_roles"></a> [roles](#input\_roles) | Account roles created on the Shared Database level | <pre>map(object({<br/>    name_scheme = optional(object({<br/>      properties            = optional(list(string))<br/>      delimiter             = optional(string)<br/>      context_template_name = optional(string)<br/>      replace_chars_regex   = optional(string)<br/>      extra_labels          = optional(map(string))<br/>      uppercase             = optional(bool)<br/>    }))<br/>    comment              = optional(string)<br/>    role_ownership_grant = optional(string)<br/>    granted_roles        = optional(list(string))<br/>    granted_to_roles     = optional(list(string))<br/>    granted_to_users     = optional(list(string))<br/>    database_grants = optional(object({<br/>      privileges = optional(list(string))<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_storage_serialization_policy"></a> [storage\_serialization\_policy](#input\_storage\_serialization\_policy) | The storage serialization policy for Iceberg tables that use Snowflake as the catalog. Valid options are: [COMPATIBLE OPTIMIZED] | `string` | `null` | no |
| <a name="input_suspend_task_after_num_failures"></a> [suspend\_task\_after\_num\_failures](#input\_suspend\_task\_after\_num\_failures) | How many times a task must fail in a row before it is automatically suspended. 0 disables auto-suspending | `number` | `null` | no |
| <a name="input_task_auto_retry_attempts"></a> [task\_auto\_retry\_attempts](#input\_task\_auto\_retry\_attempts) | Maximum automatic retries allowed for a user task | `number` | `null` | no |
| <a name="input_trace_level"></a> [trace\_level](#input\_trace\_level) | Controls how trace events are ingested into the event table. Valid options are: [ALWAYS ON\_EVENT OFF] | `string` | `null` | no |
| <a name="input_user_task_managed_initial_warehouse_size"></a> [user\_task\_managed\_initial\_warehouse\_size](#input\_user\_task\_managed\_initial\_warehouse\_size) | The initial size of warehouse to use for managed warehouses in the absence of history | `string` | `null` | no |
| <a name="input_user_task_minimum_trigger_interval_in_seconds"></a> [user\_task\_minimum\_trigger\_interval\_in\_seconds](#input\_user\_task\_minimum\_trigger\_interval\_in\_seconds) | Minimum amount of time between Triggered Task executions in seconds | `number` | `null` | no |
| <a name="input_user_task_timeout_ms"></a> [user\_task\_timeout\_ms](#input\_user\_task\_timeout\_ms) | User task execution timeout in milliseconds | `number` | `null` | no |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_roles_deep_merge"></a> [roles\_deep\_merge](#module\_roles\_deep\_merge) | Invicton-Labs/deepmerge/null | 0.1.5 |
| <a name="module_snowflake_custom_role"></a> [snowflake\_custom\_role](#module\_snowflake\_custom\_role) | getindata/role/snowflake | 3.1.0 |
| <a name="module_snowflake_default_role"></a> [snowflake\_default\_role](#module\_snowflake\_default\_role) | getindata/role/snowflake | 3.1.0 |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_catalog"></a> [catalog](#output\_catalog) | The database parameter that specifies the default catalog to use for Iceberg tables |
| <a name="output_comment"></a> [comment](#output\_comment) | The comment for the database |
| <a name="output_default_ddl_collation"></a> [default\_ddl\_collation](#output\_default\_ddl\_collation) | Specifies a default collation specification for all schemas and tables added to the database. |
| <a name="output_enable_console_output"></a> [enable\_console\_output](#output\_enable\_console\_output) | If true, enables stdout/stderr fast path logging for anonymous stored procedures |
| <a name="output_external_volume"></a> [external\_volume](#output\_external\_volume) | The database parameter that specifies the default external volume to use for Iceberg tables |
| <a name="output_from_share"></a> [from\_share](#output\_from\_share) | The name of the share from which the database is created |
| <a name="output_log_level"></a> [log\_level](#output\_log\_level) | Specifies the severity level of messages that should be ingested and made available in the active event table. Valid options are: [TRACE DEBUG INFO WARN ERROR FATAL OFF] |
| <a name="output_name"></a> [name](#output\_name) | Name of the database |
| <a name="output_quoted_identifiers_ignore_case"></a> [quoted\_identifiers\_ignore\_case](#output\_quoted\_identifiers\_ignore\_case) | If true, the case of quoted identifiers is ignored |
| <a name="output_roles"></a> [roles](#output\_roles) | Snowflake Roles |
| <a name="output_storage_serialization_policy"></a> [storage\_serialization\_policy](#output\_storage\_serialization\_policy) | The storage serialization policy for Iceberg tables that use Snowflake as the catalog. Valid options are: [COMPATIBLE OPTIMIZED] |
| <a name="output_suspend_task_after_num_failures"></a> [suspend\_task\_after\_num\_failures](#output\_suspend\_task\_after\_num\_failures) | How many times a task must fail in a row before it is automatically suspended. 0 disables auto-suspending |
| <a name="output_task_auto_retry_attempts"></a> [task\_auto\_retry\_attempts](#output\_task\_auto\_retry\_attempts) | Maximum automatic retries allowed for a user task |
| <a name="output_trace_level"></a> [trace\_level](#output\_trace\_level) | Controls how trace events are ingested into the event table. Valid options are: [ALWAYS ON\_EVENT OFF] |
| <a name="output_user_task_managed_initial_warehouse_size"></a> [user\_task\_managed\_initial\_warehouse\_size](#output\_user\_task\_managed\_initial\_warehouse\_size) | The initial size of warehouse to use for managed warehouses in the absence of history |
| <a name="output_user_task_minimum_trigger_interval_in_seconds"></a> [user\_task\_minimum\_trigger\_interval\_in\_seconds](#output\_user\_task\_minimum\_trigger\_interval\_in\_seconds) | Minimum amount of time between Triggered Task executions in seconds |
| <a name="output_user_task_timeout_ms"></a> [user\_task\_timeout\_ms](#output\_user\_task\_timeout\_ms) | User task execution timeout in milliseconds |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_context"></a> [context](#provider\_context) | >=0.4.0 |
| <a name="provider_snowflake"></a> [snowflake](#provider\_snowflake) | >= 0.94.0 |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_context"></a> [context](#requirement\_context) | >=0.4.0 |
| <a name="requirement_snowflake"></a> [snowflake](#requirement\_snowflake) | >= 0.94.0 |

## Resources

| Name | Type |
|------|------|
| [snowflake_shared_database.this](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs/resources/shared_database) | resource |
| [context_label.this](https://registry.terraform.io/providers/cloudposse/context/latest/docs/data-sources/label) | data source |
<!-- END_TF_DOCS -->

## CONTRIBUTING

Contributions are very welcomed!

Start by reviewing [contribution guide](CONTRIBUTING.md) and our [code of conduct](CODE_OF_CONDUCT.md). After that, start coding and ship your changes by creating a new PR.

## LICENSE

Apache 2 Licensed. See [LICENSE](LICENSE) for full details.

## AUTHORS

<!--- Replace repository name -->
<a href="https://github.com/getindata/terraform-snowflake-shared-database/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=getindata/terraform-snowflake-shared-database" />
</a>

Made with [contrib.rocks](https://contrib.rocks).
