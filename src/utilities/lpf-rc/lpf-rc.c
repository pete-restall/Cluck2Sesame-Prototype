#include <stdio.h>
#include <string.h>
#include <math.h>

#define ERR_INVALID_TUPLE 0x10

typedef struct
{
	double timestampInterval;
	double resistanceInOhms;
	double capacitanceInFarads;

	int result;

	double exponentIncrementPerTimeInterval;
	double exponent;
	double voltage;

	int wasCharging;
	double chargingFromVoltage;

	int wasDischarging;
	double dischargingFromVoltage;
} FilterState;

static int parseArgs(FilterState *state, int argc, char *argv[]);
static void filter(FilterState *state, FILE *fdIn, FILE *fdOut);
static void discharging(FilterState *state);
static void charging(FilterState *state);

int main(int argc, char *argv[])
{
	FilterState state;

	memset(&state, 0, sizeof(FilterState));
	state.wasDischarging = 1;

	if (!parseArgs(&state, argc, argv))
	{
		printf("Usage: %s <sps_hz> <r_ohms> <c_farads>\n", argv[0]);
		return 1;
	}

	filter(&state, stdin, stdout);
	return state.result;
}

static int parseArgs(FilterState *state, int argc, char *argv[])
{
	unsigned long samplesPerSecondInHz;

	if (argc != 4)
		return 0;

	if (sscanf(argv[1], "%lu", &samplesPerSecondInHz) != 1)
		return 0;

	if (samplesPerSecondInHz <= 0)
		return 0;

	state->timestampInterval = 1.0 / samplesPerSecondInHz;

	if (sscanf(argv[2], "%lg", &state->resistanceInOhms) != 1)
		return 0;

	if (state->resistanceInOhms <= 0)
		return 0;

	if (sscanf(argv[3], "%lg", &state->capacitanceInFarads) != 1)
		return 0;

	if (state->capacitanceInFarads <= 0)
		return 0;

	state->exponentIncrementPerTimeInterval =
		-state->timestampInterval /
		(state->resistanceInOhms * state->capacitanceInFarads);

	return 1;
}

static void filter(FilterState *state, FILE *fdIn, FILE *fdOut)
{
	unsigned long long timestamp;
	char value;
	char line[256];

	while (fgets(line, sizeof(line) - 1, fdIn) > 0)
	{
		if (sscanf(line, "%Li %c", &timestamp, &value) != 2)
		{
			state->result = ERR_INVALID_TUPLE;
			return;
		}

		state->exponent += state->exponentIncrementPerTimeInterval;
		if (value == '0')
			discharging(state);
		else
			charging(state);

		fprintf(fdOut, "0x%.16Lx %g\n", timestamp, state->voltage);
	}
}

static void discharging(FilterState *state)
{
	if (state->wasCharging)
	{
		state->wasCharging = 0;
		state->wasDischarging = 1;
		state->dischargingFromVoltage = state->voltage;
		state->exponent = 0;
	}

	state->voltage =
		state->dischargingFromVoltage * pow(M_E, state->exponent);
}

static void charging(FilterState *state)
{
	if (state->wasDischarging)
	{
		state->wasCharging = 1;
		state->wasDischarging = 0;
		state->chargingFromVoltage = state->voltage;
		state->exponent = 0;
	}

	state->voltage =
		state->chargingFromVoltage +
		(1 - state->chargingFromVoltage) *
		(1 - pow(M_E, state->exponent));
}
