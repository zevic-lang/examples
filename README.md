# Zevic examples

Sample programs for the [Zevic](https://github.com/zevic-lang) language.

> **Status: draft.** There is no compiler yet. These programs are written against the language specification (draft) and have never been compiled. If a sample and the specification disagree, fix the specification first, then the sample.

Each folder is a package in the layout that `zevpm new` creates:

```
01-hello/
  zevic.toml
  src/Main.zev
```

## Index

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

## Running (once the tools exist)

```
cd 01-hello
zevpm run
zevpm run -- arg1 arg2     # pass arguments to Main
zevpm test                 # run test blocks (10-test)
```

Or compile a single file directly:

```
zevic src/Main.zev -o hello
```
