/*
    Hack to evaluate CORDIC as a trigonometry function calculator, using
    fixed-point operations that could be easily implemented on a PIC16F685.

        Angles                 Vectors

         0.5                    0 + jy
          |                       |
    -1 ---+--- 0       -x + j0 ---+--- x + j0
          |                       |
        -0.5                    0 - jy

    Angles are represented as -1 <= phi < 1 so they fit easily into Q1.15
    fixed-point, rather than using radians or degrees.  So:

        phi > 0.5 means phi > 90 degrees
        phi < -0.5 means phi < -90 degrees

    Fixed-point of 'Pseudo 14-bit' represents the values that would be stored
    in flash, but are actually in a 16-bit word.  Saturation (both negative
    and positive) is generally performed in conversion between Qx.y formats.

    Short integers are assumed to be 16-bit.  Integers are assumed to be
    32-bit.  If sizes differ, adjust typedefs and printf() format specifiers.
    Representation is assumed to be two's complement.

    Right shifting signed values is assumed to be implemented as an arithmetic
    shift; right shifting of unsigned values is assumed to be implemented as
    a logical shift.
*/

#include <stdio.h>
#include <string.h>
#include <math.h>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

#define NUMBER_OF_ITERATIONS 15

#define DEGREES_0 0
#define DEGREES_90 ((FixedQ1_15) 0x4000)
#define DEGREES_NEGATIVE90 ((FixedQ1_15) 0xc000)

#define ALMOST_ONE_Q1_15 ((FixedQ1_15) 0x7fff)
#define ONE_Q2_30 ((FixedQ2_30) 0x40000000)
#define ONE_QUARTER_Q0_16 ((FixedQ0_16) 0x4000)

typedef unsigned short FixedQ0_16;
typedef short FixedQ1_15;
typedef int FixedQ1_31;
typedef int FixedQ2_30;
typedef int FixedQ16_16;
typedef int FixedQ17_15;

typedef struct
{
	struct
	{
		int printIterations : 1;
		int computeArc : 1;
	} flags;

	FixedQ1_15 atanLookup[NUMBER_OF_ITERATIONS];
	double gain;
	FixedQ1_15 gainReciprocal;
	double hyperbolicGain;
	double hyperbolicGainReciprocal;
	FixedQ1_15 hyperbolicGainReciprocalFractional;

	int iterationNumber;
	FixedQ1_15 argument;
	FixedQ17_15 x;
	FixedQ17_15 y;
	FixedQ17_15 accumulator;
	FixedQ17_15 error;
} CordicState;

static void cordicInitialise(CordicState *state);
static FixedQ1_15 fixedQ1_15ToPseudoQ0_14(FixedQ1_15 x);
static FixedQ1_15 doubleToFixedQ1_15(double x);
static void printSelectedFunctions(CordicState *state);
static double fixedQ1_15ToDouble(FixedQ1_15 x);
static FixedQ1_15 fixedQ17_15ToQ1_15(FixedQ17_15 x);
static FixedQ0_16 doubleToFixedQ0_16(double x);
static double fixedQ0_16ToDouble(FixedQ0_16 x);
static void cordicComputeSineAndCosine(CordicState *state, FixedQ1_15 x);
static int isGreaterThan90Degrees(FixedQ1_15 value);
static int isLessThanNegative90Degrees(FixedQ1_15 value);
static void cordicIteration(CordicState *state);
static void cordicComputeArcSine(CordicState *state, FixedQ1_15 x);
static FixedQ0_16 fixedQ2_30ToQ0_16(FixedQ2_30 x);
static FixedQ1_15 fixedQ16_16ToQ1_15(FixedQ16_16 x);
static void cordicComputeArcCosine(CordicState *state, FixedQ1_15 x);
static FixedQ17_15 negateQ17_15(FixedQ17_15 x);
static void cordicComputeSqrt(CordicState *state, FixedQ0_16 x);
static FixedQ0_16 fixedQ1_31ToQ0_16(FixedQ1_31 x);
static void cordicSqrtIteration(CordicState *state);
static void cordicComputeArcTangentOfRatio(CordicState *state, FixedQ1_15 y, FixedQ1_15 x);
static void writeTablesToFiles(CordicState *state);
static void writeTextTablesToFile(CordicState *state);
static int isDoubleNonZero(double x);
static void writeBinarySineTableToFile(CordicState *state);
static void writeBinaryArcSineTableToFile(CordicState *state);
static void writeBinaryCosineTableToFile(CordicState *state);
static void writeBinaryArcCosineTableToFile(CordicState *state);

