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
static FixedQ1_15 fixedAdd5(
	FixedQ1_15 a,
	FixedQ1_15 b,
	FixedQ1_15 c,
	FixedQ1_15 d,
	FixedQ1_15 e);

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
static FixedQ1_15 sunriseLatitudeAdjustment(int day, double latitude);
static FixedQ1_15 interpolateSunEvent(
	double latitudeDifference,
	FixedQ1_15 adjustment);

static FixedQ1_15 longitudeAdjustment(double longitude);
static FixedQ1_15 sunsetLatitudeAdjustment(int day, double latitude);

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

		double timeOfFittedSunrise =
			24 * fittedSunriseTime(day, latitude, longitude);
		int fittedSunriseHour = (int) timeOfFittedSunrise;
		int fittedSunriseMinute =
			(int) ((timeOfFittedSunrise - fittedSunriseHour) * 60);

		double timeOfSunset = 24 * sunsetTime(day, latitude, longitude);
		int sunsetHour = (int) timeOfSunset;
		int sunsetMinute = (int) ((timeOfSunset - sunsetHour) * 60);

		double timeOfFittedSunset =
			24 * fittedSunsetTime(day, latitude, longitude);
		int fittedSunsetHour = (int) timeOfFittedSunset;
		int fittedSunsetMinute =
			(int) ((timeOfFittedSunset - fittedSunsetHour) * 60);

		printf(
			"%d Sunrise time: %.2d:%.2d (approximately %.2d:%.2d)\n",
			day,
			sunriseHour,
			sunriseMinute,
			fittedSunriseHour,
			fittedSunriseMinute);

		printf(
			"%d Sunset time : %.2d:%.2d (approximately %.2d:%.2d)\n",
			day,
			sunsetHour,
			sunsetMinute,
			fittedSunsetHour,
			fittedSunsetMinute);
	}

	return
		writeSunriseSunsetTable("sunrise-sunset-reference.txt") +
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
		sine(fixedAdd5( \
			coeff[(b)], \
			cMultiple > 0 ? ((x) << 15) / LOOKUP_LENGTH : 0, \
			cMultiple > 1 ? ((x) << 15) / LOOKUP_LENGTH : 0, \
			cMultiple > 2 ? ((x) << 15) / LOOKUP_LENGTH : 0, \
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

		*(table++) = fixedAdd5(
			0,
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

static FixedQ1_15 fixedAdd5(
	FixedQ1_15 a,
	FixedQ1_15 b,
	FixedQ1_15 c,
	FixedQ1_15 d,
	FixedQ1_15 e)
{
	int result = (int) a + b + c + d + e;
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

		*(table++) = fixedAdd5(
			0,
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
		double sunriseTimes[] = {
			sunriseTime(day, 55, 0),
			fittedSunriseTime(day, 55, 0),
			sunriseTime(day, 60, 0),
			sunriseTime(day, 50, 0)
		};

		double sunsetTimes[] = {
			sunsetTime(day, 55, 0),
			fittedSunsetTime(day, 55, 0),
			sunsetTime(day, 60, 0),
			sunsetTime(day, 50, 0)
		};

		fprintf(
			fd,
			"%d"
				"\t%.8e\t%.8e"
				"\t%.8e\t%.8e"
				"\t%.8e\t%.8e"
				"\t%.8e\t%.8e"
			"\n",
			day,
			sunriseTimes[0],
			sunsetTimes[0],
			sunriseTimes[1],
			sunsetTimes[1],
			sunriseTimes[2],
			sunsetTimes[2],
			sunriseTimes[3],
			sunsetTimes[3]);
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
		sunriseLatitudeAdjustment(dayOfYear, latitude) +
		longitudeAdjustment(longitude)) / 32768;
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
		sunsetLatitudeAdjustment(dayOfYear, latitude) +
		longitudeAdjustment(longitude)) / 32768;
}

static int writeFittedSunriseSunsetTable(const char *const filename)
{
	double latitude = 55.0;
	double longitude = 0.0;

	FILE *fd = fopen(filename, "wt");
	if (!fd)
	{
		printf("Unable to open %s for writing.\n", filename);
		return 1;
	}

	printf("Writing table to %s...\n", filename);

	for (int day = 0; day < LOOKUP_LENGTH; day++)
	{
		double fittedSunrise = fittedSunriseTime(day, latitude, longitude);
		double actualSunrise = sunriseTime(day, latitude, longitude);

		double fittedSunset = fittedSunsetTime(day, latitude, longitude);
		double actualSunset = sunsetTime(day, latitude, longitude);

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

static FixedQ1_15 sunriseLatitudeAdjustment(int day, double latitude)
{
/*
	static const double coefficientsPositive[] = {
		-0.0150405,
		-0.0065156,
		-0.3172214,
		0.0027572,
		0.0054313,
		-0.6837716,
		0.9239776,
		0.0097276,
		-0.7135158,
		0.0024573
	};

	static const double coefficientsNegative[] = {
		-0.0111063,
		-0.0116334,
		-0.1816415,
		-0.3339923,
		-0.0012709,
		-0.9382433,
		1.4463577,
		0.0080276,
		-0.4461986,
		-0.2802890
	};
*/

	static const FixedQ1_15 coefficientsPositive[] = {
		(FixedQ1_15) -493,
		(FixedQ1_15) -214,
		(FixedQ1_15) -10395,
		(FixedQ1_15) 90,
		(FixedQ1_15) 178,
		(FixedQ1_15) -22406,
		(FixedQ1_15) 30277,
		(FixedQ1_15) 319,
		(FixedQ1_15) -23380,
		(FixedQ1_15) 81
	};

	static const FixedQ1_15 coefficientsNegative[] = {
		(FixedQ1_15) -364,
		(FixedQ1_15) -381,
		(FixedQ1_15) -5952,
		(FixedQ1_15) -10944,
		(FixedQ1_15) -42,
		(FixedQ1_15) -30744,
		(FixedQ1_15) 14626, /* PLUS ONE */
		(FixedQ1_15) 263,
		(FixedQ1_15) -14621,
		(FixedQ1_15) -9185
	};

	double latitudeDifference = fabs(latitude - LOOKUP_LATITUDE);

	FixedQ1_15 adjustment = latitude > LOOKUP_LATITUDE
		? fixedAdd5(
			0,
			coefficientsPositive[0],
			FITTED(day, coefficientsPositive, 1, 2, 3),
			FITTED(day, coefficientsPositive, 4, 5, 6),
			FITTED(day, coefficientsPositive, 7, 8, 9))
		: fixedAdd5(
			0,
			coefficientsNegative[0],
			FITTED(day, coefficientsNegative, 1, 2, 3),
			FITTED2(day, 1, coefficientsNegative, 4, 5, 6),
			FITTED(day, coefficientsNegative, 7, 8, 9));

	return interpolateSunEvent(latitudeDifference, adjustment);
}

static FixedQ1_15 interpolateSunEvent(
	double latitudeDifference,
	FixedQ1_15 adjustment)
{
	int iterations = (int) latitudeDifference;

	FixedQ1_15 latitudeFraction =
		(FixedQ1_15) ((latitudeDifference - iterations) * 32768);

	int accumulator = fixedMul(latitudeFraction, adjustment);
	for (int i = 0; i < iterations; i++)
		accumulator += adjustment;

	return accumulator;
}

static FixedQ1_15 longitudeAdjustment(double longitude)
{
	int differenceInTenthsOfDegree =
		(int) ((longitude - LOOKUP_LONGITUDE) * 10);

	return (FixedQ1_15) (differenceInTenthsOfDegree * -8);
}

static FixedQ1_15 sunsetLatitudeAdjustment(int day, double latitude)
{
/*
	static const double coefficientsPositive[] = {
		2.0157e-02,
		5.1045e-03,
		7.9097e-01,
		9.8548e-01,
		2.7135e-02,
		8.6629e-01,
		1.8893e-03,
		9.3824e-04,
		7.9225e-01,
		3.1405e+00
	};

	static const double coefficientsNegative[] = {
		0.0365669,
		0.0046257,
		0.7767135,
		2.1298537,
		0.0395382,
		0.6516846,
		0.2099763,
		-0.0039906,
		-0.2582441,
		2.2096205
	};
*/

	static const FixedQ1_15 coefficientsPositive[] = {
		(FixedQ1_15) 661,
		(FixedQ1_15) 167,
		(FixedQ1_15) 25919,
		(FixedQ1_15) 32292,
		(FixedQ1_15) 889,
		(FixedQ1_15) 28387,
		(FixedQ1_15) 62,
		(FixedQ1_15) 31,
		(FixedQ1_15) 25960,
		(FixedQ1_15) 4604, /* PLUS THREE */
	};

	static const FixedQ1_15 coefficientsNegative[] = {
		(FixedQ1_15) 1198,
		(FixedQ1_15) 152,
		(FixedQ1_15) 25451,
		(FixedQ1_15) 4255, /* PLUS TWO */
		(FixedQ1_15) 1296,
		(FixedQ1_15) 21354,
		(FixedQ1_15) 6881,
		(FixedQ1_15) -131,
		(FixedQ1_15) -8462,
		(FixedQ1_15) 6869 /* PLUS TWO */
	};

	double latitudeDifference = fabs(latitude - LOOKUP_LATITUDE);

	FixedQ1_15 adjustment = latitude > LOOKUP_LATITUDE
		? fixedAdd5(
			0,
			coefficientsPositive[0],
			FITTED(day, coefficientsPositive, 1, 2, 3),
			FITTED(day, coefficientsPositive, 4, 5, 6),
			FITTED2(day, 3, coefficientsPositive, 7, 8, 9))
		: fixedAdd5(
			0,
			coefficientsNegative[0],
			FITTED2(day, 2, coefficientsNegative, 1, 2, 3),
			FITTED(day, coefficientsNegative, 4, 5, 6),
			FITTED2(day, 2, coefficientsNegative, 7, 8, 9));

	return interpolateSunEvent(latitudeDifference, adjustment);
}
