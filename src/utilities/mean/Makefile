CC=gcc
CCARGS=-c
LD=gcc
LDARGS=

EXE_FILE=mean
OBJ_FILES=mean.o

all: $(OBJ_FILES)
	$(LD) $(LDARGS) -o $(EXE_FILE) $(OBJ_FILES)

clean:
	rm -Rf $(OBJ_FILES) $(EXE_FILE)

%.o: %.c
	$(CC) $(CCARGS) -o $@ $<