int main(int argc, char *argv[])
{
	CordicState state;
	cordicInitialise(&state);

	printSelectedFunctions(&state);
	writeTablesToFiles(&state);
	return 0;
}

static void cordicInitialise(CordicState *state)
{
	memset(state, 0, sizeof(CordicState));
	state->gain = 1;
	state->hyperbolicGain = 1;
	for (int i = 0; i < NUMBER_OF_ITERATIONS; i++)
	{
		double power2 = pow(2, -i);
		double twoPower2 = pow(2, -2 * i);
		double atanPower2 = atan(power2);
		state->atanLookup[i] = fixedQ1_15ToPseudoQ0_14(
			doubleToFixedQ1_15(atanPower2 / M_PI));

		state->gain *= sqrt(1 + twoPower2);
		state->gainReciprocal = fixedQ1_15ToPseudoQ0_14(
			doubleToFixedQ1_15(1 / state->gain));

		state->hyperbolicGain *= sqrt(1 - pow(2, -2 * (i + 1)));
		state->hyperbolicGainReciprocal = 1 / state->hyperbolicGain;
		state->hyperbolicGainReciprocalFractional = fixedQ1_15ToPseudoQ0_14(
			doubleToFixedQ1_15(state->hyperbolicGainReciprocal - 1));

		printf(
			"atan(2^-%d) = %g deg (%g -> 0x%.4hx unit), "
				"gain = %g, gain^-1 = %g -> 0x%.4hx, "
				"hyperbolicGain = %g, hyperbolicGain^-1 = %g, "
				"hyperbolicGain^-1 - 1 = %g -> 0x%.4hx\n",
			i,
			atanPower2 * 180 / M_PI,
			atanPower2 / M_PI,
			state->atanLookup[i],
			state->gain,
			1 / state->gain,
			state->gainReciprocal,
			state->hyperbolicGain,
			state->hyperbolicGainReciprocal,
			state->hyperbolicGainReciprocal - 1,
			state->hyperbolicGainReciprocalFractional);
	}
}

static FixedQ1_15 fixedQ1_15ToPseudoQ0_14(FixedQ1_15 x)
{
	if (x & 0x0001)
		return (x & 0x7ffe) + 2;

	return x & 0x7ffe;
}

static FixedQ1_15 doubleToFixedQ1_15(double x)
{
	return (FixedQ1_15) ((x * 32768) + 0.5);
}

