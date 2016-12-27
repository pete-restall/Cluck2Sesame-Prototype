export SUT_OBJ_FILE=$(PLATFORM_DIR)/Cordic.a
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(FIRMWARE_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(ASSERT_NO_ISR_OBJ_FILE)

TEST_DOUBLE_OBJ_FILES=\
	InitialiseAfterCordicMock.o \
	InitialiseAfterCordicDummy.o \
	PollAfterCordicMock.o \
	PollAfterCordicDummy.o

all:
	$(MAKE) -C Initialisation all
	$(MAKE) -C Poll all
	$(MAKE) -C IsCordicIdle all
	$(MAKE) -C Sine all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Initialisation clean
	$(MAKE) -C Poll clean
	$(MAKE) -C IsCordicIdle clean
	$(MAKE) -C Sine clean

include $(MAKEFILE_RULES)
