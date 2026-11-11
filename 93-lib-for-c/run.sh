#!/bin/sh
# Builds the Zevic library as a static archive + header, then a C program that uses it.
# usage: sh run.sh [path-to-zevic]
set -eu
ZEVIC=${1:-${ZEVIC:-zevic}}
OUT=$(mktemp -d)
trap 'rm -rf "$OUT"' EXIT

"$ZEVIC" src/TextStats.zev --lib --emit-header "$OUT/textstats.h" -o "$OUT/libtextstats.a"

CC=${CC:-clang}
command -v "$CC" >/dev/null 2>&1 || CC=cc
"$CC" -I"$OUT" host.c "$OUT/libtextstats.a" -lpthread -lm -o "$OUT/host"
"$OUT/host"