static void printSelectedFunctions(CordicState *state)
{
	FixedQ1_15 argument = 0x7fff;
	double argumentAsDouble = fixedQ1_15ToDouble(argument);

	FixedQ1_15 atanDenominator;
	double atanDenominatorAsDouble;

	cordicComputeSineAndCosine(state, argument);

	printf(
		"sin(pi * 0x%.4hx -> %g) = %g, cordicSin(0x%.4hx) = 0x%.4hx -> %g\n",
		argument,
		argumentAsDouble,
		sin(argumentAsDouble * M_PI),
		argument,
		fixedQ17_15ToQ1_15(state->y),
		fixedQ1_15ToDouble(fixedQ17_15ToQ1_15(state->y)));

	printf(
		"cos(pi * 0x%.4hx -> %g) = %g, cordicCos(0x%.4hx) = 0x%.4hx -> %g\n",
		argument,
		argumentAsDouble,
		cos(argumentAsDouble * M_PI),
		argument,
		fixedQ17_15ToQ1_15(state->x),
		fixedQ1_15ToDouble(fixedQ17_15ToQ1_15(state->x)));

	argument = (unsigned short) 0xc000;
	argumentAsDouble = fixedQ1_15ToDouble(argument);
	state->flags.printIterations = ~0;
	cordicComputeArcSine(state, argument);
	printf(
		"asin(0x%.4hx -> %g) = %g, "
		"cordicAsin(0x%.4hx) = 0x%.4hx -> %g -> %g * pi -> %g\n",
		argument,
		argumentAsDouble,
		asin(argumentAsDouble),
		argument,
		fixedQ17_15ToQ1_15(state->accumulator),
		fixedQ1_15ToDouble(fixedQ17_15ToQ1_15(state->accumulator)),
		fixedQ1_15ToDouble(fixedQ17_15ToQ1_15(state->accumulator)),
		fixedQ1_15ToDouble(fixedQ17_15ToQ1_15(state->accumulator)) * M_PI);
	state->flags.printIterations = 0;

	cordicComputeArcCosine(state, argument);
	printf(
		"acos(0x%.4hx -> %g) = %g, "
		"cordicAcos(0x%.4hx) = 0x%.4hx -> %g -> %g * pi -> %g\n",
		argument,
		argumentAsDouble,
		acos(argumentAsDouble),
		argument,
		fixedQ17_15ToQ1_15(state->accumulator),
		fixedQ1_15ToDouble(fixedQ17_15ToQ1_15(state->accumulator)),
		fixedQ1_15ToDouble(fixedQ17_15ToQ1_15(state->accumulator)),
		fixedQ1_15ToDouble(fixedQ17_15ToQ1_15(state->accumulator)) * M_PI);

	argumentAsDouble = 0.5;
	argument = (FixedQ1_15) doubleToFixedQ0_16(0.5);
	cordicComputeSqrt(state, argument);
	printf(
		"sqrt(0x%.4hx -> %g) = %g -> 0x%.4hx, "
		"cordicSqrt(0x%.4hx) = 0x%.4hx -> %g\n",
		argument,
		argumentAsDouble,
		sqrt(argumentAsDouble),
		doubleToFixedQ0_16(sqrt(argumentAsDouble)),
		argument,
		(FixedQ0_16) state->x,
		fixedQ0_16ToDouble((FixedQ0_16) state->x));

	atanDenominatorAsDouble = 0.05;
	atanDenominator = doubleToFixedQ1_15(atanDenominatorAsDouble);
	cordicComputeArcTangentOfRatio(state, argument, atanDenominator);
	printf(
		"atan(0x%.4hx / 0x%.4hx -> %g / %g) = %g, "
		"cordicArcTan(0x%.4hx / 0x%.4hx) = 0x%.4hx -> %g -> %g * pi -> %g\n",
		argument,
		atanDenominator,
		argumentAsDouble,
		atanDenominatorAsDouble,
		atan(argumentAsDouble / atanDenominatorAsDouble),
		argument,
		atanDenominator,
		fixedQ17_15ToQ1_15(state->accumulator),
		fixedQ1_15ToDouble(fixedQ17_15ToQ1_15(state->accumulator)),
		fixedQ1_15ToDouble(fixedQ17_15ToQ1_15(state->accumulator)),
		fixedQ1_15ToDouble(fixedQ17_15ToQ1_15(state->accumulator)) * M_PI);
}

static double fixedQ1_15ToDouble(FixedQ1_15 x)
{
	return x / 32768.0;
}

static FixedQ1_15 fixedQ17_15ToQ1_15(FixedQ17_15 x)
{
	if (x & 0x80000000)
	{
		if ((x & 0xffff8000) != 0xffff8000)
			return (FixedQ1_15) 0x8000;

		return (FixedQ1_15) (0x00008000 | (x & 0x00007fff));
	}

	if (x & 0x7fff8000)
		return 0x7fff;

	return (FixedQ1_15) (x & 0x00007fff);
}

static FixedQ0_16 doubleToFixedQ0_16(double x)
{
	return (FixedQ0_16) ((x * 65536) + 0.5);
}

static double fixedQ0_16ToDouble(FixedQ0_16 x)
{
	return x / 65536.0;
}

