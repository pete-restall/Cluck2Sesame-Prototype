ASARGS+=-I $(PLATFORM_DIR)/Cordic

HEX_FILES=\
	IsCordicIdleTest.hex

IS_CORDIC_IDLE_OBJ_FILES=\
	IsCordicIdleTest.o \
	../InitialiseAfterCordicDummy.o \
	../PollAfterCordicDummy.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

IsCordicIdleTest.hex: $(OBJ_FILES) $(IS_CORDIC_IDLE_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(IS_CORDIC_IDLE_OBJ_FILES)

include $(MAKEFILE_RULES)
