/*
   Hacking playground for curve-fitting the accurate Sunrise / Sunset
   calculations documented at:

       https://alcor.concordia.ca/~gpkatch/gdate-method.html

   Coefficients can be calculated with the Octave '*curve-fit*.m' curve-fitting
   scripts and visualised with the Octave 'examine*.m' scripts.

   Years are specified from 0, so the Epoch (2000-01-01) is 0000-01-01.  This
   prevents integer overflow.

   The date calculations are done from a base of 0000-03-01 (ie. using March
   as the first month of the year).  This allows easy calculations on date
   differences without complicated leap year conditions.  See here:

       https://alcor.concordia.ca/~gpkatch/gdate-algorithm.html
       https://alcor.concordia.ca/~gpkatch/gdate-method.html

   The complicated date calculations shouldn't be necessary in the PIC as the
   curve-fitting algorithms only require the day of the year as their input
   parameter ([0,365] for leap years, [0,364] for regular years).
*/

#include <stdio.h>
#include <math.h>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

#define DEG2RAD(phi) (double) ((phi) / 180 * M_PI)

#define LOOKUP_LENGTH 366
#define LOOKUP_LATITUDE 55
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

static const GregorianDate epoch = {0, 1, 1};
static double sunriseLookupTable[LOOKUP_LENGTH];
static double sunsetLookupTable[LOOKUP_LENGTH];

static void initialiseLookupTables(void);
static void calculateSunriseLookupTable(double *table, int length);
static FixedQ1_15 fixedAdd(FixedQ1_15 a, FixedQ1_15 b);
static FixedQ1_15 fixedMul(FixedQ1_15 a, FixedQ1_15 b);
static FixedQ1_15 fixedAdd3(FixedQ1_15 a, FixedQ1_15 b, FixedQ1_15 c);
static FixedQ1_15 fixedAdd4(FixedQ1_15 a, FixedQ1_15 b, FixedQ1_15 c, FixedQ1_15 d);
static FixedQ1_15 sine(FixedQ0_16 phi);
static void calculateSunsetLookupTable(double *table, int length);
static int daysSinceEpoch(const GregorianDate date);
static int dateToDays(const GregorianDate date);
static double sunriseTime(int day, double latitude, double longitude);
static void sunEventTime(SunEventState *const state);
static void sunEventTimeIteration(SunEventState *const state);
static double sunsetTime(int day, double latitude, double longitude);
static int writeSunriseSunsetTable(const char *const filename);
static double fittedSunriseTime(int day, double latitude, double longitude);
static int dayOfYearFromDayOfCentury(int day);
static GregorianDate daysSinceEpochToDate(int day);
static GregorianDate daysToDate(int day);
static double fittedSunsetTime(int day, double latitude, double longitude);
static int writeFittedSunriseSunsetTable(const char *const filename);
static double sunriseAdjustment(int day, double latitude);
static double sunsetAdjustment(int day, double latitude);

int main(void)
{
	double latitude = 51.509865;
	double longitude = -0.118092;

	int epochDays = dateToDays(epoch);
	printf(
		"Epoch (2000-01-01) = %.4d-%.2d-%.2d\n",
		epoch.year, epoch.month, epoch.day);

	printf("Epoch day zero = %d\n", epochDays);

	initialiseLookupTables();
	for (int year = 0; year < 100; year++)
	{
		GregorianDate date = {year, 1, 1};
		int day = daysSinceEpoch(date);
		double timeOfSunrise = 24 * sunriseTime(day, latitude, longitude);
		int sunriseHour = (int) timeOfSunrise;
		int sunriseMinute = (int) ((timeOfSunrise - sunriseHour) * 60);

		double timeOfSunset = 24 * sunsetTime(day, latitude, longitude);
		int sunsetHour = (int) timeOfSunset;
		int sunsetMinute = (int) ((timeOfSunset - sunsetHour) * 60);

		printf("%d Sunrise time: %.2d:%.2d\n", day, sunriseHour, sunriseMinute);
		printf("%d Sunset time : %.2d:%.2d\n", day, sunsetHour, sunsetMinute);
	}

	return
		writeSunriseSunsetTable("sunrise-sunset.txt") +
		writeFittedSunriseSunsetTable("sunrise-sunset-fitted.txt");
}

static void initialiseLookupTables(void)
{
	calculateSunriseLookupTable(sunriseLookupTable, LOOKUP_LENGTH);
	calculateSunsetLookupTable(sunsetLookupTable, LOOKUP_LENGTH);
}

