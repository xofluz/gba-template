# GBA PROJECT_NAME

Created from GBA template.

## Build

To build:
```console
make
```

The project is built with Clang and linked with LLD. After build, the ROM is patched with logo and checksum using [gbafix](https://github.com/rust-console/gbafix).

The final target is the file `build/release/bin/PROJECT_NAME.gba`.

To build with debug flags for easier `objdump` inspection:
```console
make debug
```

To clean up:
```console
make clean
```

To generate compiler flags to be used by an LSP:
```console
make flags
```
