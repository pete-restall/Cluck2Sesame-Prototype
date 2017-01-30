HEX_FILENAME=Cluck2Sesame.hex

OBJ_FILES=\
	Boot.o \
	ConfigWords.o \
	Platform.a \
	Ui.a \
	SunriseSunset.a

all: $(HEX_FILENAME)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Platform clean
	$(MAKE) -C Ui clean
	$(MAKE) -C SunriseSunset clean

$(HEX_FILENAME): $(OBJ_FILES)
	$(LD) $(LDARGS) -o $(HEX_FILENAME) $(OBJ_FILES)

include $(MAKEFILE_RULES)
