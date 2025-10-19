data "aws_db_snapshot" "latest_snapshot" {
  count                  = local.snapshot_id != "" ? 1 : 0
  db_instance_identifier = var.rds_instance_name
  most_recent            = true
}