#include <stdio.h>
#include <string.h>

#define ERR_INVALID_TUPLE 0x10

typedef struct
{
	unsigned long long startTimestamp;
	unsigned long long endTimestamp;
	int result;
	unsigned long long count;
	double sum;
} MeanState;

static int parseArgs(MeanState *state, int argc, char *argv[]);
static void mean(MeanState *state, FILE *fdIn, FILE *fdOut);

int main(int argc, char *argv[])
{
	MeanState state;
	memset(&state, 0, sizeof(MeanState));

	if (!parseArgs(&state, argc, argv))
	{
		printf("Usage: %s <start_timestamp> <count | 'all'>\n", argv[0]);
		return 1;
	}

	mean(&state, stdin, stdout);
	return state.result;
}

static int parseArgs(MeanState *state, int argc, char *argv[])
{
	if (argc != 3)
		return 0;

	if (sscanf(argv[1], "%Li", &state->startTimestamp) != 1)
		return 0;

	if (strcmp(argv[2], "all") != 0)
	{
		unsigned long long numberOfTimestamps;
		if (sscanf(argv[2], "%Li", &numberOfTimestamps) != 1)
			return 0;

		if (numberOfTimestamps <= 0)
			return 0;

		state->endTimestamp = state->startTimestamp + numberOfTimestamps;
	}
	else
		state->endTimestamp = ~0;

	return 1;
}

static void mean(MeanState *state, FILE *fdIn, FILE *fdOut)
{
	unsigned long long timestamp;
	double value;
	char line[256];

	while (fgets(line, sizeof(line) - 1, fdIn) > 0)
	{
		if (sscanf(line, "%Li %lg", &timestamp, &value) != 2)
		{
			state->result = ERR_INVALID_TUPLE;
			return;
		}

		if (timestamp >= state->startTimestamp && timestamp < state->endTimestamp)
		{
			state->sum += value;
			state->count++;
		}
	}

	if (state->count != 0)
		fprintf(fdOut, "%g\n", state->sum / state->count);
	else
		fprintf(fdOut, "0\n");
}
