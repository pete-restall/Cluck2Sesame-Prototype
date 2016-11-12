CC=gcc
CCARGS=-c
LD=gcc
LDARGS=

EXE_FILE=gpsim2tuple
OBJ_FILES=gpsim2tuple.o

all: $(OBJ_FILES)
	$(LD) $(LDARGS) -o $(EXE_FILE) $(OBJ_FILES)

clean:
	rm -Rf $(OBJ_FILES) $(EXE_FILE)

%.o: %.c
	$(CC) $(CCARGS) -o $@ $<
