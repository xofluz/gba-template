# --- Paths and Tools ---
CC       = clang
LLD      = /opt/homebrew/opt/lld/bin/ld.lld
OBJCOPY  = /opt/homebrew/opt/llvm/bin/llvm-objcopy
GBAFIX   = gbafix

# --- Directories ---
SRCDIR   = src
INCDIR   = include
OBJDIR   = obj

# --- Flags ---
ARCHFLAGS = -target arm-none-eabi -mcpu=arm7tdmi
CFLAGS    = -Wall $(ARCHFLAGS) -mthumb -ffreestanding -I$(INCDIR) -O2

# --- Targets and Files ---
TARGET = PROJECT_NAME.gba
ELF    = PROJECT_NAME.elf
CSRCS   = $(wildcard $(SRCDIR)/*.c)
SSRCS   = $(wildcard $(SRCDIR)/*.s)
OBJS    = $(CSRCS:$(SRCDIR)/%.c=$(OBJDIR)/%.o) $(SSRCS:$(SRCDIR)/%.s=$(OBJDIR)/%.o)

# --- Standard Rule ---
all: $(TARGET)

$(TARGET): $(ELF)
	$(OBJCOPY) -O binary $(ELF) $(TARGET)
	$(GBAFIX) $(TARGET)

$(ELF): $(OBJS)
	$(LLD) -T gba.ld $(OBJS) -o $(ELF)

$(OBJDIR)/%.o: $(SRCDIR)/%.c | $(OBJDIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJDIR)/%.o: $(SRCDIR)/%.s | $(OBJDIR)
	$(CC) $(ARCHFLAGS) -c $< -o $@

$(OBJDIR):
	mkdir -p $(OBJDIR)

# --- Cleanup ---
clean:
	rm -rf $(OBJDIR) $(ELF) $(TARGET)

.PHONY: all clean