static void cordicComputeSineAndCosine(CordicState *state, FixedQ1_15 x)
{
	state->iterationNumber = 0;
	state->argument = x;
	state->flags.computeArc = 0;

	if (isGreaterThan90Degrees(state->argument))
	{
		state->x = 0;
		state->y = state->gainReciprocal;
		state->accumulator = DEGREES_90;
	}
	else if (isLessThanNegative90Degrees(state->argument))
	{
		state->x = 0;
		state->y = -state->gainReciprocal;
		state->accumulator = DEGREES_NEGATIVE90;
	}
	else
	{
		state->x = state->gainReciprocal;
		state->y = 0;
		state->accumulator = DEGREES_0;
	}

	state->error = state->argument - state->accumulator;

	for (int i = 0; i < NUMBER_OF_ITERATIONS; i++)
		cordicIteration(state);
}

static int isGreaterThan90Degrees(FixedQ1_15 value)
{
	return value > DEGREES_90;
}

static int isLessThanNegative90Degrees(FixedQ1_15 value)
{
	return value < DEGREES_NEGATIVE90;
}

static void cordicIteration(CordicState *state)
{
	FixedQ17_15 newX, newY;
	FixedQ17_15 newAccumulator;
	FixedQ17_15 newError;

	if (state->error > 0)
	{
		newX = state->x - (state->y >> state->iterationNumber);
		newY = state->y + (state->x >> state->iterationNumber);
		newAccumulator =
			state->accumulator +
			state->atanLookup[state->iterationNumber];
	}
	else
	{
		newX = state->x + (state->y >> state->iterationNumber);
		newY = state->y - (state->x >> state->iterationNumber);
		newAccumulator =
			state->accumulator -
			state->atanLookup[state->iterationNumber];
	}

	if (state->flags.computeArc)
		newError = state->argument - newY;
	else
		newError = state->argument - newAccumulator;

	if (state->flags.printIterations)
	{
		printf(
			"%d: 0x%.8x + j0x%.8x -> 0x%.8x + j0x%.8x, "
				"phase 0x%.8x -> 0x%.8x, error 0x%.8x -> 0x%.8x\n",
			state->iterationNumber,
			state->x,
			state->y,
			newX,
			newY,
			state->accumulator,
			newAccumulator,
			state->error,
			newError);
	}

	state->x = newX;
	state->y = newY;
	state->accumulator = newAccumulator;
	state->error = newError;
	state->iterationNumber++;
}

static void cordicComputeArcSine(CordicState *state, FixedQ1_15 x)
{
	FixedQ2_30 xSquaredIntermediate = x * x;
	FixedQ0_16 oneTakeXSquared = fixedQ2_30ToQ0_16(
		ONE_Q2_30 - xSquaredIntermediate);

	if (state->flags.printIterations)
	{
		printf(
			"x^2 = 0x%.8x^2 = 0x%.8x, 1-x^2 = 0x%.4hx\n",
			(FixedQ2_30) x,
			xSquaredIntermediate,
			oneTakeXSquared);
	}

	cordicComputeSqrt(state, oneTakeXSquared);

	if (state->flags.printIterations)
	{
		printf(
			"sqrt(0x%.4hx) = 0x%.8x (Q1.15 = 0x%.4hx)\n",
			oneTakeXSquared,
			state->x,
			fixedQ16_16ToQ1_15(state->x));
	}

	cordicComputeArcTangentOfRatio(state, x, fixedQ16_16ToQ1_15(state->x));
}

static FixedQ0_16 fixedQ2_30ToQ0_16(FixedQ2_30 x)
{
	if (x & (1 << 13))
		return (FixedQ0_16) ((x >> 14) + 1);

	return (FixedQ0_16) (x >> 14);
}

static FixedQ1_15 fixedQ16_16ToQ1_15(FixedQ16_16 x)
{
	if (x & 0x80000000)
	{
		if ((x & 0x7fff0000) != 0x7fff0000)
			return (FixedQ1_15) 0x8000;

		return 0x8000 | ((x & 0x0000ffff) >> 1);
	}

	if (x & 0x7fff0000)
		return 0x7fff;

	return (x & 0x0000ffff) >> 1;
}

static void cordicComputeArcCosine(CordicState *state, FixedQ1_15 x)
{
	cordicComputeArcSine(state, x);
	state->accumulator += DEGREES_NEGATIVE90;
	state->accumulator = negateQ17_15(state->accumulator);
}

