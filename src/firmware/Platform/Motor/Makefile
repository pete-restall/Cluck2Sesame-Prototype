LIB_FILENAME=../Motor.a
OBJ_FILES=\
	Registers.o \
	Initialise.o \
	EnableDisable.o \
	Poll.o \
	DisabledState.o \
	IdleState.o \
	WaitState.o \
	SoftStartStates.o \
	Turn.o

all: $(LIB_FILENAME)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

$(LIB_FILENAME): $(OBJ_FILES)
	$(AR) $(ARARGS) $(LIB_FILENAME) $(OBJ_FILES)

include $(MAKEFILE_RULES)
