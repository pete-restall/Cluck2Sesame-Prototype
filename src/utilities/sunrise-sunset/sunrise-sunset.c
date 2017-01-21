/*
    From the algorithm described here:

        http://www.stargazing.net/kepler/sunrise.html

    Which in turn was derived from the Explanatory Supplement to the
    Astronomical Almanac section 9.33.

    Used in conjunction with the fantastic resources here:

        http://aa.usno.navy.mil/data/index.php

    Assumptions and notes:

        - The year is only allowed to be in the range [2000,2099]; a negative
          Julian Date is not allowed.  TODO: VERIFY JAN 1 2000 !!!

        - Only a 32-by-16 bit division is available.

        - The sine and cosine are builtins, not CORDIC.  The angle units will
          be translated to the same units used by the CORDIC implementation.

        - The sine and cosine of phi are computed at the same time by CORDIC,
          so identities such as sin(2 * phi) -> 2 * sin(phi) * cos(phi) are
          actually cheaper to implement.
*/

#include <stdio.h>
#include <string.h>
#include <math.h>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

#define LITERAL_0_77_Q0_16 0xc51f
#define LITERAL_0_46_Q0_16 0x75c3
#define LITERAL_36000_OVER_36525_Q0_16 0xfc52

#define LITERAL_0_05_Q0_16 0x0ccd
#define LITERAL_0_528_Q0_16 0x872b
#define LITERAL_35999_OVER_36525_Q0_16 0xfc50

#define LITERAL_0_915_Q1_15 ((FixedQ1_15) 0x751f)
#define LITERAL_0_04_Q1_15 ((FixedQ1_15) 0x051f)

#define LITERAL_0_466_Q1_15 ((FixedQ1_15) 0x3ba6)
#define LITERAL_0_053_Q1_15 ((FixedQ1_15) 0x06c9)

#define DEGREES_180_Q1_15 ((FixedQ1_15) 0x8000)

typedef struct
{
	int year : 16;
	int month : 8;
	int day : 8;
} GregorianDate;

typedef int JulianDate;

typedef int Accumulator;
typedef unsigned short FixedQ0_16;
typedef short FixedQ1_15;

typedef struct
{
	struct
	{
		int quiet : 1;
	} flags;

	FixedQ1_15 eventTime;
	JulianDate epochAsJulianDate;
	JulianDate julianDate;
	unsigned short daysSinceEpoch;
	Accumulator meanLongitudeIncludingAberration;
	FixedQ1_15 meanAnomaly;
	Accumulator equatorialCentreCorrection;
	FixedQ1_15 sunEclipticLongitude;
	FixedQ1_15 equationOfTime;
	FixedQ1_15 greenwichHourAngle;
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
static FixedQ1_15 degreesToUnits(Accumulator phi, int q);
static void calculateEquatorialCentreCorrection(SunState *state);
static FixedQ1_15 sine(FixedQ1_15 phi);
static FixedQ1_15 doubleToFixedQ1_15(double x);
static FixedQ1_15 cosine(FixedQ1_15 phi);
static void calculateSunEclipticLongitude(SunState *state);
static void calculateEquationOfTime(SunState *state);
static void calculateGreenwichHourAngle(SunState *state);
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
	state->eventTime = DEGREES_180_Q1_15;
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
	calculateEquatorialCentreCorrection(state);
	calculateSunEclipticLongitude(state);
	calculateEquationOfTime(state);
	calculateGreenwichHourAngle(state);
}

static void calculateDaysSinceEpoch(SunState *state)
{
	state->daysSinceEpoch =
		(unsigned short) state->julianDate - state->epochAsJulianDate;

	if (!state->flags.quiet)
		printf("\tDays since the Epoch: %hu\n", state->daysSinceEpoch);
}

static void calculateMeanLongitudeIncludingAberration(SunState *state)
{
	/*
	    L = 280.46 + 36000.77 * days / 36525
	      = 280 + 0.46 + 0.77 * days / 36525 + 36000 * days / 36525

	    Units: degrees (Q16.16)
	    Maximum: 0x8db93a4c
	*/

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
	/*
	    G = 357.528 + 35999.05 * days / 36525
	      = 357 + 0.528 + 0.05 * days / 36525 + 35999 * days / 36525

	    Units: degrees (converted to Q1.15 angle units)
	    Maximum: 0x8e047608
	*/

	Accumulator accumulator;
	accumulator = state->daysSinceEpoch * LITERAL_0_05_Q0_16;
	accumulator /= 36525;
	accumulator += state->daysSinceEpoch * LITERAL_35999_OVER_36525_Q0_16;
	accumulator += LITERAL_0_528_Q0_16;
	accumulator += 357 << 16;

	state->meanAnomaly = degreesToUnits(accumulator, 16);

	if (!state->flags.quiet)
	{
		printf(
			"\tMean Anomaly: 0x%.8x (%.8g deg) -> 0x%.4hx\n",
			accumulator,
			accumulator / 65536.0,
			state->meanAnomaly);
	}
}

static FixedQ1_15 degreesToUnits(Accumulator phi, int q)
{
	Accumulator circleMultiple = phi / 360;
	circleMultiple >>= q;
	circleMultiple *= 360;
	circleMultiple <<= q;

	phi += -circleMultiple;
	phi /= (q == 16 ? 360 : 180);
	return (FixedQ1_15) phi;
}

