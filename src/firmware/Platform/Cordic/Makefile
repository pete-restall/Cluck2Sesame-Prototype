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
	CalculateXState.o \
	CalculateYState.o \
	CalculateZState.o \
	EndOfIterationState.o \
	StoreSineCosineResultState.o \
	ArcSineInitialiseState.o \
	SqrtInitialiseState.o \
	HyperbolicCalculateXState.o \
	HyperbolicCalculateYState.o \
	HyperbolicEndOfIterationState.o \
	StoreSqrtIntermediateResultState.o \
	ArcTangentInitialiseState.o \
	StoreArcSineResultState.o \
	StoreArcCosineResultState.o \
	Shift.o \
	Sine.o \
	ArcSine.o \
	Cosine.o \
	ArcCosine.o

all: $(LIB_FILENAME)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

$(LIB_FILENAME): $(OBJ_FILES)
	$(AR) $(ARARGS) $(LIB_FILENAME) $(OBJ_FILES)

include $(MAKEFILE_RULES)
