	#include "Mcu.inc"

	radix decimal

Ui code
	global backlightNowScreen
	global backlightInTheDarkScreen
	global dateAndTimeEntryScreen
	global openAndCloseOffsetEntryScreen
	global longitudeAndLatitudeScreen
	global doorCalibrationScreen
	global mainScreen
	global overrideScreen
	global firmwareScreen
	global settingsScreen

backlightNowScreen:
	da "Backlight Now   "
	da "[ON]        OFF "

backlightInTheDarkScreen:
	da "Backlight Usual "
	da " ON  OFF  [AUTO]"

dateAndTimeEntryScreen:
	da "Date and Time   "
	da "20YY-MM-DD HH:MM"

openAndCloseOffsetEntryScreen:
	da "Open  -00 mins  "
	da "Close +00 mins  "

longitudeAndLatitudeScreen:
	da "Longitude +00.0 "
	da "Latitude  +50.0 "

doorCalibrationScreen:
	da "Open the Door..."
	da "< DOWN      UP >"

mainScreen:
	da "20YY-MM-DD HH:MM"
	da "+00C            "

overrideScreen:
	da "Door Override   "
	da " OPEN CLOSE[OFF]"

firmwareScreen:
	da "  Cluck2Sesame  "
	da "{{FIRMWARE_VER}}"

settingsScreen:
	da "Settings        "
	da "                "

end
