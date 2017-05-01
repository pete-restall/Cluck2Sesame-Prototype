#include <stdio.h>
#include <string.h>

#define EARLIEST_FIRST_DAYLIGHT_SAVINGS_DAY 83
#define EARLIEST_LAST_DAYLIGHT_SAVINGS_DAY 296

#define DST_PACK_BYTE(start, end) ((unsigned char) (\
	(((start) - EARLIEST_FIRST_DAYLIGHT_SAVINGS_DAY) & 0x07) << 4) | \
	(((end) - EARLIEST_LAST_DAYLIGHT_SAVINGS_DAY) & 0x07))

static void printSpreadsheet(void);
static int dayOfWeek(int date, int month, int year);
static int dstStartDayOfYear(int year);
static int isDst(int day, int month, int dow);
static int dstEndDayOfYear(int year);
static void printAssembler(void);

int main(int argc, char *argv[])
{
	if (argc != 2)
	{
		printf("Usage: %s <spreadsheet | assembler>\n", argv[0]);
		return 1;
	}

	if (strcmp(argv[1], "spreadsheet") == 0)
		printSpreadsheet();
	else
		printAssembler();

	return 0;
}

static void printSpreadsheet(void)
{
	printf("Year\tDOW 1 Jan\tDST Start\tDST End\n");
	for (int i = 0; i < 100; i++)
	{
		printf(
			"%.2d\t%d\t%d\t%d\n",
			i,
			dayOfWeek(1, 0, 2000 + i),
			dstStartDayOfYear(2000 + i),
			dstEndDayOfYear(2000 + i));
	}
}

/******************************************************************************
* Elegant code by Tomohiko Sakamoto
* Sunday = 0 and Saturday = 6
* Day of Month: 1 -31
* Month: 0 - 11
* Year: e.g., 2007
******************************************************************************/
static int dayOfWeek(int date, int month, int year)
{
	static const int table[] = {0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4};
 
	if (month < 2)
		year--;
 
	return
		(year + year / 4 - year / 100 + year / 400 + table[month] + date) % 7;
}

static int dstStartDayOfYear(int year)
{
	int daysToMarch = 31 + 28;
	int dayOfMarch;
	for (dayOfMarch = 20;
		!isDst(dayOfMarch, 3, dayOfWeek(dayOfMarch, 2, year));
		dayOfMarch++)
		;;

	if (dayOfWeek(dayOfMarch, 2, year) != 0)
		printf("!!! BST START SHOULD BE A SUNDAY (%d) !!!\n", year);

	if (year % 4 == 0)
		daysToMarch++;

	return daysToMarch + dayOfMarch - 1;
}

static int isDst(int day, int month, int dow)
{
	if (month < 3 || month > 10)
		return 0;
 
	if (month > 3 && month < 10)
		return 1; 

	int previousSunday = day - dow;

	if (month == 3)
		return previousSunday >= 25;

	return previousSunday >= 25;
}

static int dstEndDayOfYear(int year)
{
	int daysToOctober = 31 + 28 + 31 + 30 + 31 + 30 + 31 + 31 + 30;
	int dayOfOctober;
	for (dayOfOctober = 20;
		!isDst(dayOfOctober, 10, dayOfWeek(dayOfOctober, 9, year));
		dayOfOctober++)
		;;

	if (dayOfWeek(dayOfOctober, 9, year) != 0)
		printf("!!! GMT START SHOULD BE A SUNDAY (%d) !!!\n", year);

	dayOfOctober--;

	if (year % 4 == 0)
		daysToOctober++;

	return daysToOctober + dayOfOctober - 1;
}

static void printAssembler(void)
{
	printf("\tradix decimal\n");
	printf("\n");
	printf("Clock code\n");
	printf("\tglobal daylightSavingsTimeLookupTable\n");
	printf("\n");
	printf("daylightSavingsTimeLookupTable:\n");
	for (int i = 0; i < 100; i += 2)
	{
		int year1 = 2000 + i, year2 = 2000 + i + 1;

		int dstStartYear1 = dstStartDayOfYear(year1);
		int dstEndYear1 = dstEndDayOfYear(year1);
		unsigned char dstYear1 = DST_PACK_BYTE(dstStartYear1, dstEndYear1);

		int dstStartYear2 = dstStartDayOfYear(year2);
		int dstEndYear2 = dstEndDayOfYear(year2);
		unsigned char dstYear2 = DST_PACK_BYTE(dstStartYear2, dstEndYear2);

		printf(
			"\tdw 0x%.4x ; %d = %d -> %d, %d = %d -> %d\n",
			(((unsigned int) dstYear1) << 7) | ((unsigned int) dstYear2),
			year1,
			dstStartYear1,
			dstEndYear1,
			year2,
			dstStartYear2,
			dstEndYear2);
	}

	printf("\n\tend\n");
}
