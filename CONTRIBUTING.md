# Writing an example

An example is a folder `NN-topic/` (two digits, lower-case words joined by `-`) that holds a package:

```
NN-topic/
  zevic.toml            name = "PascalCase", version = "0.4.1", kind = "bin", zevic = ">=0.4"
  src/Main.zev          module Main, public fn Main(); more files under src/ are fine
  native/*.c|*.cpp      optional: C or C++ files that are linked in
  args.txt              optional: program arguments, one line
  input.txt             optional: standard input
  mode                  optional: the word `test` runs the `test` blocks (zevic --test)
  run.sh                optional: custom build and run (libraries, other-language hosts); called as `sh run.sh "$ZEVIC"`
  expected_output.txt   what the program prints (stdout only)
```

Rules

- Every example must build with the current compiler and print the same bytes on Linux, macOS and Windows: no times, dates of "now", random numbers without a fixed seed, process ids, absolute paths, port numbers, or hash-map iteration order in the output. Use a scratch directory from `Fs.MakeTempDir` for files and remove it at the end. Servers listen on `127.0.0.1` port `0`.
- The program runs in a scratch copy of its folder, so it may create files in the current directory, but should clean up.
- Comments are in English and say what the example shows. Start `Main.zev` with a short comment block: what it demonstrates and which library modules it uses. Keep it readable: 30 to 150 lines is typical.
- Formatting is `zevfmt -w .` clean.
- Run `./run-all.sh --update NN-topic` once, read the output and check that it is right, then commit `expected_output.txt` with the example.
- No placeholder programs. An example teaches one thing and runs.
