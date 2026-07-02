.section .text
.global _start
.extern main
_start:
    b rom_header_end        // 0x0000: Branch to main function (4 bytes)
    .fill 156, 1, 0         // 0x0004: Placeholder for logo (156 bytes)
    .ascii "MWE GAME    "   // 0x00A0: Game Title (12 bytes)
    .ascii "TEST"           // 0x00AC: Game Code (4 bytes)
    .ascii "01"             // 0x00B0: Maker Code (2 bytes)
    .byte 0x96              // 0x00B2: Fast GBA byte (1 byte)
    .byte 0x00              // 0x00B3: Main unit code (1 byte)
    .byte 0x00              // 0x00B4: Device type (1 byte)
    .fill 7, 1, 0           // 0x00B5: Reserved space (7 bytes)
    .byte 0x00              // 0x00BC: Software version (1 byte)
    .byte 0x00              // 0x00BD: Placeholder for checksum (1 byte)
    .fill 2, 1, 0           // 0x00BE: Reserved space (2 bytes)

rom_header_end:
    // --- Set User Stack Pointer ---
    ldr sp, =0x03007F00

    // --- Switch to thumb mode and branch to main ---
    add r0, pc, #1
    bx r0
    .thumb

    // --- Jump to main ---
    ldr r0, =main
    bx r0
