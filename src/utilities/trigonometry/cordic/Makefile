CC=gcc
CCARGS=-ansi -Wall -pedantic -std=c99 -c
LD=gcc
LDARGS=
LIBS=-lm

CORDIC_FLOAT_EXE_FILE=cordic-float
CORDIC_FLOAT_OBJ_FILES=cordic-float.o

all: cordic-float

cordic-float: $(CORDIC_FLOAT_OBJ_FILES)
	$(LD) $(LDARGS) -o $(CORDIC_FLOAT_EXE_FILE) $(CORDIC_FLOAT_OBJ_FILES) $(LIBS)

clean:
	rm -Rf cordic-*tables.txt
	rm -Rf $(CORDIC_FLOAT_OBJ_FILES) $(CORDIC_FLOAT_EXE_FILE)

%.o: %.c
	$(CC) $(CCARGS) -o $@ $<
