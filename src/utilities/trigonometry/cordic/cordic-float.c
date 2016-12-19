/*
       Angles                 Vectors

        0.5                    0 + jy
         |                       |
    1 ---+--- 0       -x + j0 ---+--- x + j0
         |                       |
       -0.5                    0 - jy

    Angles are represented as -1 <= phi < 1 so they fit easily into Q1.15
    fixed-point, rather than using radians or degrees.  So:

        phi > 0.5 means phi > 90 degrees
        phi < -0.5 means phi < -90 degrees
*/

#include <stdio.h>
#include <string.h>
#include <math.h>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

#define NUMBER_OF_ITERATIONS 24

#define DEGREES_0 0
#define DEGREES_90 0.5
#define DEGREES_NEGATIVE90 -0.5

typedef struct
{
	struct
	{
		int printIterations : 1;
		int computeArc : 1;
	} flags;

	double atanLookup[NUMBER_OF_ITERATIONS];
	double gain;
	double gainReciprocal;

	int iterationNumber;
	double argument;
	double x;
	double y;
	double accumulator;
	double error;
} CordicState;

static void cordicInitialise(CordicState *state);
static void printSelectedFunctions(CordicState *state);
static void cordicComputeSineAndCosine(CordicState *state, double x);
static int isGreaterThan90Degrees(double value);
static int isLessThanNegative90Degrees(double value);
static void cordicIteration(CordicState *state);
static void cordicComputeArcSine(CordicState *state, double x);
static void cordicComputeArcInitialisation(CordicState *state, double x);
static void cordicComputeArcCosine(CordicState *state, double x);
static void writeTablesToFiles(CordicState *state);

int main(int argc, char *argv[])
{
	CordicState state;
	cordicInitialise(&state);

	printSelectedFunctions(&state);
	writeTablesToFiles(&state);
	return 0;
}

static void printSelectedFunctions(CordicState *state)
{
	double argument = 0;

	cordicComputeSineAndCosine(state, argument);

	printf("sin(pi * %g) = %g, cordicSin(%g) = %g\n",
		argument,
		sin(argument * M_PI),
		argument,
		state->y);

	printf("cos(pi * %g) = %g, cordicCos(%g) = %g\n",
		argument,
		cos(argument * M_PI),
		argument,
		state->x);

	argument = 0.3;
	cordicComputeArcSine(state, argument);
	printf("asin(%g) = %g, cordicAsin(%g) = %g * pi -> %g\n",
		argument,
		asin(argument),
		argument,
		state->accumulator,
		state->accumulator * M_PI);

	cordicComputeArcCosine(state, argument);
	printf("acos(%g) = %g, cordicAcos(%g) = %g * pi -> %g\n",
		argument,
		acos(argument),
		argument,
		state->accumulator,
		state->accumulator * M_PI);
}

static void cordicInitialise(CordicState *state)
{
	int i;

	memset(state, 0, sizeof(CordicState));
	state->gain = 1;
	for (i = 0; i < NUMBER_OF_ITERATIONS; i++)
	{
		double power2 = pow(2, -i);
		double twoPower2 = pow(2, -2 * i);
		double atanPower2 = atan(power2);
		state->atanLookup[i] = atanPower2 / M_PI;
		state->gain *= sqrt(1 + twoPower2);
		state->gainReciprocal = 1 / state->gain;
		printf(
			"atan(2^-%d) = %g deg (%g unit), gain = %g, gain^-1 = %g\n",
			i,
			atanPower2 * 180 / M_PI,
			atanPower2 / M_PI,
			state->gain,
			state->gainReciprocal);
	}
}

static void cordicComputeSineAndCosine(CordicState *state, double x)
{
	int i;

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

	for (i = 0; i < NUMBER_OF_ITERATIONS; i++)
		cordicIteration(state);
}

static int isGreaterThan90Degrees(double value)
{
	return value > DEGREES_90;
}

static int isLessThanNegative90Degrees(double value)
{
	return value < DEGREES_NEGATIVE90;
}

