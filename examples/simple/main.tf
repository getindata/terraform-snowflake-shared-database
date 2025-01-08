module "snowflake_shared_database" {
  source = "../.."

  name       = "shared_database"
  from_share = var.from_share
}
