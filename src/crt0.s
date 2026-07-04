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
    // --- Copy .data from ROM to EWRAM ---
    ldr r0, =_data_lma      // source: ROM load address
    ldr r1, =_data          // destination: EWRAM runtime address
    ldr r2, =_data_end       // end of .data in RAM
copy_data_loop:
    cmp r1, r2
    bge copy_data_done
    ldr r3, [r0], #4
    str r3, [r1], #4
    b copy_data_loop
copy_data_done:

    // --- Zero .bss ---
    ldr r0, =_bss_start
    ldr r1, =_bss_end
    mov r2, #0
zero_bss_loop:
    cmp r0, r1
    bge zero_bss_done
    str r2, [r0], #4
    b zero_bss_loop
zero_bss_done:



    // --- Set User Stack Pointer ---
    ldr sp, =0x03007F00

    // --- Switch to thumb mode and branch to main ---
    add r0, pc, #1
    bx r0
    .thumb

    // --- Jump to main ---
    ldr r0, =main
    bx r0