static FixedQ17_15 negateQ17_15(FixedQ17_15 x)
{
	if (x == 0x80000000)
		return 0x7fffffff;

	return -x;
}

static void cordicComputeSqrt(CordicState *state, FixedQ0_16 x)
{
	FixedQ17_15 onePointFractional;

	state->iterationNumber = 1;
	state->x = ((FixedQ17_15) x) + ONE_QUARTER_Q0_16;
	state->y = ((FixedQ17_15) x) - ONE_QUARTER_Q0_16;

	for (int i = 0; i < NUMBER_OF_ITERATIONS; i++)
		cordicSqrtIteration(state);

	onePointFractional =
		((FixedQ0_16) state->x) *
		state->hyperbolicGainReciprocalFractional;

	state->x += fixedQ1_31ToQ0_16(onePointFractional);
}

static FixedQ0_16 fixedQ1_31ToQ0_16(FixedQ1_31 x)
{
	if (x & 0x80000000)
	{
		if (x & (1 << 14))
			return (FixedQ0_16) (-(x >> 15) + 1);

		return (FixedQ0_16) -(x >> 15);
	}

	return (FixedQ0_16) (x >> 15);
}

static void cordicSqrtIteration(CordicState *state)
{
	FixedQ17_15 newX, newY;

	for (int i = 0; i < 2; i++)
	{
		if (state->y < 0)
		{
			newX = state->x + (state->y >> state->iterationNumber);
			newY = state->y + (state->x >> state->iterationNumber);
		}
		else
		{
			newX = state->x - (state->y >> state->iterationNumber);
			newY = state->y - (state->x >> state->iterationNumber);
		}

		if (state->iterationNumber != 4 && state->iterationNumber != 13)
			break;

		state->x = newX;
		state->y = newY;
	}

	if (state->flags.printIterations)
	{
		printf(
			"%d: 0x%.8x + j0x%.8x -> 0x%.8x + j0x%.8x\n",
			state->iterationNumber,
			state->x,
			state->y,
			newX,
			newY);
	}

	state->x = newX;
	state->y = newY;
	state->iterationNumber++;
}

static void cordicComputeArcTangentOfRatio(
	CordicState *state,
	FixedQ1_15 y,
	FixedQ1_15 x)
{
	state->iterationNumber = 0;
	state->argument = 0;
	state->flags.computeArc = ~0;

	state->x = x;
	state->y = y;
	state->accumulator = DEGREES_0;

	state->error = state->argument - state->y;

	for (int i = 0; i < NUMBER_OF_ITERATIONS; i++)
		cordicIteration(state);

	state->accumulator = negateQ17_15(state->accumulator);
}

static void writeTablesToFiles(CordicState *state)
{
	writeTextTablesToFile(state);
	writeBinarySineTableToFile(state);
	writeBinaryArcSineTableToFile(state);
	writeBinaryCosineTableToFile(state);
	writeBinaryArcCosineTableToFile(state);
}

