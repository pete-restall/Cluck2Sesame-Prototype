/*
   Hacking playground for generating lookups for the Sunrise / Sunset times.
   The lookup is a selection of accurate values computed using the algorithm
   documented at:

       https://alcor.concordia.ca/~gpkatch/gdate-method.html

   Linear interpolation is used to calculate values across latitudes and days
   that do not have entries in the lookup table.
*/

#include <stdio.h>
#include <math.h>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

#define DEG2RAD(phi) (double) ((phi) / 180 * M_PI)

#define LOOKUP_STEP 6
#define LOOKUP_LENGTH (366 / LOOKUP_STEP)
#define LOOKUP_LATITUDE 55
#define LOOKUP_LATITUDE_NORTH (LOOKUP_LATITUDE + 5)
#define LOOKUP_LATITUDE_SOUTH (LOOKUP_LATITUDE - 5)
#define LOOKUP_LONGITUDE 0

typedef short FixedQ1_15;
typedef unsigned short FixedQ0_16;

typedef struct
{
	int year : 16;
	int month : 8;
	int day : 8;
} GregorianDate;

typedef struct
{
	double day;
	double latitude;
	double longitude;
	double eventHeight;
	double correctionSign;
	double eventTime;
} SunEventState;

typedef struct
{
	unsigned int sunriseReferenceMinute : 11;
	int sunriseMinuteNorth : 8;
	int sunriseMinuteSouth : 8;
	unsigned int sunsetReferenceMinute : 11;
	int sunsetMinuteNorth : 8;
	int sunsetMinuteSouth : 8;
} LookupEntry;

typedef struct
{
	unsigned int sunriseReferenceMinute;
	int sunriseMinuteOffset;
	unsigned int sunsetReferenceMinute;
	int sunsetMinuteOffset;
} InterpolatedLookupEntry;

static const GregorianDate epoch = {0, 1, 1};
static LookupEntry lookupTable[LOOKUP_LENGTH];

static void initialiseLookupTable(void);
static unsigned short fractionOfDayToMinute(double fraction);
static double sunriseTime(int day, double latitude, double longitude);
static void sunEventTime(SunEventState *const state);
static void sunEventTimeIteration(SunEventState *const state);
static double sunsetTime(int day, double latitude, double longitude);
static int writeLookupTableForOctave(
	const char *const filename,
	double latitude,
	double longitude);
static double lookupSunriseTime(int day, double latitude, double longitude);
static InterpolatedLookupEntry interpolatedLookupNorth(int day);
static InterpolatedLookupEntry interpolatedLookupSouth(int day);
static int dayOfYearFromDayOfCentury(int day);
static GregorianDate daysSinceEpochToDate(int day);
static GregorianDate daysToDate(int day);
static int dateToDays(const GregorianDate date);
static int daysSinceEpoch(const GregorianDate date);
static short latitudeInterpolationMultiplier(double latitude);
static double lookupSunsetTime(int day, double latitude, double longitude);
static int writeLookupTableForAssembler(
	const char *const filename,
	double latitude,
	double longitude);

int main(void)
{
	double latitude = 57.5;
	double longitude = 0;

	initialiseLookupTable();
	return
		writeLookupTableForOctave("lookup.txt", latitude, longitude) +
		writeLookupTableForAssembler("lookup.asm", latitude, longitude);
}

static void initialiseLookupTable(void)
{
	for (int i = 0, day = 0; i < LOOKUP_LENGTH; i++, day += LOOKUP_STEP)
	{
		lookupTable[i].sunriseReferenceMinute = fractionOfDayToMinute(
			sunriseTime(day, LOOKUP_LATITUDE, LOOKUP_LONGITUDE));

		lookupTable[i].sunriseMinuteNorth = fractionOfDayToMinute(
			sunriseTime(day, LOOKUP_LATITUDE_NORTH, LOOKUP_LONGITUDE)) -
			lookupTable[i].sunriseReferenceMinute;

		lookupTable[i].sunriseMinuteSouth = fractionOfDayToMinute(
			sunriseTime(day, LOOKUP_LATITUDE_SOUTH, LOOKUP_LONGITUDE)) -
			lookupTable[i].sunriseReferenceMinute;

		lookupTable[i].sunsetReferenceMinute = fractionOfDayToMinute(
			sunsetTime(day, LOOKUP_LATITUDE, LOOKUP_LONGITUDE));

		lookupTable[i].sunsetMinuteNorth = fractionOfDayToMinute(
			sunsetTime(day, LOOKUP_LATITUDE_NORTH, LOOKUP_LONGITUDE)) -
			lookupTable[i].sunsetReferenceMinute;

		lookupTable[i].sunsetMinuteSouth = fractionOfDayToMinute(
			sunsetTime(day, LOOKUP_LATITUDE_SOUTH, LOOKUP_LONGITUDE)) -
			lookupTable[i].sunsetReferenceMinute;
	}
}

