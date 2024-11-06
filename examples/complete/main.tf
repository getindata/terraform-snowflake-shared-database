resource "snowflake_user" "this" {
  name = "SAMPLE_USER"
}

resource "snowflake_account_role" "this" {
  name = "SAMPLE_ROLE"
}

module "snowflake_shared_database" {
  source = "../.."

  name              = "shared_database"
  context_templates = var.context_templates
  from_share        = var.from_share

  comment                    = "Sample shared Database"
  replace_invalid_characters = true
  default_ddl_collation      = "UTF8"
  log_level                  = "INFO"
  trace_level                = "ON_EVENT"

  suspend_task_after_num_failures               = 1
  task_auto_retry_attempts                      = 1
  user_task_managed_initial_warehouse_size      = "X-Small"
  user_task_minimum_trigger_interval_in_seconds = 300
  user_task_timeout_ms                          = 200
  quoted_identifiers_ignore_case                = true
  enable_console_output                         = true

  create_default_roles = true

  roles = {
    readonly = {
      comment          = "Read-only role"
      granted_roles    = [resource.snowflake_account_role.this.name]
      granted_to_users = [resource.snowflake_user.this.name]
    }
    custom = {
      database_grants = {
        privileges = ["IMPORTED PRIVILEGES"]
      }
    }
  }
}
