# in case the SHELL variable is not set or inherited
SHELL = /bin/zsh

# clear/set suffix list
.SUFFIXES:
.SUFFIXES: .c .h .o

CC      = gcc
BINDIR  = bin
OBJDIR  = obj
SRCDIR  = src
MKDIR   = mkdir -p
RM      = rm -rf
VERIFY	= cat -e -t -v Makefile

SRC     = $(wildcard $(SRCDIR)/*.c)
OBJS    = $(patsubst $(SRCDIR)/%.c, $(OBJDIR)/%.o, $(SRC))

CFLAGS  = -Wall -g -Iinclude -std=c11 -pedantic

#executable
_BIN    = a.out
BIN     = $(addprefix $(BINDIR)/, $(_BIN))

.PHONY: all
all: $(BINDIR) $(OBJDIR) $(BIN)

# linking
$(BIN): $(OBJS) $(BINDIR)
	$(CC) -o $@ $(CFLAGS) $(OBJS)

$(BINDIR):
	$(MKDIR) $(BINDIR)

# compiling
$(OBJDIR)/%.o: $(SRCDIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJDIR):
	$(MKDIR) $(OBJDIR)

.PHONY: clean
clean:
	@echo "Cleaning things up..."
	$(RM) $(OBJDIR) $(BINDIR)
	
.PHONY: run
run:
	bin/a.out

# debugging tools
# shows tabs with ^I and line endings with $
.PHONY: verify
verify:
	$(VERIFY)

# macro outputs
print-%:
	@echo $* = $($*)
