HEX_FILES=\
	AnselTest.hex \
	PortcTest.hex \
	InitialisationChainTest.hex \
	PwmPeriodTest.hex \
	T2conTest.hex \
	Ccp1conTest.hex \
	Ccpr1lTest.hex \
	PstrconTest.hex

TEST_DOUBLE_OBJ_FILES=\
	../../Smps/EnableDisableSmpsMocks.o \
	../../Smps/IsSmpsEnabledStub.o \
	../../Smps/PollSmpsDummy.o \
	../PollAfterMotorMock.o

ANSEL_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	AnselTest.o

PORTC_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	PortcTest.o

INITIALISATION_CHAIN_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	InitialisationChainTest.o

PWM_PERIOD_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	PwmPeriodTest.o

T2CON_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	T2conTest.o

CCP1CON_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	Ccp1conTest.o

CCPR1L_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	Ccpr1lTest.o

PSTRCON_OBJ_FILES=\
	$(TEST_DOUBLE_OBJ_FILES) \
	PstrconTest.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

AnselTest.hex: $(OBJ_FILES) $(ANSEL_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(ANSEL_OBJ_FILES)

PortcTest.hex: $(OBJ_FILES) $(PORTC_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(PORTC_OBJ_FILES)

InitialisationChainTest.hex: $(OBJ_FILES) $(INITIALISATION_CHAIN_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(INITIALISATION_CHAIN_OBJ_FILES)

PwmPeriodTest.hex: $(OBJ_FILES) $(PWM_PERIOD_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(PWM_PERIOD_OBJ_FILES)

T2conTest.hex: $(OBJ_FILES) $(T2CON_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(T2CON_OBJ_FILES)

Ccp1conTest.hex: $(OBJ_FILES) $(CCP1CON_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(CCP1CON_OBJ_FILES)

Ccpr1lTest.hex: $(OBJ_FILES) $(CCPR1L_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(CCPR1L_OBJ_FILES)

PstrconTest.hex: $(OBJ_FILES) $(PSTRCON_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(PSTRCON_OBJ_FILES)

include $(MAKEFILE_RULES)
