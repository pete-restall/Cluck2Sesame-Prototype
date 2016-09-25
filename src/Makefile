export BASE_DIR=$(CURDIR)
export LKR_FILENAME=$(BASE_DIR)/firmware/Cluck2Sesame.lkr
export MAKEFILE_RULES=$(BASE_DIR)/Makefile.rules
export MAKE=make
export AS=gpasm
export ASARGS=-c -p p16f685
export LD=gplink
export LDARGS=-s $(LKR_FILENAME) -m -c
export BUILD_ARTEFACT_PATTERN=*.hex *.cod *.cof *.map *.lst *.o

all:
	$(MAKE) -C firmware all
	$(MAKE) -C firmware-tests all

clean:
	$(MAKE) -C firmware clean
	$(MAKE) -C firmware-tests clean
