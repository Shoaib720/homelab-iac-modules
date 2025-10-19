locals {
    snapshot_id = trimspace(
        replace(
            chomp(
                filebase64decode(
                shell("aws rds describe-db-snapshots --db-instance-identifier ${var.rds_instance_name} --query 'DBSnapshots[0].DBSnapshotIdentifier' --output text || echo 'null-base64'")
                )
            ),
            "null-base64",
            ""
        )
    )
}