#define FITTED(x, coeff, a, b, c) \
	fixedMul(\
		coeff[(a)], \
		sine(fixedAdd( \
			coeff[(b)], \
			fixedMul(coeff[(c)], ((x) << 15) / LOOKUP_LENGTH)) << 1))

#define FITTED2(x, cMultiple, coeff, a, b, c) \
	fixedMul(\
		coeff[(a)], \
		sine(fixedAdd4( \
			coeff[(b)], \
			cMultiple > 0 ? ((x) << 15) / LOOKUP_LENGTH : 0, \
			cMultiple > 1 ? ((x) << 15) / LOOKUP_LENGTH : 0, \
			fixedMul(coeff[(c)], \
			((x) << 15) / LOOKUP_LENGTH)) << 1))

static void calculateSunriseLookupTable(double *table, int length)
{
/*
	static const double coefficients[] = {
		0.3898969,
		0.2572719,
		0.5758223,
		0.0192193,
		0.0065314,
		-0.2439130,
		2.4077379,
		0.1083663,
		0.3261631,
		0.9156712
	};
*/

	static const FixedQ1_15 coefficients[] = {
		(FixedQ1_15) 12776,
		(FixedQ1_15) 8430,
		(FixedQ1_15) 18869,
		(FixedQ1_15) 630,
		(FixedQ1_15) 214,
		(FixedQ1_15) -7993,
		(FixedQ1_15) 13361, /* PLUS TWO */
		(FixedQ1_15) 3551,
		(FixedQ1_15) 10688,
		(FixedQ1_15) 30005
	};

	for (int day = 0; day < length; day++)
	{
/*
		*(table++) = 32768 * (
			coefficients[0] +
			(coefficients[1] * sin((coefficients[2] + coefficients[3] * day / LOOKUP_LENGTH) * 2 * M_PI)) +
			(coefficients[4] * sin((coefficients[5] + coefficients[6] * day / LOOKUP_LENGTH) * 2 * M_PI)) +
			(coefficients[7] * sin((coefficients[8] + coefficients[9] * day / LOOKUP_LENGTH) * 2 * M_PI)));
*/

		*(table++) = fixedAdd4(
			coefficients[0],
			FITTED(day, coefficients, 1, 2, 3),
			FITTED2(day, 2, coefficients, 4, 5, 6),
			FITTED(day, coefficients, 7, 8, 9));
	}
}

static FixedQ1_15 fixedAdd(FixedQ1_15 a, FixedQ1_15 b)
{
	int result = (int) a + b;
	return (FixedQ1_15) (result & 0xffff);
}

static FixedQ1_15 fixedMul(FixedQ1_15 a, FixedQ1_15 b)
{
	int result = ((int) a * b) >> 15;
	return (FixedQ1_15) (result & 0xffff);
}

static FixedQ1_15 fixedAdd3(FixedQ1_15 a, FixedQ1_15 b, FixedQ1_15 c)
{
	int result = (int) a + b + c;
	return (FixedQ1_15) result;
}

static FixedQ1_15 fixedAdd4(FixedQ1_15 a, FixedQ1_15 b, FixedQ1_15 c, FixedQ1_15 d)
{
	int result = (int) a + b + c + d;
	return (FixedQ1_15) result;
}

static FixedQ1_15 sine(FixedQ0_16 phi)
{
	static FixedQ1_15 lookup[65536];
	static int isLookupInitialised = 0;

	if (!isLookupInitialised)
	{
		FILE *fd = fopen(
			"../../trigonometry/cordic/cordic-fixed-sine-table.bin",
			"rb");

		if (!fd)
		{
			printf("!!! FAILED TO OPEN CORDIC SINE LOOKUP FOR READING !!!\n");
			return 0;
		}

		for (int i = 0; i < 65536; i++)
		{
			unsigned char bytes[2];
			fread(bytes, 2, 1, fd);
			lookup[i] = (FixedQ1_15) (
				(((FixedQ0_16) bytes[0]) << 8) | ((FixedQ0_16) bytes[1]));
		}

		fclose(fd);
		isLookupInitialised = !0;
	}

	return lookup[phi];
}

