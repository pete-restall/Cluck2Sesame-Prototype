OBJ_FILES+=\
	$(ASSERT_NO_ISR_OBJ_FILE) \
	../../ResetFlagsStubs.o

HEX_FILES=\
	DayOfYearTest.hex

DAY_OF_YEAR_OBJ_FILES=\
	DayOfYearTest.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

DayOfYearTest.hex: $(OBJ_FILES) $(DAY_OF_YEAR_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(DAY_OF_YEAR_OBJ_FILES)

include $(MAKEFILE_RULES)
