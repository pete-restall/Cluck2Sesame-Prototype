export SUT_OBJ_FILE=$(PLATFORM_DIR)/Timer0.a
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(FIRMWARE_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(ASSERT_NO_ISR_OBJ_FILE)

HEX_FILES=\
	ElapsedTicksTest.hex \
	ElapsedSlowTicksTest.hex

TEST_DOUBLE_OBJ_FILES=\
	InitialiseAfterTimer0Dummy.o \
	InitialiseAfterTimer0Mock.o \
	PollAfterTimer0Mock.o \
	PollAfterTimer0Dummy.o \
	Timer0Dummies.o

ELAPSED_TICKS_OBJ_FILES=\
	ElapsedTicksTest.o \
	InitialiseAfterTimer0Dummy.o \
	PollAfterTimer0Dummy.o

ELAPSED_SLOW_TICKS_OBJ_FILES=\
	ElapsedSlowTicksTest.o \
	InitialiseAfterTimer0Dummy.o \
	PollAfterTimer0Dummy.o

all: $(TEST_DOUBLE_OBJ_FILES) $(HEX_FILES)
	$(MAKE) -C Initialisation all
	$(MAKE) -C Poll all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Initialisation clean
	$(MAKE) -C Poll clean

ElapsedTicksTest.hex: $(ELAPSED_TICKS_OBJ_FILES) $(OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(ELAPSED_TICKS_OBJ_FILES) $(OBJ_FILES)

ElapsedSlowTicksTest.hex: $(ELAPSED_SLOW_TICKS_OBJ_FILES) $(OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(ELAPSED_SLOW_TICKS_OBJ_FILES) $(OBJ_FILES)

include $(MAKEFILE_RULES)
