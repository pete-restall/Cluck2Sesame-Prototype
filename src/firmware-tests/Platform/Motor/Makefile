export SUT_OBJ_FILE=$(PLATFORM_DIR)/Motor.a
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(PLATFORM_CORE_OBJ_FILES) \
	$(PLATFORM_DIR)/Timer0.a \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(ASSERT_NO_ISR_OBJ_FILE) \
	$(CURDIR)/InitialiseAfterMotorMock.o \
	$(PLATFORM_TESTS_DIR)/Timer0/InitialiseAfterTimer0Dummy.o \
	$(PLATFORM_TESTS_DIR)/Timer0/PollAfterTimer0Dummy.o

TEST_DOUBLE_OBJ_FILES=\
	InitialiseAfterMotorMock.o \
	InitialiseAfterMotorDummy.o \
	PollAfterMotorMock.o \
	PollAfterMotorDummy.o \
	MotorDummies.o \
	InitialiseMotorDummy.o \
	EnableMotorVddDummy.o \
	EnableMotorVddMock.o \
	DisableMotorVddDummy.o \
	DisableMotorVddMock.o \
	IsMotorVddEnabledDummy.o \
	IsMotorVddEnabledStub.o \
	IsMotorVddEnabledStubbedTrue.o \
	PollMotorDummy.o \
	TurnMotorDummies.o

all: $(TEST_DOUBLE_OBJ_FILES)
	$(MAKE) -C Initialisation all
	$(MAKE) -C EnableDisable all
	$(MAKE) -C Poll all
	$(MAKE) -C Turn all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Initialisation clean
	$(MAKE) -C EnableDisable clean
	$(MAKE) -C Poll clean
	$(MAKE) -C Turn clean

include $(MAKEFILE_RULES)
