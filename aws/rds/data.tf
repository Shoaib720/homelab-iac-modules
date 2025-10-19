data "aws_db_snapshot" "latest_snapshot" {
  count                   = 1
  db_instance_identifier = "homelab-postgres"
  most_recent            = true
}