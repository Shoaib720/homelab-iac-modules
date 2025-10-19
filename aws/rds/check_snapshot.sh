#!/usr/bin/env bash
# check_snapshot.sh <db_id>
DB_ID="$1"

if [ -z "$DB_ID" ]; then
  echo '{"exists": false}'
  exit 0
fi

# Query for any existing DB snapshots
COUNT=$(aws rds describe-db-snapshots --db-instance-identifier "$DB_ID" --query 'DBSnapshots | length(@)' --output text 2>/dev/null || echo 0)

if [ "$COUNT" -gt 0 ]; then
  echo '{"exists": true}'
else
  echo '{"exists": false}'
fi