static unsigned short fractionOfDayToMinute(double fraction)
{
	unsigned short minute = (unsigned short) (fraction * 24 * 60 + 0.5);
	return minute;
}

static double sunriseTime(int day, double latitude, double longitude)
{
	SunEventState state = {
		day,
		DEG2RAD(latitude),
		DEG2RAD(longitude),
		DEG2RAD(0),
		1,
		M_PI
	};

	sunEventTime(&state);
	return state.eventTime / (2 * M_PI);
}

static void sunEventTime(SunEventState *const state)
{
	for (int i = 0; i < 5; i++)
		sunEventTimeIteration(state);
}

static void sunEventTimeIteration(SunEventState *const state)
{
	/* http://www.stargazing.net/kepler/sunrise.html */

	double t = (state->day + (state->eventTime / (2 * M_PI))) / 36525.0;
	double L = 280.46 + 36000.77 * t;
	double G = 357.528 + 35999.05 * t;
	double ec = 1.915 * sin(DEG2RAD(G)) + 0.02 * sin(DEG2RAD(2 * G));
	double lambda = L + ec;
	double E =
		-ec + 2.466 * sin(DEG2RAD(2 * lambda)) -
		0.053 * sin(DEG2RAD(4 * lambda));

	double GHA = state->eventTime - M_PI + DEG2RAD(E);
	double obl = 23.4393 - 0.0130 * t;
	double delta = asin(sin(DEG2RAD(obl)) * sin(DEG2RAD(lambda)));

	double coscNumerator =
		sin(state->eventHeight) - sin(state->latitude) * sin(delta);

	double coscDenominator = cos(state->latitude) * cos(delta);
	double cosc = coscNumerator / coscDenominator;
	double correction = (cosc > 1 ? 0 : (cosc < -1 ? M_PI : acos(cosc)));

	state->eventTime -=
		GHA + state->longitude + correction * state->correctionSign;
}

static double sunsetTime(int day, double latitude, double longitude)
{
	SunEventState state = {
		day,
		DEG2RAD(latitude),
		DEG2RAD(longitude),
		DEG2RAD(0),
		-1,
		M_PI
	};

	sunEventTime(&state);
	return state.eventTime / (2 * M_PI);
}

static int writeLookupTableForOctave(
	const char *const filename,
	double latitude,
	double longitude)
{
	FILE *fd = fopen(filename, "wt");
	if (!fd)
	{
		printf("Unable to open %s for writing.\n", filename);
		return 1;
	}

	printf("Writing table to %s...\n", filename);

	for (int day = 0; day < 36525; day++)
	{
		double eventTimes[] = {
			sunriseTime(day, LOOKUP_LATITUDE, LOOKUP_LONGITUDE),
			lookupSunriseTime(day, LOOKUP_LATITUDE, LOOKUP_LONGITUDE),
			sunriseTime(day, LOOKUP_LATITUDE_NORTH, LOOKUP_LONGITUDE),
			lookupSunriseTime(day, LOOKUP_LATITUDE_NORTH, LOOKUP_LONGITUDE),
			sunriseTime(day, LOOKUP_LATITUDE_SOUTH, LOOKUP_LONGITUDE),
			lookupSunriseTime(day, LOOKUP_LATITUDE_SOUTH, LOOKUP_LONGITUDE),
			sunsetTime(day, LOOKUP_LATITUDE, LOOKUP_LONGITUDE),
			lookupSunsetTime(day, LOOKUP_LATITUDE, LOOKUP_LONGITUDE),
			sunsetTime(day, LOOKUP_LATITUDE_NORTH, LOOKUP_LONGITUDE),
			lookupSunsetTime(day, LOOKUP_LATITUDE_NORTH, LOOKUP_LONGITUDE),
			sunsetTime(day, LOOKUP_LATITUDE_SOUTH, LOOKUP_LONGITUDE),
			lookupSunsetTime(day, LOOKUP_LATITUDE_SOUTH, LOOKUP_LONGITUDE),
			sunriseTime(day, latitude, longitude),
			lookupSunriseTime(day, latitude, longitude),
			sunsetTime(day, latitude, longitude),
			lookupSunsetTime(day, latitude, longitude)
		};

		fprintf(
			fd,
			"%d"
				"\t%.8e\t%.8e"
				"\t%.8e\t%.8e"
				"\t%.8e\t%.8e"
				"\t%.8e\t%.8e"
				"\t%.8e\t%.8e"
				"\t%.8e\t%.8e"
				"\t%.8e\t%.8e"
				"\t%.8e\t%.8e"
			"\n",
			day,
			eventTimes[0],
			eventTimes[1],
			eventTimes[2],
			eventTimes[3],
			eventTimes[4],
			eventTimes[5],
			eventTimes[6],
			eventTimes[7],
			eventTimes[8],
			eventTimes[9],
			eventTimes[10],
			eventTimes[11],
			eventTimes[12],
			eventTimes[13],
			eventTimes[14],
			eventTimes[15]);
	}

	fclose(fd);
	return 0;
}

