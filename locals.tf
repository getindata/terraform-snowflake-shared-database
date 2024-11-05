locals {
  context_template = lookup(var.context_templates, var.name_scheme.context_template_name, null)

  default_role_naming_scheme = {
    properties            = ["environment", "database", "name"]
    context_template_name = "snowflake-shared-database-role"
    extra_values = {
      database = var.name
    }
  }

  #This needs to be the same as an object in roles variable
  # role_template = {
  #   enabled              = true
  #   descriptor_name      = "snowflake-role"
  #   comment              = null
  #   role_ownership_grant = "SYSADMIN"
  #   granted_roles        = []
  #   granted_to_roles     = []
  #   granted_to_users     = []
  #   database_grants      = {}
  # }

  default_roles_definition = {
    readonly = {
      database_grants = {
        privileges = ["IMPORTED PRIVILEGES"]
      }
    }
  }

  provided_roles = { for role_name, role in var.roles : role_name => {
    for k, v in role : k => v
    if v != null
  } }

  roles_definition = module.roles_deep_merge.merged
  # roles_definition = {
  #   for role_name, role in module.roles_deep_merge.merged : role_name => merge(
  #     local.role_template,
  #     role
  #   )
  # }

  default_roles = {
    for role_name, role in local.roles_definition : role_name => role
    if contains(keys(local.default_roles_definition), role_name) && var.create_default_roles
  }

  custom_roles = {
    for role_name, role in local.roles_definition : role_name => role
    if !contains(keys(local.default_roles_definition), role_name)
  }

  roles = {
    for role_name, role in merge(
      module.snowflake_default_role,
      module.snowflake_custom_role
    ) : role_name => role
    if role_name != null
  }
}

module "roles_deep_merge" {
  source  = "Invicton-Labs/deepmerge/null"
  version = "0.1.5"

  maps = [local.default_roles_definition, local.provided_roles]
}
