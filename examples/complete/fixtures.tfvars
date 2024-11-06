context_templates = {
  snowflake-shared-database      = "{{.environment}}_{{.name}}"
  snowflake-shared-database-role = "{{.environment}}_{{.database}}_{{.name}}"
}
