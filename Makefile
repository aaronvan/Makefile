# in case the SHELL variable is not set or inherited
SHELL = /bin/zsh

# clear/set suffix list
.SUFFIXES:
.SUFFIXES: .c .h .o

CC      = clang
BINDIR  = bin
OBJDIR  = obj
SRCDIR  = src
MKDIR   = mkdir -p
RM      = rm -rf
VERIFY	= cat -e -t -v Makefile

SRC     = $(wildcard $(SRCDIR)/*.c)
OBJS    = $(patsubst $(SRCDIR)/%.c, $(OBJDIR)/%.o, $(SRC))

CFLAGS  = -Wall -g -Iinclude -std=c17 -pedantic -Werror -Wextra

#executable
_BIN    = a.out
BIN     = $(addprefix $(BINDIR)/, $(_BIN))

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

clean:
	@echo "Cleaning things up..."
	$(RM) $(OBJDIR) $(BINDIR)
	
run:
	bin/a.out

# debugging tools
# shows tabs with ^I and line endings with $
verify:
	$(VERIFY)

# macro outputs
print-%:
	@echo $* = $($*)
