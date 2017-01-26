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
	double day;
	double latitude;
	double longitude;
	double eventHeight;
	double correctionSign;
	double eventTime;
} SunEventState;

static double sunriseTime(int day, double latitude, double longitude);
static void sunEventTime(SunEventState *const state);
static void sunEventTimeIteration(SunEventState *const state);
static double sunsetTime(int day, double latitude, double longitude);
static int daysSinceEpoch(int year, int month, int day);
static int dateToDays(int year, int month, int day);
static int writeSunriseSunsetTable(const char *const filename);
static int writeFittedSunriseSunsetTable(const char *const filename);
static void calculateSunriseLookupTable(double *table, int length);
static FixedQ1_15 fixedAdd(FixedQ1_15 a, FixedQ1_15 b);
static FixedQ1_15 fixedMul(FixedQ1_15 a, FixedQ1_15 b);
static FixedQ1_15 fixedAdd3(FixedQ1_15 a, FixedQ1_15 b, FixedQ1_15 c);
static FixedQ1_15 fixedAdd4(FixedQ1_15 a, FixedQ1_15 b, FixedQ1_15 c, FixedQ1_15 d);
static FixedQ1_15 sine(FixedQ0_16 phi);
static double sunriseAdjustment(int day, double latitude);

int main(void)
{
	double latitude = 51.509865;
	double longitude = -0.118092;

	for (int year = 2000; year < 2100; year++)
	{
		int day = daysSinceEpoch(year, 1, 1);
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

static int daysSinceEpoch(int year, int month, int day)
{
	return dateToDays(year, month, day) - dateToDays(2000, 1, 1);
}

static int dateToDays(int year, int month, int day)
{
	month = (month + 9) % 12;
	year -= month / 10;
	return
		365 * year + year / 4 - year / 100 + year / 400 +
		(month * 306 + 5) / 10 + (day - 1);
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
		double timeOfSunrise[] = {
			sunriseTime(day, 50, -6),
			sunriseTime(day, 50, 2),
			sunriseTime(day, 58, 2),
			sunriseTime(day, 58, -6),
			sunriseTime(day, 55, 0),
			sunriseTime(day, 60, 0),
			sunriseTime(day, 50, 0)
		};
		double timeOfSunset[] = {
			sunsetTime(day, 50, -6),
			sunsetTime(day, 50, 2),
			sunsetTime(day, 58, 2),
			sunsetTime(day, 58, -6),
			sunriseTime(day, 55, 0),
			sunriseTime(day, 60, 0),
			sunriseTime(day, 50, 0)
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
			"\n",
			day,
			timeOfSunrise[0],
			timeOfSunset[0],
			timeOfSunrise[1],
			timeOfSunset[1],
			timeOfSunrise[2],
			timeOfSunset[2],
			timeOfSunrise[3],
			timeOfSunset[3],
			timeOfSunrise[4],
			timeOfSunset[4],
			timeOfSunrise[5],
			timeOfSunset[5],
			timeOfSunrise[6],
			timeOfSunset[6]);
	}

	fclose(fd);
	return 0;
}

static int writeFittedSunriseSunsetTable(const char *const filename)
{
	double sunriseLookupTable[LOOKUP_LENGTH];
	double latitude = 55;

	FILE *fd = fopen(filename, "wt");
	if (!fd)
	{
		printf("Unable to open %s for writing.\n", filename);
		return 1;
	}

	printf("Writing table to %s...\n", filename);

	calculateSunriseLookupTable(sunriseLookupTable, LOOKUP_LENGTH);

	for (int day = 0; day < LOOKUP_LENGTH; day++)
	{
		double fittedSunrise =
			sunriseLookupTable[day] + sunriseAdjustment(day, latitude);

		double actualSunrise = sunriseTime(day, latitude, LOOKUP_LONGITUDE);

		fprintf(
			fd,
			"%d"
				"\t%.8e\t%.8e"
			"\n",
			day,
			actualSunrise,
			fittedSunrise / 32768);
	}

	fclose(fd);

	return 0;
}

#define FITTED(x, coeff, a, b, c) \
	fixedMul(\
		coeff[(a)], \
		sine(fixedAdd( \
			coeff[(b)], \
			fixedMul(coeff[(c)], ((x) << 15) / 366)) << 1))

#define FITTED2(x, coeff, a, b, c) \
	fixedMul(\
		coeff[(a)], \
		sine(fixedAdd4( \
			coeff[(b)], \
			((x) << 15) / 366, \
			((x) << 15) / 366, \
			fixedMul(coeff[(c)], \
			((x) << 15) / 366)) << 1))

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
			(coefficients[1] * sin((coefficients[2] + coefficients[3] * day / 366) * 2 * M_PI)) +
			(coefficients[4] * sin((coefficients[5] + coefficients[6] * day / 366) * 2 * M_PI)) +
			(coefficients[7] * sin((coefficients[8] + coefficients[9] * day / 366) * 2 * M_PI)));
*/

		*(table++) = fixedAdd4(
			coefficients[0],
			FITTED(day, coefficients, 1, 2, 3),
			FITTED2(day, coefficients, 4, 5, 6),
			FITTED(day, coefficients, 7, 8, 9));
	}
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
