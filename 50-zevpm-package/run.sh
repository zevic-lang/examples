#!/bin/sh
# Runs the dependency's tests, then builds and runs the program with zevpm.
# usage: sh run.sh [path-to-zevic]
set -eu
ZEVIC=${1:-${ZEVIC:-zevic}}
ZEVIC_DIR=$(dirname "$(command -v "$ZEVIC" 2>/dev/null || echo "$ZEVIC")")
# zevpm is next to the compiler (zevpm, or zevpm2 in a source build) or on PATH
ZEVPM=
for c in "$ZEVIC_DIR/zevpm" "$ZEVIC_DIR/zevpm2" "$ZEVIC_DIR/zevpm.exe" "$ZEVIC_DIR/zevpm2.exe"; do
    [ -x "$c" ] && ZEVPM=$c && break
done
[ -n "$ZEVPM" ] || ZEVPM=zevpm
export ZEVIC

echo "== zevpm test (greeter)"
(cd greeter && "$ZEVPM" test)
echo "== zevpm run"
"$ZEVPM" run
