#include <stdio.h>
#include <math.h>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

#define DEG2RAD(phi) (double) ((phi) / 180 * M_PI)

#define LOOKUP_LENGTH 366
#define LOOKUP_LATITUDE 55
#define LOOKUP_LONGITUDE 0

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
	double latitude = 58;

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
			fittedSunrise);
	}

	fclose(fd);

	return 0;
}

static void calculateSunriseLookupTable(double *table, int length)
{
	for (int day = 0; day < length; day++)
		*(table++) = sunriseTime(day, LOOKUP_LATITUDE, LOOKUP_LONGITUDE);
}

#define FITTED(x, coeff, a, b, c, d) ( \
	coeff[(a)] * \
	sin(coeff[(b)] + coeff[(c)] * \
		(((double) (x)) / LOOKUP_LENGTH * 2 * M_PI)) + \
	coeff[(d)])

static double sunriseAdjustment(int day, double latitude)
{
	static const double coefficientsPositive[] = {
		2.5991e-03,
		-5.3287e-01,
		7.2085e-01,
		-9.9571e-05,
		-5.2110e-04,
		-7.1170e+00,
		2.9517e+00,
		-7.4622e-03,
		-1.1323e+00,
		9.1930e-01
	};

	static const double coefficientsNegative[] = {
		1.7599e-03,
		-1.0571e+00,
		9.8818e-01,
		-7.6638e-06,
		2.0864e-03,
		-1.4107e+01,
		9.7417e-01,
		2.4878e-04,
		-9.3913e-01,
		2.9895e+00
	};

	if (latitude > LOOKUP_LATITUDE)
	{
		return (latitude - LOOKUP_LATITUDE) * (
			FITTED(day, coefficientsPositive, 0, 1, 2, 3) +
			FITTED(day, coefficientsPositive, 4, 5, 6, 3) +
			FITTED(day, coefficientsPositive, 7, 8, 9, 3));
	}
	else
	{
		return (LOOKUP_LATITUDE - latitude) * (
			FITTED(day, coefficientsNegative, 0, 1, 2, 3) +
			FITTED(day, coefficientsNegative, 4, 5, 6, 3) +
			FITTED(day, coefficientsNegative, 7, 8, 9, 3));
	}
}