static double lookupSunriseTime(int day, double latitude, double longitude)
{
	InterpolatedLookupEntry interpolated = latitude >= LOOKUP_LATITUDE
		? interpolatedLookupNorth(day)
		: interpolatedLookupSouth(day);

	short latitudeMultiplier = latitudeInterpolationMultiplier(latitude);

	short offset = (latitudeMultiplier * interpolated.sunriseMinuteOffset) >> 8;

	unsigned short minutes = interpolated.sunriseReferenceMinute + offset;
	/* TODO: ADD IN THE LONGITUDE DIFFERENCE, TOO */

	return minutes / (24.0 * 60.0);
}

static InterpolatedLookupEntry interpolatedLookupNorth(int day)
{
	int dayOfYear = dayOfYearFromDayOfCentury(day);
	int index = dayOfYear / LOOKUP_STEP;
	int offset = dayOfYear % LOOKUP_STEP;
	LookupEntry *first = &lookupTable[index];
	LookupEntry *second = &lookupTable[
		(index + 1) < LOOKUP_LENGTH ? index + 1 : 0];

	InterpolatedLookupEntry interpolated = {
		first->sunriseReferenceMinute +
			(second->sunriseReferenceMinute - first->sunriseReferenceMinute) *
			offset / LOOKUP_STEP,

		first->sunriseMinuteNorth +
			(second->sunriseMinuteNorth - first->sunriseMinuteNorth) *
			offset / LOOKUP_STEP,

		first->sunsetReferenceMinute +
			(second->sunsetReferenceMinute - first->sunsetReferenceMinute) *
			offset / LOOKUP_STEP,

		first->sunsetMinuteNorth +
			(second->sunsetMinuteNorth - first->sunsetMinuteNorth) *
			offset / LOOKUP_STEP
	};

	return interpolated;
}

static int dayOfYearFromDayOfCentury(int day)
{
	GregorianDate date = daysSinceEpochToDate(day);
	GregorianDate startOfYear = {date.year, 1, 1};
	int dayOfYear = day - daysSinceEpoch(startOfYear);

	if (dayOfYear < 0 || dayOfYear > 365)
	{
		printf(
			"!!! ERROR !!!  THIS SHOULDN'T HAPPEN; "
				"dayOfYear = %d, date = %.4d-%.2d-%.2d\n",
			dayOfYear,
			date.year,
			date.month,
			date.day);

		return 0;
	}

	return dayOfYear;
}

static GregorianDate daysSinceEpochToDate(int day)
{
	return daysToDate(dateToDays(epoch) + day);
}

static GregorianDate daysToDate(int day)
{
	/* https://alcor.concordia.ca/~gpkatch/gdate-algorithm.html */
	/* https://alcor.concordia.ca/~gpkatch/gdate-method.html */

	GregorianDate date;
	int mi, ddd;

	date.year = (10000 * day + 14780) / 3652425;
	ddd = day - (
		365 * date.year +
		date.year / 4 -
		date.year / 100 +
		date.year / 400);

	if (ddd < 0)
	{
		date.year--;
		ddd = day - (
			365 * date.year +
			date.year / 4 -
			date.year / 100 +
			date.year / 400);
	}

	mi = (100 * ddd + 52) / 3060;
	date.month = (mi + 2) % 12 + 1;
	date.year = date.year + (mi + 2) / 12;
	date.day = ddd - (mi * 306 + 5) / 10 + 1;
	return date;
}

