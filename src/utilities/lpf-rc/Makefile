CC=gcc
CCARGS=-c
LD=gcc
LDARGS=-lm

EXE_FILE=lpf-rc
OBJ_FILES=lpf-rc.o

all: $(OBJ_FILES)
	$(LD) $(LDARGS) -o $(EXE_FILE) $(OBJ_FILES)

clean:
	rm -Rf $(OBJ_FILES) $(EXE_FILE)

%.o: %.c
	$(CC) $(CCARGS) -o $@ $<
