#!/usr/bin/env bash
# NETREAPER Installer Wrapper
# Calls bin/netreaper-install with all arguments

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ ! -x "$SCRIPT_DIR/bin/netreaper-install" ]]; then
    echo "ERROR: bin/netreaper-install not found or not executable"
    exit 1
fi

exec "$SCRIPT_DIR/bin/netreaper-install" "$@"
