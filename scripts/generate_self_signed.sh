#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
OUTPUT_DIR="$REPO_ROOT/nginx/ssl"

mkdir -p "$OUTPUT_DIR"

openssl req -x509 \
    -newkey rsa:4096 \
    -keyout "$OUTPUT_DIR/key.pem" \
    -out "$OUTPUT_DIR/cert.crt" \
    -sha256 \
    -days 365 \
    -nodes \
    -subj "/C=RU/ST=Ulyanovsk/L=Ulyanovsk/O=DevOps/CN=localhost" \
    -addext "subjectAltName=DNS:localhost,IP:127.0.0.1"

echo "Generated $OUTPUT_DIR/cert.crt and $OUTPUT_DIR/key.pem"
