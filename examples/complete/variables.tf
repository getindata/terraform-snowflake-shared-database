variable "from_share" {
  description = "A fully qualified path to a share from which the database will be created. A fully qualified path follows the format of `<organization_name>.<account_name>.<share_name>`"
  type        = string
}

variable "context_templates" {
  description = "A map of context templates used to generate names"
  type        = map(string)
}
