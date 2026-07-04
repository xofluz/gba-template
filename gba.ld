ENTRY(_start)

MEMORY {
    rom   (rx) : ORIGIN = 0x08000000, LENGTH = 32M
    iwram (rw) : ORIGIN = 0x03000000, LENGTH = 32K
    ewram (rw) : ORIGIN = 0x02000000, LENGTH = 256K
}

SECTIONS {
    .text : {
        *crt0.o(.text)
        *(.text)
    } > rom

    .rodata : { *(.rodata) } > rom

    .data : {
        _data = .;
        *(.data)
        _data_end = .;
    } > ewram AT > rom
    _data_lma = LOADADDR(.data);

    .bss (NOLOAD) : {
        _bss_start = .;
        *(.bss)
        *(COMMON)
        _bss_end = .;
    } > ewram

    /DISCARD/ : { *(.comment) *(.ARM.attributes) }
}
