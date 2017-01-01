HEX_FILES=\
	ArcSineTest.hex

TEST_DOUBLE_OBJ_FILES=\
	../InitialiseAfterCordicDummy.o \
	../PollAfterCordicDummy.o

ARC_SINE_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	ArcSineTest.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

ArcSineTest.hex: $(OBJ_FILES) $(ARC_SINE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ARC_SINE_OBJ_FILES)

include $(MAKEFILE_RULES)
