# --- Paths and Tools ---
CC       = clang
LLD      = /opt/homebrew/opt/lld/bin/ld.lld
OBJCOPY  = /opt/homebrew/opt/llvm/bin/llvm-objcopy
GBAFIX   = gbafix

# --- Directories ---
SRCDIR   = src
INCDIR   = include

BUILDDIR = build
MODE    ?= release

OBJDIR   = $(BUILDDIR)/$(MODE)/obj
BINDIR   = $(BUILDDIR)/$(MODE)/bin

DEBUG_FLAGS = -g -O0
ifeq ($(MODE),debug)
CFLAGS += $(DEBUG_FLAGS)
endif

# --- Flags ---
ARCHFLAGS = -target arm-none-eabi -mcpu=arm7tdmi
CFLAGS    = -Wall $(ARCHFLAGS) -mthumb -ffreestanding -I$(INCDIR) -Os

# --- Targets and Files ---
TARGET  = $(BINDIR)/hello.gba
ELF     = $(BINDIR)/hello.elf
CSRCS   = $(wildcard $(SRCDIR)/*.c)
SSRCS   = $(wildcard $(SRCDIR)/*.s)
OBJS    = $(CSRCS:$(SRCDIR)/%.c=$(OBJDIR)/%.o) $(SSRCS:$(SRCDIR)/%.s=$(OBJDIR)/%.o)

# --- Standard Rule ---
all: $(TARGET)

debug:
	$(MAKE) MODE=debug

$(TARGET): $(ELF) | $(BINDIR)
	$(OBJCOPY) -O binary $(ELF) $(TARGET)
	$(GBAFIX) $(TARGET)

$(ELF): $(OBJS) | $(BINDIR)
	$(LLD) -T gba.ld $(OBJS) -o $(ELF)

$(BINDIR):
	mkdir -p $(BINDIR)

$(OBJDIR)/%.o: $(SRCDIR)/%.c | $(OBJDIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJDIR)/%.o: $(SRCDIR)/%.s | $(OBJDIR)
	$(CC) $(ARCHFLAGS) -c $< -o $@

$(OBJDIR):
	mkdir -p $(OBJDIR)

# --- Cleanup ---
clean:
	rm -rf $(BUILDDIR)

# --- Compile flags for LSP ---
flags:
	echo $(CFLAGS) $(DEBUG_FLAGS) | sed -e 's/ /\n/g' > compile_flags.txt

.PHONY: all debug clean flags
