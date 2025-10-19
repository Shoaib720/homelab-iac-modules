data "aws_db_snapshot" "latest_snapshot" {
  db_instance_identifier = "homelab-postgres"
  most_recent            = true
}