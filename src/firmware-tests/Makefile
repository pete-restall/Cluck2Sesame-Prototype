export FIRMWARE_TESTS_DIR=$(BASE_DIR)/firmware-tests
export FIRMWARE_CORE_OBJ_FILES=\
	$(FIRMWARE_DIR)/ConfigWords.o

ASARGS+=-I $(FIRMWARE_TESTS_DIR)
export TEST_FIXTURE_OBJ_FILE=$(FIRMWARE_TESTS_DIR)/TestFixture.o
export ASSERT_NO_ISR_OBJ_FILE=$(FIRMWARE_TESTS_DIR)/AssertNoIsr.o

all:
	$(MAKE) -C Main all

clean:
	$(MAKE) -C Main clean
