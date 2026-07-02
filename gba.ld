ENTRY(_start)

MEMORY {
    rom (rx) : ORIGIN = 0x08000000, LENGTH = 32M
}

SECTIONS {
    .text : {
        *crt0.o(.text)
        *(.text)
    } > rom
    .rodata : { *(.rodata) } > rom
    .data : { *(.data) } > rom
    /DISCARD/ : { *(.comment) *(.ARM.attributes) }
}
