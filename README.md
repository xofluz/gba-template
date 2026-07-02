# GBA PROJECT_NAME

Created from GBA template.

## Build

To build, run
```console
make
```

The project is built with Clang and linked with LLD. After build, the ROM is patched with [gbafix](https://github.com/rust-console/gbafix).

The final target is the file `PROJECT_NAME.gba`.

To clean up, run
```console
make clean
```