static void cordicIteration(CordicState *state)
{
	double newI, newQ;
	double newAccumulator;
	double newError;

	if (state->error > 0)
	{
		newI = state->x - (state->y / pow(2, state->iterationNumber));
		newQ = state->y + (state->x / pow(2, state->iterationNumber));
		newAccumulator = state->accumulator + state->atanLookup[state->iterationNumber];
	}
	else
	{
		newI = state->x + (state->y / pow(2, state->iterationNumber));
		newQ = state->y - (state->x / pow(2, state->iterationNumber));
		newAccumulator = state->accumulator - state->atanLookup[state->iterationNumber];
	}

	if (state->flags.computeArc)
		newError = state->argument - newQ;
	else
		newError = state->argument - newAccumulator;

	if (state->flags.printIterations)
	{
		printf(
			"%d: %g%s%g -> %g%s%g, phase %g -> %g, error %g -> %g\n",
			state->iterationNumber,
			state->x,
			state->y >= 0 ? " + j" : " - j",
			state->y >= 0 ? state->y : -state->y,
			newI,
			newQ >= 0 ? " + j" : " - j",
			newQ >= 0 ? newQ : -newQ,
			state->accumulator,
			newAccumulator,
			state->error,
			newError);
	}

	state->x = newI;
	state->y = newQ;
	state->accumulator = newAccumulator;
	state->error = newError;
	state->iterationNumber++;
}

static void cordicComputeArcSine(CordicState *state, double x)
{
	int i;

	cordicComputeArcInitialisation(state, x);
	for (i = 0; i < NUMBER_OF_ITERATIONS; i++)
		cordicIteration(state);
}

static void cordicComputeArcInitialisation(CordicState *state, double x)
{
	state->iterationNumber = 0;
	state->argument = x;
	state->flags.computeArc = ~0;

	state->x = state->gainReciprocal;
	state->y = 0;
	state->accumulator = DEGREES_0;

	state->error = state->argument - state->y;
}

static void cordicComputeArcCosine(CordicState *state, double x)
{
	int i;

	cordicComputeArcInitialisation(state, x);
	state->accumulator = DEGREES_NEGATIVE90;

	for (i = 0; i < NUMBER_OF_ITERATIONS; i++)
		cordicIteration(state);

	state->accumulator *= -1;
}

static void writeTablesToFiles(CordicState *state)
{
	FILE *fd;
	int i;

	fd = fopen("cordic-float-tables.txt", "w");
	if (!fd)
	{
		printf("Couldn't open cordic-float-tables.txt for writing !\n");
		return;
	}

	fprintf(
		fd,
		"%s\t%s\t\"\"\t%s\t%s\t%s\t\"\"\t%s\t%s\t%s\t\"\"\t%s\t%s\t%s\t\"\"\t%s\t%s\t%s\n",
		"i",
		"x",
		"sin(x)",
		"cordicSin(x)",
		"err_sin(x)",
		"cos(x)",
		"cordicCos(x)",
		"err_cos(x)",
		"asin(x)",
		"cordicArcSin(x)",
		"err_asin(x)",
		"acos(x)",
		"cordicArcCos(x)",
		"err_acos(x)");

	state->flags.printIterations = 0;
	for (i = 0; i < 65536; i++)
	{
		double x = ((short) i) / 32768.0;
		double builtinSinX, sinX, errorSinX;
		double builtinCosX, cosX, errorCosX;
		double builtinAsinX, asinX, errorAsinX;
		double builtinAcosX, acosX, errorAcosX;

		cordicComputeSineAndCosine(state, x);
		builtinSinX = sin(x * M_PI);
		sinX = state->y;
		errorSinX = builtinSinX != 0
			? (sinX - builtinSinX) / builtinSinX
			: sinX - builtinSinX;

		builtinCosX = cos(x * M_PI);
		cosX = state->x;
		errorCosX = builtinCosX != 0
			? (cosX - builtinCosX) / builtinCosX
			: cosX - builtinCosX;

		cordicComputeArcSine(state, x);
		asinX = state->accumulator * M_PI;
		builtinAsinX = asin(x);
		errorAsinX = builtinAsinX != 0
			? (asinX - builtinAsinX) / builtinAsinX
			: asinX - builtinAsinX;

		cordicComputeArcCosine(state, x);
		acosX = state->accumulator * M_PI;
		builtinAcosX = acos(x);
		errorAcosX = builtinAcosX != 0
			? (acosX - builtinAcosX) / builtinAcosX
			: asinX - builtinAsinX;

		fprintf(
			fd,
			"0x%.4x\t%e\t\"\"\t%e\t%e\t%e\t\"\"\t%e\t%e\t%e\t\"\"\t%e\t%e\t%e\t\"\"\t%e\t%e\t%e\n",
			i,
			x,
			builtinSinX,
			sinX,
			errorSinX,
			builtinCosX,
			cosX,
			errorCosX,
			builtinAsinX,
			asinX,
			errorAsinX,
			builtinAcosX,
			acosX,
			errorAcosX);
	}

	fclose(fd);
}