static void calculateEquatorialCentreCorrection(SunState *state)
{
	/* TODO: SINCE G IS NOW Q1.15, CAN WE JUST TAKE sin(2G) INSTEAD OF
	         MODIFYING CORDIC TO OUTPUT BOTH SINE AND COSINE TO USE THE
	         MULTIPLICATION BY IDENTITY ?  SINCE IF 2G OVERFLOWS, WE ONLY
	         NEED THE 16 LSbs ANYWAY - WE GET FREE CIRCLE MODULO (AND A
	         LEFT-SHIFT BY ONE PLACE IS QUICK) */

	/*
	    ec = 1.915 * sin(G) + 0.02 * sin(2 * G)
           = 1.915 * sin(G) + 0.02 * (2 * sin(G) * cos(G))
	       = sin(G) + 0.915 * sin(G) + 0.04 * sin(G) * cos(G)

	    Units: degrees (Q17.15)
	*/

	FixedQ1_15 sinG = sine(state->meanAnomaly);
	FixedQ1_15 cosG = cosine(state->meanAnomaly);
	FixedQ1_15 sinCosProduct = ((int) sinG * cosG) >> 15;
	Accumulator accumulator = sinG;
	accumulator <<= 15;
	accumulator += LITERAL_0_915_Q1_15 * sinG;
	accumulator += LITERAL_0_04_Q1_15 * sinCosProduct;
	accumulator >>= 15;

	state->equatorialCentreCorrection = accumulator;

	if (!state->flags.quiet)
	{
		printf(
			"\tEquatorial Centre Correction: 0x%.8x (%.8g deg)\n",
			state->equatorialCentreCorrection,
			((double) state->equatorialCentreCorrection) / (1 << 15));
	}
}

static FixedQ1_15 sine(FixedQ1_15 phi)
{
	return doubleToFixedQ1_15(sin(phi / 32768.0 * M_PI));
}

static FixedQ1_15 doubleToFixedQ1_15(double x)
{
	double value = x * 32768 + 0.5;
	if (value > 32767)
		return 0x7fff;

	if (value < -32768)
		return (FixedQ1_15) 0x8000;

	return (FixedQ1_15) value;
}

static FixedQ1_15 cosine(FixedQ1_15 phi)
{
	return doubleToFixedQ1_15(cos(phi / 32768.0 * M_PI));
}

static void calculateSunEclipticLongitude(SunState *state)
{
	/*
	    lambda = L + ec

	    Units: degrees (converted to Q1.15 angle units)
	*/

	Accumulator accumulator = state->meanLongitudeIncludingAberration >> 1;
	accumulator += state->equatorialCentreCorrection;

	state->sunEclipticLongitude = degreesToUnits(accumulator, 15);

	if (!state->flags.quiet)
	{
		printf(
			"\tEcliptic Longitude of the Sun: 0x%.8x (%.8g deg) -> 0x%.4hx\n",
			accumulator,
			accumulator / 32768.0,
			state->sunEclipticLongitude);
	}
}

static void calculateEquationOfTime(SunState *state)
{
	/*
	    E = -ec + 2.466 * sin(2 * lambda) - 0.053 * sin(4 * lambda)
          = -ec + sin(2 * lambda) + sin(2 * lambda) + 0.466 * sin(2 * lambda) -
	        0.053 * sin(4 * lambda)

	    Units: degrees (converted to Q1.15 angle units)
	*/

	FixedQ1_15 sin2Lambda = sine(state->sunEclipticLongitude << 1);
	FixedQ1_15 sin4Lambda = sine(state->sunEclipticLongitude << 2);
	Accumulator accumulatorA = LITERAL_0_466_Q1_15 * sin2Lambda;
	Accumulator accumulatorB = LITERAL_0_053_Q1_15 * sin4Lambda;
	accumulatorA >>= 15;
	accumulatorB >>= 15;
	accumulatorA += sin2Lambda;
	accumulatorA += sin2Lambda;
	accumulatorA += -state->equatorialCentreCorrection;
	accumulatorA += -accumulatorB;

	state->equationOfTime = degreesToUnits(accumulatorA, 15);

	if (!state->flags.quiet)
	{
		printf(
			"\tEquation of Time: 0x%.8x (%.8g deg) -> 0x%.4hx\n",
			accumulatorA,
			accumulatorA / 32768.0,
			state->equationOfTime);
	}
}

static void calculateGreenwichHourAngle(SunState *state)
{
	/*
	    GHA = UTo - 180 + E

	    Units: degrees (converted to Q1.15 angle units)
	*/

	Accumulator accumulator = state->eventTime;
	accumulator += state->equationOfTime;
	accumulator += -DEGREES_180_Q1_15;

	state->greenwichHourAngle = (FixedQ1_15) (accumulator & 0xffff);

	if (!state->flags.quiet)
	{
		printf(
			"\tGrenwich Hour Angle: 0x%.8x (%.8g deg) -> 0x%.4hx\n",
			accumulator,
			180 * state->greenwichHourAngle / 32768.0,
			state->greenwichHourAngle);
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
