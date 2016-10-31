HEX_FILES=\
	ShiftOutTest.hex

SHIFT_OUT_OBJ_FILES=\
	ShiftOutTest.o \
	../../PollAfterLcdMock.o \
	../../ShiftOutMock.o \
	../../InitialiseShiftRegisterDummy.o \
	../../EnableShiftRegisterDummy.o \
	../../DisableShiftRegisterDummy.o \
	../../IsShiftRegisterEnabledDummy.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

ShiftOutTest.hex: $(OBJ_FILES) $(SHIFT_OUT_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(SHIFT_OUT_OBJ_FILES)

include $(MAKEFILE_RULES)
