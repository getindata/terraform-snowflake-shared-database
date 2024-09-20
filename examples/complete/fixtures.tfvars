namespace = "gid"
#stage     = "example"
#environment = "dev"

descriptor_formats = {
  snowflake-role = {
    labels = ["attributes", "name"]
    format = "%v_%v"
  }
  snowflake-database = {
    labels = ["environment", "stage", "name", "attributes"]
    format = "%v_%v_%v_%v"
  }
}
