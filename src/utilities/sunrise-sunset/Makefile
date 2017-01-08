CC=gcc
CCARGS=-ansi -Wall -pedantic -std=c99 -c
LD=gcc
LDARGS=
LIBS=-lm

EXE_FILE=sunrise-sunset
OBJ_FILES=sunrise-sunset.o

all: $(OBJ_FILES)
	$(LD) $(LDARGS) -o $(EXE_FILE) $(OBJ_FILES) $(LIBS)

clean:
	rm -Rf $(OBJ_FILES) $(EXE_FILE)

%.o: %.c
	$(CC) $(CCARGS) -o $@ $<
