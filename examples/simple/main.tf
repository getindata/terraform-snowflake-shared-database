module "snowflake_shared_database" {
  source = "../.."

  name       = "SHARED_DATABASE"
  from_share = var.from_share
}
