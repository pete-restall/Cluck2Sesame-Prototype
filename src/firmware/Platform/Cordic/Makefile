LIB_FILENAME=../Cordic.a
OBJ_FILES=\
	ArcTangentLookup.o \
	Registers.o \
	RegisterLoadAndStore.o \
	Initialise.o \
	Poll.o \
	IdleState.o \
	SineCosineInitialiseState.o \
	CalculateErrorState.o \
	StoreSineCosineResultState.o \
	IterationState.o \
	Sine.o

all: $(LIB_FILENAME)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

$(LIB_FILENAME): $(OBJ_FILES)
	$(AR) $(ARARGS) $(LIB_FILENAME) $(OBJ_FILES)

include $(MAKEFILE_RULES)
