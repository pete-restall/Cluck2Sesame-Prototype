export BASE_DIR=$(CURDIR)
export FIRMWARE_DIR=$(BASE_DIR)/firmware
export UTILITIES_DIR=$(BASE_DIR)/utilities
export LKR_FILENAME=$(FIRMWARE_DIR)/Cluck2Sesame.lkr
export MAKEFILE_RULES=$(BASE_DIR)/Makefile.rules
export MAKE=make
export AS=gpasm
export ASARGS=-c -p p16f685 -I $(FIRMWARE_DIR) -I $(FIRMWARE_DIR)/Platform
export AR=gplib
export ARARGS=-c
export LD=gplink
export LDARGS=-S 2 -O 2 -s $(LKR_FILENAME) -m -c
export BUILD_ARTEFACT_PATTERN=*.hex *.cod *.cof *.map *.lst *.o *.a *.log
export GPLIB_MERGE=$(UTILITIES_DIR)/gplib-merge.sh
export MPLABX_DIR=/opt/microchip/mplabx/v3.55
export PICKIT3_IPE=$(MPLABX_DIR)/mplab_ipe/ipecmd.sh -TPPK3

all:
	$(MAKE) -C utilities all
	$(MAKE) -C firmware all
	$(MAKE) -C firmware-tests all

firmware-install:
	$(MAKE) -C firmware install

clean:
	$(MAKE) -C utilities clean
	$(MAKE) -C firmware clean
	$(MAKE) -C firmware-tests clean
