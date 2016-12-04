ASARGS+=-I $(PLATFORM_DIR)/Lcd

HEX_FILES=\
	EntireScreenShiftOutTest.hex \
	PutScreenWhenStateIsIdleTest.hex \
	PutScreenWhenStateIsNotIdleTest.hex

OBJ_FILES+=\
	../PollAfterLcdDummy.o \
	../InitialiseAfterLcdDummy.o \
	../AdcDummies.o \
	../InitialiseShiftRegisterDummy.o \
	../EnableShiftRegisterDummy.o \
	../DisableShiftRegisterDummy.o \
	../IsShiftRegisterEnabledStubbedTrue.o \
	../../Motor/InitialiseMotorDummy.o \
	../../Motor/EnableMotorVddDummy.o \
	../../Motor/DisableMotorVddDummy.o \
	../../Motor/IsMotorVddEnabledStubbedTrue.o \
	../../Motor/PollMotorDummy.o \
	$(ASSERT_NO_ISR_OBJ_FILE)

ENTIRE_SCREEN_SHIFT_OUT_OBJ_FILES=\
	EntireScreenShiftOutTest.o

PUT_SCREEN_WHEN_STATE_IS_IDLE_OBJ_FILES=\
	PutScreenWhenStateIsIdleTest.o \
	../ShiftOutDummy.o

PUT_SCREEN_WHEN_STATE_IS_NOT_IDLE_OBJ_FILES=\
	PutScreenWhenStateIsNotIdleTest.o \
	../ShiftOutDummy.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

EntireScreenShiftOutTest.hex: $(OBJ_FILES) $(ENTIRE_SCREEN_SHIFT_OUT_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ENTIRE_SCREEN_SHIFT_OUT_OBJ_FILES)

PutScreenWhenStateIsIdleTest.hex: $(OBJ_FILES) $(PUT_SCREEN_WHEN_STATE_IS_IDLE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(PUT_SCREEN_WHEN_STATE_IS_IDLE_OBJ_FILES)

PutScreenWhenStateIsNotIdleTest.hex: $(OBJ_FILES) $(PUT_SCREEN_WHEN_STATE_IS_NOT_IDLE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(PUT_SCREEN_WHEN_STATE_IS_NOT_IDLE_OBJ_FILES)

include $(MAKEFILE_RULES)
