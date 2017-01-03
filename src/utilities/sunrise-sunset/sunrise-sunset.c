/*
    From the algorithm described here:

        http://www.stargazing.net/kepler/sunrise.html

    Which in turn was derived from the Explanatory Supplement to the
    Astronomical Almanac section 9.33.

    Used in conjunction with the fantastic resources here:

        http://aa.usno.navy.mil/data/index.php
*/

#include <stdio.h>
#include <string.h>

#define LITERAL_0_77_Q0_16 0xc51f
#define LITERAL_0_46_Q0_16 0x75c3
#define LITERAL_36000_OVER_36525_Q0_16 0xfc52

#define LITERAL_0_05_Q0_16 0x0ccd
#define LITERAL_0_528_Q0_16 0x872b
#define LITERAL_35999_OVER_36525_Q0_16 0xfc50

typedef struct
{
	int year : 16;
	int month : 8;
	int day : 8;
} GregorianDate;

typedef int JulianDate;

typedef unsigned int Accumulator;
typedef unsigned short FixedQ0_16;
typedef unsigned short FixedQ1_15;

typedef struct
{
	struct
	{
		int quiet : 1;
	} flags;

	JulianDate epochAsJulianDate;
	JulianDate julianDate;
	unsigned short daysSinceEpoch;
	Accumulator meanLongitudeIncludingAberration;
	Accumulator meanAnomaly;
} SunState;

static void initialiseState(SunState *state);
static JulianDate calculateJulianDateAtMidday(
	SunState *state,
	GregorianDate date);

static GregorianDate date(int year, int month, int day);
static void calculateSunriseOn(SunState *state, GregorianDate date);
static void calculateEventOn(SunState *state, GregorianDate date);
static void calculateDaysSinceEpoch(SunState *state);
static void calculateMeanLongitudeIncludingAberration(SunState *state);
static void calculateMeanAnomaly(SunState *state);
static void calculateSunsetOn(SunState *state, GregorianDate date);

int main(int argc, char *argv[])
{
	SunState state;
	initialiseState(&state);
	calculateSunriseOn(&state, date(2000, 2, 1));
	calculateSunsetOn(&state, date(2099, 2, 1));
	return 0;
}

static void initialiseState(SunState *state)
{
	if (!state->flags.quiet)
		printf("Initialising state...\n");

	memset(state, 0, sizeof(SunState));
	state->epochAsJulianDate = calculateJulianDateAtMidday(
		state,
		date(2000, 1, 1));
}

static int calculateJulianDateAtMidday(
	SunState *state,
	GregorianDate date)
{
	/* http://aa.usno.navy.mil/faq/docs/JD_Formula.php */

	int monthMinus14Over12 = (date.month - 14) / 12;
	int julianDate =
		date.day - 32075 +
		1461 * (date.year + 4800 + monthMinus14Over12) / 4 +
		367 * (date.month - 2 - monthMinus14Over12 * 12) / 12 -
		3 * ((date.year + 4900 + monthMinus14Over12) / 100) / 4;

	if (!state->flags.quiet)
	{
		printf(
			"\tJulian date at midday on %d-%.2d-%.2d is %d\n",
			date.year,
			date.month,
			date.day,
			julianDate);
	}

	return julianDate;
}

static GregorianDate date(int year, int month, int day)
{
	GregorianDate date = {year, month, day};
	return date;
}

static void calculateSunriseOn(SunState *state, GregorianDate date)
{
	if (!state->flags.quiet)
	{
		printf(
			"Calculating sunrise on %d-%.2d-%.2d:\n",
			date.year,
			date.month,
			date.day);
	}

	calculateEventOn(state, date);
}

static void calculateEventOn(SunState *state, GregorianDate date)
{
	state->julianDate = calculateJulianDateAtMidday(state, date);
	calculateDaysSinceEpoch(state);
	calculateMeanLongitudeIncludingAberration(state);
	calculateMeanAnomaly(state);
}

static void calculateDaysSinceEpoch(SunState *state)
{
	state->daysSinceEpoch =
		(unsigned short) state->julianDate - state->epochAsJulianDate;

	if (!state->flags.quiet)
		printf("\tDays since the Epoch: %hd\n", state->daysSinceEpoch);
}

static void calculateMeanLongitudeIncludingAberration(SunState *state)
{
	Accumulator accumulator;
	accumulator = state->daysSinceEpoch * LITERAL_0_77_Q0_16;
	accumulator /= 36525;
	accumulator += state->daysSinceEpoch * LITERAL_36000_OVER_36525_Q0_16;
	accumulator += LITERAL_0_46_Q0_16;
	accumulator += 280 << 16;

	state->meanLongitudeIncludingAberration = accumulator;

	if (!state->flags.quiet)
	{
		printf(
			"\tMean Longitude (including aberration): 0x%.8x (%.8g deg)\n",
			state->meanLongitudeIncludingAberration,
			state->meanLongitudeIncludingAberration / 65536.0);
	}
}

static void calculateMeanAnomaly(SunState *state)
{
	Accumulator accumulator;
	accumulator = state->daysSinceEpoch * LITERAL_0_05_Q0_16;
	accumulator /= 36525;
	accumulator += state->daysSinceEpoch * LITERAL_35999_OVER_36525_Q0_16;
	accumulator += LITERAL_0_528_Q0_16;
	accumulator += 357 << 16;

	state->meanAnomaly = accumulator;

	if (!state->flags.quiet)
	{
		printf(
			"\tMean Anomaly: 0x%.8x (%.8g deg)\n",
			state->meanAnomaly,
			state->meanAnomaly / 65536.0);
	}
}

static void calculateSunsetOn(SunState *state, GregorianDate date)
{
	if (!state->flags.quiet)
	{
		printf(
			"Calculating sunset on %d-%.2d-%.2d:\n",
			date.year,
			date.month,
			date.day);
	}

	calculateEventOn(state, date);
}
