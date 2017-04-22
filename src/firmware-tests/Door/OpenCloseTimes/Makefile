ASARGS+=-I $(FIRMWARE_DIR)/Door

HEX_FILES=\
	InitialOpenCloseTimeTest.hex

TEST_DOUBLE_OBJ_FILES=\
	../InitialiseAfterDoorDummy.o \
	../PollAfterDoorDummy.o \
	$(PLATFORM_DIR)/Flash.o \
	$(PLATFORM_DIR)/Arithmetic4.o \
	$(PLATFORM_DIR)/Arithmetic16.a \
	$(PLATFORM_DIR)/Arithmetic32.a \
	$(PLATFORM_DIR)/ArithmeticBcd.a \
	$(FIRMWARE_DIR)/SunriseSunset.a

INITIAL_OPEN_CLOSE_TIME_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	InitialOpenCloseTimeTest.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

InitialOpenCloseTimeTest.hex: $(OBJ_FILES) $(INITIAL_OPEN_CLOSE_TIME_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(INITIAL_OPEN_CLOSE_TIME_OBJ_FILES)

include $(MAKEFILE_RULES)
