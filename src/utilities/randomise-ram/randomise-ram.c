#include <stdio.h>
#include <stdlib.h>
#include <time.h>

static void randomiseRange(FILE *fd, int start, int length);

int main(int argc, char *argv[])
{
	FILE *fd;

	if (argc != 2)
	{
		printf("Usage: %s <filename.sti>\n", argv[0]);
		return 1;
	}

	fd = fopen(argv[1], "wt");
	if (!fd)
	{
		printf("Failed to open %s for writing !\n", argv[1]);
		return 1;
	}

	srand((int) time(NULL));
	randomiseRange(fd, 0x020, 96);
	randomiseRange(fd, 0x0a0, 80);
	randomiseRange(fd, 0x120, 80);
	fclose(fd);

	return 0;
}

static void randomiseRange(FILE *fd, int start, int length)
{
	for (int i = start; i < start + length; i++)
		fprintf(fd, "p16f685.ramData[0x%.3x] = 0x%.2x\n", i, rand() & 0xff);
}
