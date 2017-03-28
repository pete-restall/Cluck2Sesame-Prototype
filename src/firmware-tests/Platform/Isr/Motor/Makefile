HEX_FILES=\
	FlagsTest.hex

FLAGS_OBJ_FILES=\
	FlagsTest.o \
	../InitialiseAfterIsrDummy.o \
	../ClockDummies.o \
	../../PowerManagement/PowerManagementDummies.o \
	../../Smps/SmpsDummies.o \
	$(PLATFORM_DIR)/Adc.a

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

FlagsTest.hex: $(OBJ_FILES) $(FLAGS_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(FLAGS_OBJ_FILES)

include $(MAKEFILE_RULES)
