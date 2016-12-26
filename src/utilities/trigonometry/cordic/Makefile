CC=gcc
CCARGS=-ansi -Wall -pedantic -std=c99 -c
LD=gcc
LDARGS=
LIBS=-lm

CORDIC_FLOAT_EXE_FILE=cordic-float
CORDIC_FLOAT_OBJ_FILES=cordic-float.o

CORDIC_FIXED_EXE_FILE=cordic-fixed
CORDIC_FIXED_OBJ_FILES=cordic-fixed.o

all: cordic-float cordic-fixed

cordic-float: $(CORDIC_FLOAT_OBJ_FILES)
	$(LD) $(LDARGS) -o $(CORDIC_FLOAT_EXE_FILE) $(CORDIC_FLOAT_OBJ_FILES) $(LIBS)

cordic-fixed: $(CORDIC_FIXED_OBJ_FILES)
	$(LD) $(LDARGS) -o $(CORDIC_FIXED_EXE_FILE) $(CORDIC_FIXED_OBJ_FILES) $(LIBS)

clean:
	rm -Rf cordic-*tables.txt
	rm -Rf $(CORDIC_FLOAT_OBJ_FILES) $(CORDIC_FLOAT_EXE_FILE)

%.o: %.c
	$(CC) $(CCARGS) -o $@ $<
