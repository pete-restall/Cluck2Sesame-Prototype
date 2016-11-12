#include <stdio.h>
#include <string.h>

#define ERR_UNKNOWN_LINE_TYPE 0x10
#define ERR_BACKWARDS_TIMESTAMP 0x11

typedef struct
{
	unsigned int address;
	unsigned int bitmask;
	int result;
	int hadFirstTimestamp;
	unsigned long long timestamp;
	char value;
	FILE *fdOut;
} TranslationState;

static int parseArgs(TranslationState *state, int argc, char *argv[]);
static void translate(TranslationState *state, FILE *fdIn, FILE *fdOut);
static void translateLine(TranslationState *state, const char *line);
static void translateTimestampLine(TranslationState *state, const char *line);
static void translateReadOrWriteLine(TranslationState *state, const char *line);

int main(int argc, char *argv[])
{
	TranslationState state;
	memset(&state, 0, sizeof(TranslationState));
	state.value = '0';

	if (!parseArgs(&state, argc, argv))
	{
		printf("Usage: %s <address_hex> <bit_number>\n", argv[0]);
		return 1;
	}

	translate(&state, stdin, stdout);
	return state.result;
}

static int parseArgs(TranslationState *state, int argc, char *argv[])
{
	unsigned int bitNumber;

	if (argc != 3)
		return 0;

	if (sscanf(argv[1], "%i", &state->address) != 1)
		return 0;

	if (sscanf(argv[2], "%u", &bitNumber) != 1)
		return 0;

	if (bitNumber > 7)
		return 0;

	state->bitmask = (1 << bitNumber);

	return 1;
}

static void translate(TranslationState *state, FILE *fdIn, FILE *fdOut)
{
	char line[256];

	state->fdOut = fdOut;
	while (fgets(line, sizeof(line) - 1, fdIn) > 0)
	{
		translateLine(state, line);
		if (state->result != 0)
			return;
	}
}

static void translateLine(TranslationState *state, const char *line)
{
	if (line[0] == '0')
		translateTimestampLine(state, line);
	else if (line[0] == ' ')
		translateReadOrWriteLine(state, line);
	else
		state->result = ERR_UNKNOWN_LINE_TYPE;
}

static void translateTimestampLine(TranslationState *state, const char *line)
{
	unsigned long long i;
	unsigned long long timestamp;

	sscanf(line, "%Li", &timestamp);
	if (timestamp < state->timestamp)
	{
		state->result = ERR_BACKWARDS_TIMESTAMP;
		return;
	}

	if (state->hadFirstTimestamp)
	{
		for (i = state->timestamp + 1; i < timestamp; i++)
			printf("0x%.16Lx %c\n", i, state->value);
	}
	else
		state->hadFirstTimestamp = 1;

	state->timestamp = timestamp;
}

static void translateReadOrWriteLine(TranslationState *state, const char *line)
{
	char value[8];
	char junk[128];
	unsigned int address;
	unsigned int valueAsInt;

	if (sscanf(line, "  Wrote: 0x%4s to %127[^(](%x)", value, junk, &address) != 3)
		return;

	if (address != state->address)
		return;

	value[0] = value[0] == '?' ? '0' : value[0];
	value[1] = value[1] == '?' ? '0' : value[1];
	value[2] = value[2] == '?' ? '0' : value[2];
	value[3] = value[3] == '?' ? '0' : value[3];
	sscanf(value, "%x", &valueAsInt);
	state->value = (valueAsInt & state->bitmask) ? '1' : '0';
	fprintf(state->fdOut, "0x%.16Lx %c\n", state->timestamp, state->value);
}