static void writeTextTablesToFile(CordicState *state)
{
	FILE *fd = fopen("cordic-fixed-tables.txt", "w");
	if (!fd)
	{
		printf("Couldn't open cordic-fixed-tables.txt for writing !\n");
		return;
	}

	fprintf(
		fd,
		"%s\t%s"
			"\t\"\"\t%s\t%s\t%s\t%s"
			"\t\"\"\t%s\t%s\t%s\t%s"
			"\t\"\"\t%s\t%s\t%s\t%s"
			"\t\"\"\t%s\t%s\t%s\t%s"
			"\t\"\"\t%s\t%s\t%s\t%s"
			"\t\"\"\t%s\t%s\t%s\t%s\n",
		"i",
		"x",
		"sin(x)",
		"cordicSin(x)",
		"cordicSinFloat(x)",
		"err_sin(x)",
		"cos(x)",
		"cordicCos(x)",
		"cordicCosFloat(x)",
		"err_cos(x)",
		"asin(x)",
		"cordicArcSin(x)",
		"cordicArcSinFloat(x)",
		"err_asin(x)",
		"acos(x)",
		"cordicArcCos(x)",
		"cordicArcCosFloat(x)",
		"err_acos(x)",
		"atan(x)",
		"cordicArcTan(x)",
		"cordicArcTanFloat(x)",
		"err_atan(x)",
		"sqrt(x)",
		"cordicSqrt(x)",
		"cordicSqrtFloat(x)",
		"err_sqrt(x)");

	state->flags.printIterations = 0;
	for (int i = 0; i < 65536; i++)
	{
		FixedQ1_15 x = (FixedQ1_15) i;

		double builtinSinX, errorSinX;
		FixedQ1_15 sinX;

		double builtinCosX, errorCosX;
		FixedQ1_15 cosX;

		double builtinAsinX, errorAsinX;
		FixedQ1_15 asinX;

		double builtinAcosX, errorAcosX;
		FixedQ1_15 acosX;

		double builtinAtanX, errorAtanX;
		FixedQ1_15 atanX;

		double builtinSqrtX, errorSqrtX;
		FixedQ0_16 sqrtX;

		cordicComputeSineAndCosine(state, x);
		builtinSinX = sin(fixedQ1_15ToDouble(x) * M_PI);
		sinX = fixedQ17_15ToQ1_15(state->y);
		errorSinX = isDoubleNonZero(builtinSinX)
			? (fixedQ1_15ToDouble(sinX) - builtinSinX) / builtinSinX
			: fixedQ1_15ToDouble(sinX) - builtinSinX;

		builtinCosX = cos(fixedQ1_15ToDouble(x) * M_PI);
		cosX = fixedQ17_15ToQ1_15(state->x);
		errorCosX = isDoubleNonZero(builtinCosX)
			? (fixedQ1_15ToDouble(cosX) - builtinCosX) / builtinCosX
			: fixedQ1_15ToDouble(cosX) - builtinCosX;

		cordicComputeArcSine(state, x);
		asinX = fixedQ17_15ToQ1_15(state->accumulator);
		builtinAsinX = asin(fixedQ1_15ToDouble(x)) / M_PI;
		errorAsinX = isDoubleNonZero(builtinAsinX)
			? (fixedQ1_15ToDouble(asinX) - builtinAsinX) / builtinAsinX
			: fixedQ1_15ToDouble(asinX) - builtinAsinX;

		cordicComputeArcCosine(state, x);
		acosX = fixedQ17_15ToQ1_15(state->accumulator);
		builtinAcosX = acos(fixedQ1_15ToDouble(x)) / M_PI;
		errorAcosX = isDoubleNonZero(builtinAcosX)
			? (fixedQ1_15ToDouble(acosX) - builtinAcosX) / builtinAcosX
			: fixedQ1_15ToDouble(acosX) - builtinAcosX;

		cordicComputeArcTangentOfRatio(state, x, ALMOST_ONE_Q1_15);
		atanX = fixedQ17_15ToQ1_15(state->accumulator);
		builtinAtanX = atan(
			fixedQ1_15ToDouble(x) /
			fixedQ1_15ToDouble(ALMOST_ONE_Q1_15)) / M_PI;

		errorAtanX = isDoubleNonZero(builtinAtanX)
			? (fixedQ1_15ToDouble(atanX) - builtinAtanX) / builtinAtanX
			: fixedQ1_15ToDouble(atanX) - builtinAtanX;

		cordicComputeSqrt(state, i);
		sqrtX = (FixedQ0_16) state->x;
		builtinSqrtX = sqrt(i / 65536.0);
		errorSqrtX = isDoubleNonZero(builtinSqrtX)
			? (fixedQ0_16ToDouble(sqrtX) - builtinSqrtX) / builtinSqrtX
			: fixedQ0_16ToDouble(sqrtX) - builtinSqrtX;

		fprintf(
			fd,
			"0x%.4x\t%e"
				"\t\"\"\t%e\t0x%.4hx\t%e\t%e"
				"\t\"\"\t%e\t0x%.4hx\t%e\t%e"
				"\t\"\"\t%e\t0x%.4hx\t%e\t%e"
				"\t\"\"\t%e\t0x%.4hx\t%e\t%e"
				"\t\"\"\t%e\t0x%.4hx\t%e\t%e"
				"\t\"\"\t%e\t0x%.4hx\t%e\t%e\n",
			i,
			x / 32768.0,
			builtinSinX,
			sinX,
			fixedQ1_15ToDouble(sinX),
			errorSinX,
			builtinCosX,
			cosX,
			fixedQ1_15ToDouble(cosX),
			errorCosX,
			builtinAsinX,
			asinX,
			fixedQ1_15ToDouble(asinX),
			errorAsinX,
			builtinAcosX,
			acosX,
			fixedQ1_15ToDouble(acosX),
			errorAcosX,
			builtinAtanX,
			atanX,
			fixedQ1_15ToDouble(atanX),
			errorAtanX,
			builtinSqrtX,
			sqrtX,
			fixedQ0_16ToDouble(sqrtX),
			errorSqrtX);
	}

	fclose(fd);
}

