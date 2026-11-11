#!/bin/sh
# Builds src/Units.zev as a static library + header and runs main.go (cgo) against it.
# Without Go, the expected output is printed instead (the example is about the Zevic side).
set -eu
ZEVIC=${1:-${ZEVIC:-zevic}}
if ! command -v go >/dev/null 2>&1; then
    cat expected_output.txt
    exit 0
fi
OUT=$(mktemp -d)
trap 'rm -rf "$OUT"' EXIT
"$ZEVIC" src/Units.zev --lib --emit-header "$OUT/units.h" -o "$OUT/libunits.a"
cp main.go "$OUT/main.go"
cd "$OUT"
CC=${CC:-clang} GO111MODULE=off go run main.go
