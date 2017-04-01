	#include "Mcu.inc"

	radix decimal

Ui code
	global backlightNowScreen
	global backlightInTheDarkScreen
	global dateAndTimeEntryScreen
	global doorCalibrationScreen
	global mainScreen
	global overrideScreen
	global firmwareScreen
	global reconfigureScreen

backlightNowScreen:
	da "Backlight Now   "
	da "ON    off       "

backlightInTheDarkScreen:
	da "Backlight Usual "
	da "on    off   AUTO"

dateAndTimeEntryScreen:
	da "Date and Time   "
	da "20YY-MM-DD HH:MM"

openAndCloseOffsetEntryScreen:
	da "Open  -00 mins  "
	da "Close +00 mins  "

doorCalibrationScreen:
	da "Open the Door..."
	da "< DOWN      UP >"

mainScreen:
	da "20YY-MM-DD HH:MM"
	da "+00C            "

overrideScreen:
	da "Door Override   "
	da "open  close  OFF"

firmwareScreen:
	da "  Cluck2Sesame  "
	da "{{FIRMWARE_VER}}"

reconfigureScreen:
	da "Settings        "
	da "                "

end
