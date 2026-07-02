#pragma once
#include <stdint.h>

// --- LCD Control (I/O Registers) ---
#define REG_DISPCNT     *(volatile uint16_t*)0x04000000

// --- LCD Size Definitions
#define LCD_WIDTH	240		// 240 dots / horizontal line
#define LCD_HEIGHT	160		// 160 dots / vertical line
#define LCD_RWIDTH	30		// Real width in tile
#define LCD_RHEIGHT	20		// Real height in tile
#define LCD_VWIDTH	32		// Virtual width in tile
#define LCD_VHEIGHT	32		// Virtual height in tile
#define LCD_TILE_BYTE	(8 * 8)		// Byte size of single tile
#define LCD_TILE_HWORD	(8 * 4)		// Half word size of single tile
#define LCD_PAL_COLORS	256		// Total color number per palette
#define BGR(r, g, b)	(((b) << 10) + ((g) << 5) + (r))

// --- Display Modes (Bits for REG_DISPCNT) ---
#define MODE_0          0x0000   // Tiled, 4 backgrounds, no scale/rotate
#define MODE_1          0x0001   // Tiled, BG0-2 (BG2 supports scale/rotate)
#define MODE_2          0x0002   // Tiled, BG2-3, both scale/rotate
#define MODE_3          0x0003   // Bitmap, 16-bit color, single buffer
#define MODE_4          0x0004   // Bitmap, 8-bit palette, double buffer
#define MODE_5          0x0005   // Bitmap, 16-bit color, double buffer, smaller res

// --- Background Enable Bits ---
#define BG0_ENABLE      0x0100
#define BG1_ENABLE      0x0200
#define BG2_ENABLE      0x0400
#define BG3_ENABLE      0x0800

// --- Object (Sprite) Enable ---
#define OBJ_ENABLE      0x1000

// --- Video Memory (VRAM addresses) ---
#define VRAM_PAGE0      ((volatile uint16_t*)0x06000000)
#define VRAM_PAGE1      ((volatile uint16_t*)0x0600A000)

// --- Color Macro (15-bit RGB: 5 bit red, 5 bit green, 5 bit blue) ---
// This macro packs three values (0-31) into one 16-bit variable for VRAM
#define RGB888_TO_RGB555(r, g, b) ((r & 0x1f) | ((g & 0x1f) << 5) | ((b & 0x1f) << 10))

#define RGB_RED         0x001F  // RGB888_TO_RGB555(31, 0, 0)
#define RGB_GREEN       0x03E0  // RGB888_TO_RGB555(0, 31, 0)
#define RGB_BLUE        0x7C00  // RGB888_TO_RGB555(0, 0, 31)

typedef uint16_t rgb555_t;   // bitmap modes 3/4/5, or palette RAM entries
typedef uint8_t  palidx_t;   // 8bpp indexed tile/sprite modes (256 colors)
