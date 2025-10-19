data "external" "rds_snapshot_exists" {
  program = ["bash", "${path.module}/check_snapshot.sh", "${var.rds_instance_name}"]
}

data "aws_db_snapshot" "latest_snapshot" {
  count                  = data.external.rds_snapshot_exists.result["exists"] == "true" ? 1 : 0
  db_instance_identifier = var.rds_instance_name
  most_recent            = true
}