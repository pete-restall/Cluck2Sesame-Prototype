export SUT_OBJ_FILE=$(PLATFORM_DIR)/Cordic.a
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(FIRMWARE_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(ASSERT_NO_ISR_OBJ_FILE) \
	$(PLATFORM_DIR)/Arithmetic16.a \
	$(PLATFORM_DIR)/Arithmetic32.a \
	$(PLATFORM_DIR)/Flash.o

TEST_DOUBLE_OBJ_FILES=\
	InitialiseAfterCordicMock.o \
	InitialiseAfterCordicDummy.o \
	PollAfterCordicMock.o \
	PollAfterCordicDummy.o

all: $(TEST_DOUBLE_OBJ_FILES) AllCordicSpaceTestFixture.o
	$(MAKE) -C Initialisation all
	$(MAKE) -C Poll all
	$(MAKE) -C IsCordicIdle all
	$(MAKE) -C Sine all
	$(MAKE) -C ArcSine all
	$(MAKE) -C Cosine all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Initialisation clean
	$(MAKE) -C Poll clean
	$(MAKE) -C IsCordicIdle clean
	$(MAKE) -C Sine clean
	$(MAKE) -C ArcSine clean
	$(MAKE) -C Cosine clean

include $(MAKEFILE_RULES)
