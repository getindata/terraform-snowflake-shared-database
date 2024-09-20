module "database_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"
  context = module.this.context

  delimiter           = coalesce(module.this.context.delimiter, "_")
  regex_replace_chars = coalesce(module.this.context.regex_replace_chars, "/[^_a-zA-Z0-9]/")
  label_value_case    = coalesce(module.this.context.label_value_case, "upper")
}

resource "snowflake_shared_database" "this" {
  count = module.this.enabled ? 1 : 0

  name       = local.name_from_descriptor
  from_share = var.from_share
  comment    = var.comment

  catalog                                       = var.catalog
  default_ddl_collation                         = var.default_ddl_collation
  enable_console_output                         = var.enable_console_output
  external_volume                               = var.external_volume
  log_level                                     = var.log_level
  quoted_identifiers_ignore_case                = var.quoted_identifiers_ignore_case
  replace_invalid_characters                    = var.replace_invalid_characters
  storage_serialization_policy                  = var.storage_serialization_policy
  suspend_task_after_num_failures               = var.suspend_task_after_num_failures
  task_auto_retry_attempts                      = var.task_auto_retry_attempts
  trace_level                                   = var.trace_level
  user_task_managed_initial_warehouse_size      = var.user_task_managed_initial_warehouse_size
  user_task_minimum_trigger_interval_in_seconds = var.user_task_minimum_trigger_interval_in_seconds
  user_task_timeout_ms                          = var.user_task_timeout_ms
}

module "snowflake_default_role" {
  for_each = local.default_roles

  source  = "getindata/role/snowflake"
  version = "2.1.0"
  context = module.this.context

  name            = each.key
  comment         = lookup(each.value, "comment", null)
  enabled         = local.create_default_roles && lookup(each.value, "enabled", true)
  attributes      = [one(snowflake_shared_database.this[*].name)]
  descriptor_name = lookup(each.value, "descriptor_name", "snowflake-role")

  granted_to_roles = lookup(each.value, "granted_to_roles", [])
  granted_roles    = lookup(each.value, "granted_roles", [])

  account_objects_grants = {
    DATABASE = [{
      privileges  = each.value.database_grants.privileges
      object_name = one(snowflake_shared_database.this[*].name)
    }]
  }

  depends_on = [
    snowflake_shared_database.this
  ]
}

module "snowflake_custom_role" {
  for_each = local.custom_roles

  source  = "getindata/role/snowflake"
  version = "2.1.0"
  context = module.this.context

  name            = each.key
  comment         = lookup(each.value, "comment", null)
  enabled         = module.this.enabled && lookup(each.value, "enabled", true)
  attributes      = [one(snowflake_shared_database.this[*].name)]
  descriptor_name = lookup(each.value, "descriptor_name", "snowflake-role")

  granted_to_roles = lookup(each.value, "granted_to_roles", [])
  granted_roles    = lookup(each.value, "granted_roles", [])
  account_objects_grants = {
    DATABASE = [{
      privileges  = each.value.database_grants.privileges
      object_name = one(snowflake_shared_database.this[*].name)
    }]
  }

  depends_on = [
    snowflake_shared_database.this
  ]
}
