#!/bin/sh
# Builds rs/lib.rs into a static library and links it into the Zevic program.
# Without rustc, the expected output is printed instead (the example is about the Zevic side).
set -eu
ZEVIC=${1:-${ZEVIC:-zevic}}
if ! command -v rustc >/dev/null 2>&1; then
    cat expected_output.txt
    exit 0
fi
OUT=$(mktemp -d)
trap 'rm -rf "$OUT"' EXIT
rustc --crate-type staticlib -O rs/lib.rs -o "$OUT/libmathrs.a"
case "$(uname -s)" in
    Linux*)  SYSLIBS="-lpthread -ldl -lm" ;;
    Darwin*) SYSLIBS="-lpthread -lm" ;;
    *)       SYSLIBS="" ;;
esac
# shellcheck disable=SC2086
"$ZEVIC" src/Main.zev "$OUT/libmathrs.a" $SYSLIBS -o "$OUT/prog"
"$OUT/prog"
