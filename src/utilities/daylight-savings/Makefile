CC=gcc
CCARGS=-std=c99 -Wall -pedantic -c
LD=gcc
LDARGS=
LIBS=

EXE_FILE=daylight-savings
OBJ_FILES=daylight-savings.o

all: $(OBJ_FILES)
	$(LD) $(LDARGS) -o $(EXE_FILE) $(OBJ_FILES) $(LIBS)

clean:
	rm -Rf $(OBJ_FILES) $(EXE_FILE)

%.o: %.c
	$(CC) $(CCARGS) -o $@ $<
