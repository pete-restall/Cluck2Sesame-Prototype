export DATE_YYYYMMDD=`date +"%Y%m%d"`
export FIRMWARE_VERSION="UK$(DATE_YYYYMMDD)000000"

HEX_FILENAME=Cluck2Sesame.hex

OBJ_FILES=\
	Boot.o \
	ConfigWords.o \
	Platform.a \
	Ui.a \
	SunriseSunset.a \
	Door.a

all: $(HEX_FILENAME)

install: all
	$(PICKIT3_IPE) -P16F685 -OL -M -Y -F$(HEX_FILENAME)

clean:
	$(RM) -f $(BUILD_ARTEFACT_PATTERN)
	$(MAKE) -C Platform clean
	$(MAKE) -C Ui clean
	$(MAKE) -C SunriseSunset clean
	$(MAKE) -C Door clean

$(HEX_FILENAME): $(OBJ_FILES)
	$(LD) $(LDARGS) -o $(HEX_FILENAME) $(OBJ_FILES)

include $(MAKEFILE_RULES)
