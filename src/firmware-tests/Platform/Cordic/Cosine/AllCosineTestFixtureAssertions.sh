#!/bin/bash

FILE_PREFIX="AllCosineTestFixture";

objcopy -I ihex ${FILE_PREFIX}.0000-3fff.log -O binary ${FILE_PREFIX}.0000-3fff.bin;
objcopy -I ihex ${FILE_PREFIX}.4000-7fff.log -O binary ${FILE_PREFIX}.4000-7fff.bin;
objcopy -I ihex ${FILE_PREFIX}.8000-bfff.log -O binary ${FILE_PREFIX}.8000-bfff.bin;
objcopy -I ihex ${FILE_PREFIX}.c000-ffff.log -O binary ${FILE_PREFIX}.c000-ffff.bin;

cat ${FILE_PREFIX}.{0000-3fff,4000-7fff,8000-bfff,c000-ffff}.bin > ${FILE_PREFIX}.bin;

diff -b ${FILE_PREFIX}.bin ${CORDIC_DIR}/cordic-fixed-cosine-table.bin;
if [ $? -eq 0 ]; then
	echo "[PASSED] All cosine values match verified values";
else
	echo "[FAILED] Differences found in calculated versus verified cosine values";
fi;
