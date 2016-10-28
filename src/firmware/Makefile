HEX_FILENAME=Cluck2Sesame.hex

OBJ_FILES=\
	Cluck2Sesame.o \
	ConfigWords.o \
	Isr.o \
	GeneralPurposeRegisters.o \
	Arithmetic4.o \
	Arithmetic32.o \
	ArithmeticBcd.a \
	Main.o \
	PowerOnReset.o \
	BrownOutReset.o \
	MclrReset.o \
	Timer0.o \
	TemperatureSensor.a \
	Clock.a \
	ShiftRegister.a \
	Smps.a \
	Motor.a \
	Lcd.a \
	Sleep.o

all: $(HEX_FILENAME)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C ArithmeticBcd clean
	$(MAKE) -C Clock clean
	$(MAKE) -C ShiftRegister clean
	$(MAKE) -C Smps clean
	$(MAKE) -C Motor clean
	$(MAKE) -C TemperatureSensor clean
	$(MAKE) -C Lcd clean

$(HEX_FILENAME): $(OBJ_FILES)
	$(LD) $(LDARGS) -o $(HEX_FILENAME) $(OBJ_FILES)

include $(MAKEFILE_RULES)
