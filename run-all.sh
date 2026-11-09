#!/bin/sh
# Builds and runs every example and compares the output with expected_output.txt.
#
#   ./run-all.sh                  all examples
#   ./run-all.sh 12 json          only the folders whose name contains one of the words
#   ./run-all.sh --update [...]   write expected_output.txt from the current output (check the diff!)
#
# The compiler is $ZEVIC (default: zevic on PATH). A folder is a package: zevic.toml, src/**/*.zev,
# optional native/*.c|*.cpp (linked in), optional args.txt (program arguments on one line) and
# input.txt (standard input). A file `mode` that contains `test` runs the `test` blocks instead
# (zevic --test). A folder with run.sh is run as `sh run.sh "$ZEVIC"` (used for libraries and
# other-language hosts). Every example runs in a scratch copy of its folder.
set -u
ZEVIC=${ZEVIC:-zevic}
ROOT=$(cd "$(dirname "$0")" && pwd)
UPDATE=0
if [ "${1:-}" = "--update" ]; then UPDATE=1; shift; fi
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
pass=0; fail=0; failed=""

for dir in "$ROOT"/[0-9]*/; do
    name=$(basename "$dir")
    [ -f "$dir/zevic.toml" ] || continue
    if [ $# -gt 0 ]; then
        hit=0; for w in "$@"; do case "$name" in *"$w"*) hit=1 ;; esac; done
        [ $hit = 1 ] || continue
    fi
    work="$TMP/$name"
    rm -rf "$work"; cp -R "$dir" "$work"
    out="$TMP/$name.out"
    (
        cd "$work" || exit 1
        if [ -f run.sh ]; then
            ZEVIC="$ZEVIC" sh run.sh "$ZEVIC"
        else
            srcs=$(find src -name '*.zev' | sort)
            native=""
            [ -d native ] && native=$(find native \( -name '*.c' -o -name '*.cpp' \) | sort)
            flags=""
            [ -f mode ] && grep -q test mode && flags="--test"
            # shellcheck disable=SC2086
            "$ZEVIC" $flags $srcs $native -o "$work/prog" || exit 1
            args=""; [ -f args.txt ] && args=$(cat args.txt)
            if [ -f input.txt ]; then
                # shellcheck disable=SC2086
                "$work/prog" $args < input.txt
            else
                # shellcheck disable=SC2086
                "$work/prog" $args < /dev/null
            fi
        fi
    ) > "$out" 2> "$TMP/$name.err"
    code=$?
    tr -d '\r' < "$out" > "$out.n"
    if [ $UPDATE = 1 ] && [ $code = 0 ]; then
        cp "$out.n" "$dir/expected_output.txt"
        echo "updated $name"; pass=$((pass + 1)); continue
    fi
    if [ $code = 0 ] && cmp -s "$out.n" "$dir/expected_output.txt"; then
        echo "ok    $name"; pass=$((pass + 1))
    else
        echo "FAIL  $name (exit $code)"; fail=$((fail + 1)); failed="$failed $name"
        diff "$dir/expected_output.txt" "$out.n" 2>/dev/null | head -8
        head -8 "$TMP/$name.err"
    fi
done
echo
echo "$pass passed, $fail failed"
[ $fail = 0 ]
