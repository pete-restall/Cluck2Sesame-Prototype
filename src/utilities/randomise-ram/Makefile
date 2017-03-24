CC=gcc
CCARGS=-std=c99 -c
LD=gcc
LDARGS=
LIBS=

EXE_FILE=randomise-ram
OBJ_FILES=randomise-ram.o

all: $(OBJ_FILES)
	$(LD) $(LDARGS) -o $(EXE_FILE) $(OBJ_FILES) $(LIBS)

clean:
	rm -Rf $(OBJ_FILES) $(EXE_FILE)

%.o: %.c
	$(CC) $(CCARGS) -o $@ $<
