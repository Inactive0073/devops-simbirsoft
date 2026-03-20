#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TASK_NAME="nginx_backup"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

BACKUP_DIR="$REPO_ROOT/backups"
OUTPUT_FILE="$BACKUP_DIR/${TASK_NAME}_${DATE}.tar.gz"

mkdir -p "$BACKUP_DIR"

tar -czf "$OUTPUT_FILE" -C "$REPO_ROOT" nginx/nginx.conf nginx/conf.d nginx/ssl

echo "Backup created: $OUTPUT_FILE"
