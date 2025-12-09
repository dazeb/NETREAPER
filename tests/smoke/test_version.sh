#!/usr/bin/env bash
set -euo pipefail

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)

echo "Testing --version..."
version=$("$ROOT/netreaper" --version 2>&1)
echo "Got: $version"

if [[ "$version" == *"6.2.1"* ]]; then
    echo "PASS: version matches v6.2.1"
else
    echo "FAIL: expected to find 6.2.1 in version output"
    exit 1
fi
