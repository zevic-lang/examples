# Zevic examples

Sample programs for the [Zevic](https://github.com/zevic-lang/zevic) language: 96 small, complete packages that
build with the current compiler (0.4.x) and print the same output on Linux, macOS and Windows. Each folder has an
`expected_output.txt`, and CI runs every example and compares the output.

Each folder is a package in the layout that `zevpm new` creates:

```
01-hello/
  zevic.toml
  src/Main.zev
  native/            optional: C / C++ files that are built and linked in
  expected_output.txt
```

## Running

You need the Zevic compiler (`zevic`, and `zevpm` for example 50). See the
[main repository](https://github.com/zevic-lang/zevic) for how to build it: `make` is enough, and it needs only
`clang`.

```
cd 01-hello
zevpm run
zevpm run -- arg1 arg2     # pass arguments to Main
zevpm test                 # run the test blocks (10-test)
```

Or compile files directly: `zevic src/Main.zev -o hello`.

To build and run everything and compare with the expected output:

```
ZEVIC=/path/to/zevic ./run-all.sh              # all examples
./run-all.sh 12 json                           # folders whose name contains 12 or json
./run-all.sh --update 33                       # rewrite expected_output.txt (check the diff)
```

The examples in `90`-`96` also use a C, C++, Rust or Go toolchain when one is installed; without `rustc` or `go`,
95 and 96 print their expected output instead. To add an example, read [CONTRIBUTING.md](CONTRIBUTING.md).

## Index

### The language

| Folder | Topic |
| --- | --- |
| `01-hello` | Hello World, command-line arguments |
| `02-variables` | `let` / `mut`, types, strings, conversions |
| `03-control-flow` | `if`, `match`, `while`, `loop`, `for` |
| `04-functions` | functions, `params`, lambdas, closures, generics |
| `05-types` | `struct`, `class`, `enum`, `interface`, generic classes |
| `06-errors` | `Result`, `?`, `Option`, `Panic` |
| `07-collections` | `Array`, `Map`, `Iterable` |
| `08-modules` | several files, `import`, `as`, public and private names |
| `09-c-interop` | `extern "C"`, `export "C"`, `native/` |
| `10-test` | `test` blocks and `_test.zev` files |
| `11-closures-defer` | closures and `defer` |
| `12-generics` | type parameters on functions, classes and structs |
| `13-interfaces` | interfaces and default methods |
| `14-union-types` | `A \| B` |
| `15-enums-match` | enums with data, `match` |
| `16-struct-vs-class` | value types and reference types |
| `17-loop-labels` | `break` / `continue` with labels |

### The standard library

| Folder | Topic |
| --- | --- |
| `18-printf-format` | `Console.Printf`, `Text.Format` |
| `19-string-builder` | `StringBuilder` |
| `20-text-processing` | `Text.*` |
| `21-chars-unicode` | UTF-8, characters and bytes |
| `22-path` | `Path` |
| `23-fs-files` | files and directories |
| `24-bytes` | `Bytes` |
| `25-encoding` | hex, Base64, percent-encoding |
| `26-digest` | CRC-32, Adler-32, SHA-256, HMAC |
| `27-datetime` | dates and times |
| `28-log` | structured logging |
| `29-cli` | command-line parsing |
| `30-regex` | regular expressions |
| `31-csv` `32-toml` `33-json` | data formats |
| `34-tcp-echo` `35-udp` `36-http-loopback` | networking on the loopback interface |
| `37-async-channels` `38-mutex-counter` | tasks, channels, mutexes |
| `39-random-seeded` `40-time-measure` | random numbers, durations |
| `41-process` `42-env` | running programs, the environment |
| `43-deflate-gzip` `44-zip` `45-tar` | compression and archives |
| `46-sets` `47-maps` `48-iterables` `49-math` | collections and math |
| `50-zevpm-package` | a package with a path dependency (`zevpm test`, `zevpm run`) |

### Algorithms and data structures

| Folder | Topic |
| --- | --- |
| `51-sorting` `52-binary-search` | sorting, searching |
| `53-primes-sieve` `54-gcd-lcm` `55-fibonacci-memo` | number theory, memoization |
| `56-n-queens` `57-sudoku-solver` `58-maze-bfs` | backtracking, search |
| `59-dijkstra` `60-union-find` | graphs |
| `61-linked-list` `62-binary-tree` `63-priority-queue` `64-trie` `65-lru-cache` | data structures |
| `66-matrix` `67-game-of-life` `68-mandelbrot-ascii` | numbers and grids |
| `69-hanoi-permutations` `70-knapsack-dp` `71-levenshtein-lcs` `72-roman-base-conversion` | recursion, dynamic programming, strings |

### Programs

| Folder | Topic |
| --- | --- |
| `73-rpn-calculator` `74-expression-parser` `75-brainfuck` | small interpreters |
| `76-wc-clone` `77-grep-clone` `78-hexdump` | command-line tools |
| `79-json-pretty` `80-csv-report` `81-ini-parser` | data tools |
| `82-todo-app` `83-state-machine` `84-text-wrap` | applications |
| `85-bank-account` `86-http-router` `87-chat-protocol` `88-event-queue` `89-inventory` | models of larger programs |

### Other languages

| Folder | Topic |
| --- | --- |
| `90-c-struct` | `extern struct`, arrays of structs passed to C |
| `91-c-callback` | `qsort`, callbacks, `Handle` |
| `92-c-strings` | strings across the C boundary |
| `93-lib-for-c` | a Zevic library for a C program (`--lib --emit-header`) |
| `94-cpp-stl` | the C++ standard library behind `extern "C"` |
| `95-rust-staticlib` | calling Rust |
| `96-go-cgo-host` | a Zevic library used from Go |

## License

See the main repository.
