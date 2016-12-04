export SUT_OBJ_FILE=$(PLATFORM_DIR)/Motor.a
export OBJ_FILES=\
	$(SUT_OBJ_FILE) \
	$(PLATFORM_CORE_OBJ_FILES) \
	$(TEST_FIXTURE_OBJ_FILES) \
	$(ASSERT_NO_ISR_OBJ_FILE) \
	$(CURDIR)/InitialiseAfterMotorMock.o

TEST_DOUBLE_OBJ_FILES=\
	InitialiseAfterMotorMock.o \
	PollAfterMotorMock.o \
	MotorDummies.o \
	InitialiseMotorDummy.o \
	EnableMotorVddDummy.o \
	EnableMotorVddMock.o \
	DisableMotorVddDummy.o \
	DisableMotorVddMock.o \
	IsMotorVddEnabledDummy.o \
	IsMotorVddEnabledStub.o \
	IsMotorVddEnabledStubbedTrue.o \
	PollMotorDummy.o

all:
	$(MAKE) -C Initialisation all
	$(MAKE) -C EnableDisable all
	$(MAKE) -C Poll all

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Initialisation clean
	$(MAKE) -C EnableDisable clean
	$(MAKE) -C Poll clean

include $(MAKEFILE_RULES)
