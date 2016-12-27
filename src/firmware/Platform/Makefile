LIB_FILENAME=../Platform.a

OBJ_FILES=\
	Isr.o \
	GeneralPurposeRegisters.o \
	Arithmetic4.o \
	Arithmetic32.a \
	ArithmeticBcd.a \
	Main.o \
	PowerOnReset.o \
	BrownOutReset.o \
	MclrReset.o \
	ResetFlags.o \
	Timer0.o \
	TemperatureSensor.a \
	Clock.a \
	ShiftRegister.a \
	Smps.a \
	Motor.a \
	Lcd.a \
	Adc.a \
	Flash.o \
	PowerManagement.a

all: $(LIB_FILENAME)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C ArithmeticBcd clean
	$(MAKE) -C Clock clean
	$(MAKE) -C ShiftRegister clean
	$(MAKE) -C Smps clean
	$(MAKE) -C Motor clean
	$(MAKE) -C TemperatureSensor clean
	$(MAKE) -C Lcd clean
	$(MAKE) -C Adc clean
	$(MAKE) -C PowerManagement clean

$(LIB_FILENAME): $(OBJ_FILES)
	$(GPLIB_MERGE) $(LIB_FILENAME) $(OBJ_FILES)

include $(MAKEFILE_RULES)
