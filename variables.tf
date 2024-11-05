variable "name" {
  description = "Name of the resource"
  type        = string
}

variable "from_share" {
  description = "A fully qualified path to a share from which the database will be created. A fully qualified path follows the format of `<organization_name>.<account_name>.<share_name>`"
  type        = string
}

variable "comment" {
  description = "Specifies a comment for the database"
  type        = string
  default     = null
}

variable "external_volume" {
  description = "The database parameter that specifies the default external volume to use for Iceberg tables"
  type        = string
  default     = null
}

variable "catalog" {
  description = "The database parameter that specifies the default catalog to use for Iceberg tables"
  type        = string
  default     = null
}

variable "replace_invalid_characters" {
  description = "If true, invalid characters are replaced with the replacement character"
  type        = bool
  default     = null
}

variable "default_ddl_collation" {
  description = "Specifies a default collation specification for all schemas and tables added to the database."
  type        = string
  default     = null
}

variable "storage_serialization_policy" {
  description = "The storage serialization policy for Iceberg tables that use Snowflake as the catalog. Valid options are: [COMPATIBLE OPTIMIZED]"
  type        = string
  default     = null
}

variable "log_level" {
  description = "Specifies the severity level of messages that should be ingested and made available in the active event table. Valid options are: [TRACE DEBUG INFO WARN ERROR FATAL OFF]"
  type        = string
  default     = null
}

variable "trace_level" {
  description = "Controls how trace events are ingested into the event table. Valid options are: [ALWAYS ON_EVENT OFF]"
  type        = string
  default     = null
}

variable "suspend_task_after_num_failures" {
  description = "How many times a task must fail in a row before it is automatically suspended. 0 disables auto-suspending"
  type        = number
  default     = null
}

variable "task_auto_retry_attempts" {
  description = "Maximum automatic retries allowed for a user task"
  type        = number
  default     = null
}

variable "user_task_managed_initial_warehouse_size" {
  description = "The initial size of warehouse to use for managed warehouses in the absence of history"
  type        = string
  default     = null
}

variable "user_task_minimum_trigger_interval_in_seconds" {
  description = "Minimum amount of time between Triggered Task executions in seconds"
  type        = number
  default     = null
}

variable "user_task_timeout_ms" {
  description = "User task execution timeout in milliseconds"
  type        = number
  default     = null
}

variable "quoted_identifiers_ignore_case" {
  description = "If true, the case of quoted identifiers is ignored"
  type        = bool
  default     = null
}

variable "enable_console_output" {
  description = "If true, enables stdout/stderr fast path logging for anonymous stored procedures"
  type        = bool
  default     = null
}

variable "create_default_roles" {
  description = "Whether the default roles should be created"
  type        = bool
  default     = false
}

variable "roles" {
  description = "Account roles created on the Shared Database level"
  type = map(object({
    name_scheme = optional(object({
      properties            = optional(list(string))
      delimiter             = optional(string)
      context_template_name = optional(string)
      replace_chars_regex   = optional(string)
      extra_labels          = optional(map(string))
    }))
    comment              = optional(string)
    role_ownership_grant = optional(string)
    granted_roles        = optional(list(string))
    granted_to_roles     = optional(list(string))
    granted_to_users     = optional(list(string))
    database_grants = optional(object({
      privileges = optional(list(string))
    }))
  }))
  default = {}
}

variable "name_scheme" {
  description = <<EOT
  Naming scheme configuration for the resource. This configuration is used to generate names using context provider:
    - `properties` - list of properties to use when creating the name - is superseded by `var.context_templates`
    - `delimiter` - delimited used to create the name from `properties` - is superseded by `var.context_templates`
    - `context_template_name` - name of the context template used to create the name
    - `replace_chars_regex` - regex to use for replacing characters in property-values created by the provider - any characters that match the regex will be removed from the name
    - `extra_values` - map of extra label-value pairs, used to create a name
  EOT
  type = object({
    properties            = optional(list(string), ["environment", "name"])
    delimiter             = optional(string, "_")
    context_template_name = optional(string, "snowflake-shared-database")
    replace_chars_regex   = optional(string, "[^a-zA-Z0-9_]")
    extra_values          = optional(map(string))
  })
  default = {}
}

variable "context_templates" {
  description = "Map of context templates used for naming conventions - this variable supersedes `naming_scheme.properties` and `naming_scheme.delimiter` configuration"
  type        = map(string)
  default     = {}
}
