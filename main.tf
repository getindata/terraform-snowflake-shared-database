data "context_label" "this" {
  delimiter  = local.context_template == null ? var.name_scheme.delimiter : null
  properties = local.context_template == null ? var.name_scheme.properties : null
  template   = local.context_template

  replace_chars_regex = var.name_scheme.replace_chars_regex

  values = merge(
    var.name_scheme.extra_values,
    { name = var.name }
  )
}


resource "snowflake_shared_database" "this" {
  name       = data.context_label.this.rendered
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
moved {
  from = snowflake_shared_database.this[0]
  to   = snowflake_shared_database.this
}

module "snowflake_default_role" {
  for_each = local.default_roles

  source  = "getindata/role/snowflake"
  version = "3.1.0"

  context_templates = var.context_templates

  name = each.key
  name_scheme = merge(
    local.default_role_naming_scheme,
    lookup(each.value, "name_scheme", {})
  )
  comment = lookup(each.value, "comment", null)

  granted_to_roles = lookup(each.value, "granted_to_roles", [])
  granted_roles    = lookup(each.value, "granted_roles", [])

  account_objects_grants = {
    DATABASE = [{
      privileges  = each.value.database_grants.privileges
      object_name = snowflake_shared_database.this.name
    }]
  }
}

module "snowflake_custom_role" {
  for_each = local.custom_roles

  source  = "getindata/role/snowflake"
  version = "3.1.0"

  context_templates = var.context_templates

  name = each.key
  name_scheme = merge(
    local.default_role_naming_scheme,
    lookup(each.value, "name_scheme", {})
  )
  comment = lookup(each.value, "comment", null)

  granted_to_roles = lookup(each.value, "granted_to_roles", [])
  granted_roles    = lookup(each.value, "granted_roles", [])
  account_objects_grants = {
    DATABASE = [{
      privileges  = each.value.database_grants.privileges
      object_name = snowflake_shared_database.this.name
    }]
  }
}