static int isDoubleNonZero(double x)
{
	return fabs(x) < 10e-12;
}

static void writeBinarySineTableToFile(CordicState *state)
{
	FILE *fd = fopen("cordic-fixed-sine-table.bin", "wb");
	if (!fd)
	{
		printf("Couldn't open cordic-fixed-sine-table.bin for writing !\n");
		return;
	}

	for (int i = 0; i < 65536; i++)
	{
		FixedQ1_15 sinX;
		unsigned char asBytes[2];
		cordicComputeSineAndCosine(state, (unsigned short) i);
		sinX = fixedQ17_15ToQ1_15(state->y);
		asBytes[0] = (unsigned char) ((sinX >> 8) & 0xff);
		asBytes[1] = (unsigned char) ((sinX >> 0) & 0xff);
		fwrite(asBytes, sizeof(char), 2, fd);
	}

	fclose(fd);
}

static void writeBinaryArcSineTableToFile(CordicState *state)
{
	FILE *fd = fopen("cordic-fixed-arcsine-table.bin", "wb");
	if (!fd)
	{
		printf("Couldn't open cordic-fixed-arcsine-table.bin for writing !\n");
		return;
	}

	for (int i = 0; i < 65536; i++)
	{
		FixedQ1_15 asinX;
		unsigned char asBytes[2];
		cordicComputeArcSine(state, (unsigned short) i);
		asinX = fixedQ17_15ToQ1_15(state->accumulator);
		asBytes[0] = (unsigned char) ((asinX >> 8) & 0xff);
		asBytes[1] = (unsigned char) ((asinX >> 0) & 0xff);
		fwrite(asBytes, sizeof(char), 2, fd);
	}

	fclose(fd);
}

static void writeBinaryCosineTableToFile(CordicState *state)
{
	FILE *fd = fopen("cordic-fixed-cosine-table.bin", "wb");
	if (!fd)
	{
		printf("Couldn't open cordic-fixed-cosine-table.bin for writing !\n");
		return;
	}

	for (int i = 0; i < 65536; i++)
	{
		FixedQ1_15 cosX;
		unsigned char asBytes[2];
		cordicComputeSineAndCosine(state, (unsigned short) i);
		cosX = fixedQ17_15ToQ1_15(state->x);
		asBytes[0] = (unsigned char) ((cosX >> 8) & 0xff);
		asBytes[1] = (unsigned char) ((cosX >> 0) & 0xff);
		fwrite(asBytes, sizeof(char), 2, fd);
	}

	fclose(fd);
}

static void writeBinaryArcCosineTableToFile(CordicState *state)
{
	FILE *fd = fopen("cordic-fixed-arccosine-table.bin", "wb");
	if (!fd)
	{
		printf("Couldn't open cordic-fixed-arccosine-table.bin for writing !\n");
		return;
	}

	for (int i = 0; i < 65536; i++)
	{
		FixedQ1_15 acosX;
		unsigned char asBytes[2];
		cordicComputeArcCosine(state, (unsigned short) i);
		acosX = fixedQ17_15ToQ1_15(state->accumulator);
		asBytes[0] = (unsigned char) ((acosX >> 8) & 0xff);
		asBytes[1] = (unsigned char) ((acosX >> 0) & 0xff);
		fwrite(asBytes, sizeof(char), 2, fd);
	}

	fclose(fd);
}