static void calculateSunsetLookupTable(double *table, int length)
{
/*
	static const double coefficients[] = {
		0.738356,
		0.140778,
		0.906435,
		0.815517,
		0.012820,
		0.279684,
		1.779505,
		0.041605,
		0.605375,
		0.581904
	};
*/

	static const FixedQ1_15 coefficients[] = {
		(FixedQ1_15) 24194,
		(FixedQ1_15) 4613,
		(FixedQ1_15) 29702,
		(FixedQ1_15) 26723,
		(FixedQ1_15) 420,
		(FixedQ1_15) 9165,
		(FixedQ1_15) 25543, /* PLUS ONE */
		(FixedQ1_15) 1363,
		(FixedQ1_15) 19837,
		(FixedQ1_15) 19068
	};

	for (int day = 0; day < length; day++)
	{
/*
		*(table++) = 32768 * (
			coefficients[0] +
			(coefficients[1] * sin((coefficients[2] + coefficients[3] * day / LOOKUP_LENGTH) * 2 * M_PI)) +
			(coefficients[4] * sin((coefficients[5] + coefficients[6] * day / LOOKUP_LENGTH) * 2 * M_PI)) +
			(coefficients[7] * sin((coefficients[8] + coefficients[9] * day / LOOKUP_LENGTH) * 2 * M_PI)));
*/

		*(table++) = fixedAdd4(
			coefficients[0],
			FITTED(day, coefficients, 1, 2, 3),
			FITTED2(day, 1, coefficients, 4, 5, 6),
			FITTED(day, coefficients, 7, 8, 9));
	}
}

static int daysSinceEpoch(const GregorianDate date)
{
	return dateToDays(date) - dateToDays(epoch);
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

static int writeSunriseSunsetTable(const char *const filename)
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
		double referenceTimes[] = {
			sunriseTime(day, 55, 0),
			sunsetTime(day, 55, 0)
		};
		double fittedTimes[] = {
			fittedSunriseTime(day, 55, 0),
			fittedSunsetTime(day, 55, 0)
		};

		fprintf(
			fd,
			"%d"
				"\t%.8e\t%.8e"
				"\t%.8e\t%.8e"
			"\n",
			day,
			referenceTimes[0],
			fittedTimes[0],
			referenceTimes[1],
			fittedTimes[1]);
	}

	fclose(fd);
	return 0;
}

static double fittedSunriseTime(int day, double latitude, double longitude)
{
	int dayOfYear = dayOfYearFromDayOfCentury(day);

	if (dayOfYear < 7)
		dayOfYear = 357;

	if (dayOfYear > 357)
		dayOfYear = 357;

	return
		(sunriseLookupTable[dayOfYear] +
		sunriseAdjustment(dayOfYear, latitude)) / 32768;
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

static double fittedSunsetTime(int day, double latitude, double longitude)
{
	int dayOfYear = dayOfYearFromDayOfCentury(day);

	return 
		(sunsetLookupTable[dayOfYear] +
		sunsetAdjustment(dayOfYear, latitude)) / 32768;
}

static int writeFittedSunriseSunsetTable(const char *const filename)
{
	double latitude = 55;

	FILE *fd = fopen(filename, "wt");
	if (!fd)
	{
		printf("Unable to open %s for writing.\n", filename);
		return 1;
	}

	printf("Writing table to %s...\n", filename);

	for (int day = 0; day < LOOKUP_LENGTH; day++)
	{
		double fittedSunrise = fittedSunriseTime(day, latitude, 0);
		double actualSunrise = sunriseTime(day, latitude, LOOKUP_LONGITUDE);

		double fittedSunset = fittedSunsetTime(day, latitude, 0);
		double actualSunset = sunsetTime(day, latitude, LOOKUP_LONGITUDE);

		fprintf(
			fd,
			"%d"
				"\t%.8e\t%.8e"
				"\t%.8e\t%.8e"
			"\n",
			day,
			actualSunrise,
			fittedSunrise,
			actualSunset,
			fittedSunset);
	}

	fclose(fd);

	return 0;
}

static double sunriseAdjustment(int day, double latitude)
{
	static const FixedQ1_15 coefficientsPositive[] = {
		0,
		0,
		0,
		0,
		0,
		0,
		0
	};

	static const FixedQ1_15 coefficientsNegative[] = {
		0,
		0,
		0,
		0,
		0,
		0,
		0
	};

	if (latitude >= LOOKUP_LATITUDE)
	{
		return fixedMul(
			(FixedQ1_15) ((latitude - LOOKUP_LATITUDE) * 32768),
			fixedAdd3(
				coefficientsPositive[0],
				FITTED(day, coefficientsPositive, 1, 2, 3),
				FITTED(day, coefficientsPositive, 4, 5, 6)));
	}
	else
	{
		return fixedMul(
			(FixedQ1_15) ((latitude - LOOKUP_LATITUDE) * 32768),
			fixedAdd3(
				coefficientsNegative[0],
				FITTED(day, coefficientsNegative, 1, 2, 3),
				FITTED(day, coefficientsNegative, 4, 5, 6)));
	}
}

static double sunsetAdjustment(int day, double latitude)
{
	return 0;
}
