HEX_FILENAME=Cluck2Sesame.hex
OBJ_FILES=\
	Cluck2Sesame.o \
	ConfigWords.o \
	GeneralPurposeRegisters.o \
	Arithmetic4.o \
	Arithmetic32.o \
	ArithmeticBcd.a \
	Main.o \
	PowerOnReset.o \
	BrownOutReset.o \
	MclrReset.o \
	Isr.o \
	TemperatureSensor.o \
	Clock.a \
	ShiftRegister.a \
	Motor.a

all: $(HEX_FILENAME)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C ArithmeticBcd clean
	$(MAKE) -C Clock clean
	$(MAKE) -C ShiftRegister clean
	$(MAKE) -C Motor clean

$(HEX_FILENAME): $(OBJ_FILES)
	$(LD) $(LDARGS) -o $(HEX_FILENAME) $(OBJ_FILES)

include $(MAKEFILE_RULES)