static int dateToDays(const GregorianDate date)
{
	/* https://alcor.concordia.ca/~gpkatch/gdate-algorithm.html */
	/* https://alcor.concordia.ca/~gpkatch/gdate-method.html */

	int month = (date.month + 9) % 12;
	int year = date.year - month / 10;
	int day = date.day;
	return
		365 * year + year / 4 - year / 100 + year / 400 +
		(month * 306 + 5) / 10 + (day - 1);
}

static int daysSinceEpoch(const GregorianDate date)
{
	return dateToDays(date) - dateToDays(epoch);
}

static InterpolatedLookupEntry interpolatedLookupSouth(int day)
{
	int dayOfYear = dayOfYearFromDayOfCentury(day);
	int index = dayOfYear / LOOKUP_STEP;
	int offset = dayOfYear % LOOKUP_STEP;
	LookupEntry *first = &lookupTable[index];
	LookupEntry *second = &lookupTable[
		(index + 1) < LOOKUP_LENGTH ? index + 1 : 0];

	InterpolatedLookupEntry interpolated = {
		first->sunriseReferenceMinute +
			(second->sunriseReferenceMinute - first->sunriseReferenceMinute) *
			offset / LOOKUP_STEP,

		first->sunriseMinuteSouth +
			(second->sunriseMinuteSouth - first->sunriseMinuteSouth) *
			offset / LOOKUP_STEP,

		first->sunsetReferenceMinute +
			(second->sunsetReferenceMinute - first->sunsetReferenceMinute) *
			offset / LOOKUP_STEP,

		first->sunsetMinuteSouth +
			(second->sunsetMinuteSouth - first->sunsetMinuteSouth) *
			offset / LOOKUP_STEP
	};

	return interpolated;
}

static short latitudeInterpolationMultiplier(double latitude)
{
	const int degreeResolution = 10;
	short difference = (short) (latitude >= LOOKUP_LATITUDE
		? (degreeResolution * (latitude - LOOKUP_LATITUDE) + 0.5)
		: (degreeResolution * (LOOKUP_LATITUDE - latitude) + 0.5));

	short multiplier =
		(difference << 8) /
		((LOOKUP_LATITUDE_NORTH - LOOKUP_LATITUDE) * degreeResolution);

	return multiplier;
}

static double lookupSunsetTime(int day, double latitude, double longitude)
{
	InterpolatedLookupEntry interpolated = latitude >= LOOKUP_LATITUDE
		? interpolatedLookupNorth(day)
		: interpolatedLookupSouth(day);

	short latitudeMultiplier = latitudeInterpolationMultiplier(latitude);

	short offset = (latitudeMultiplier * interpolated.sunsetMinuteOffset) >> 8;

	unsigned short minutes = interpolated.sunsetReferenceMinute + offset;

	/* TODO: ADD IN THE LONGITUDE DIFFERENCE, TOO */

	return minutes / (24.0 * 60.0);
}

static int writeLookupTableForAssembler(
	const char *const filename,
	double latitude,
	double longitude)
{
	FILE *fd = fopen(filename, "wt");
	if (!fd)
	{
		printf("Unable to open %s for writing.\n", filename);
		return 1;
	}

	printf("Writing table to %s...\n", filename);

	fprintf(fd, "\tradix decimal\n\n");
	fprintf(fd, "SunriseSunset code\n");
	fprintf(fd, "\tglobal sunriseSunsetLookup\n\n");
	fprintf(fd, "sunriseSunsetLookup:\n");
	for (int i = 0; i < LOOKUP_LENGTH; i++)
	{
		LookupEntry *entry = &lookupTable[i];
		fprintf(
			fd,
			"\t.dw 0x%.4hx, 0x%.4hx, 0x%.4hx, 0x%.4hx\n",
			(unsigned short) (
				((entry->sunriseReferenceMinute & 0x03f) << 8) |
				entry->sunriseMinuteNorth),
			(unsigned short) (
				((entry->sunsetReferenceMinute & 0x03f) << 8) |
				entry->sunriseMinuteSouth),
			(unsigned short) (
				((entry->sunriseReferenceMinute & 0x7c0) << 8) |
				entry->sunsetMinuteNorth),
			(unsigned short) (
				((entry->sunsetReferenceMinute & 0x7c0) << 8) |
				entry->sunsetMinuteSouth));
	}

	fprintf(fd, "\n\tend\n");

	fclose(fd);
	return 0;
}
