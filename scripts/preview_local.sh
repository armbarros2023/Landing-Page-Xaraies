#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
echo "Abrindo servidor local em: http://localhost:8080"
python3 -m http.server 8080
