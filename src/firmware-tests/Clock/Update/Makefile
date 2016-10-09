HEX_FILES=\
	UpdateWithNoTickedFlagTest.hex \
	UpdateWithTickedFlagTest.hex

UPDATE_WITH_NO_TICKED_FLAG_OBJ_FILES=\
	UpdateWithNoTickedFlagTest.o

UPDATE_WITH_TICKED_FLAG_OBJ_FILES=\
	UpdateWithTickedFlagTest.o

all: $(HEX_FILES)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)

UpdateWithNoTickedFlagTest.hex: $(OBJ_FILES) $(UPDATE_WITH_NO_TICKED_FLAG_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(UPDATE_WITH_NO_TICKED_FLAG_OBJ_FILES)

UpdateWithTickedFlagTest.hex: $(OBJ_FILES) $(UPDATE_WITH_TICKED_FLAG_OBJ_FILES)
	$(LD) $(LDARGS) -o $@ $(OBJ_FILES) $(UPDATE_WITH_TICKED_FLAG_OBJ_FILES)

include $(MAKEFILE_RULES)
