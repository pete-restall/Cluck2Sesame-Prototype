#include <stdio.h>
#include <math.h>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

static double triangle(unsigned short x);
static double smoothstep(double x);
static double scale(double y);

int main(int argc, char *argv[])
{
	printf("x\tcos(x)\tsmoothstepCos(x)\terror\n");
	for (int i = 0; i < 65536; i++)
	{
		unsigned short x = (unsigned short) i;
		double smoothstepCos = scale(smoothstep(triangle(x)));
		double builtinCos = cos(2 * M_PI * x / 65536.0);
		printf(
			"0x%.4hx\t%e\t%e\t%e\n",
			x,
			builtinCos,
			smoothstepCos,
			builtinCos != 0
				? (smoothstepCos - builtinCos) / builtinCos
				: smoothstepCos - builtinCos);
	}

	return 0;
}

static double triangle(unsigned short x)
{
	const unsigned short quadrant1And2 = 0xffff / 2;
	const double slope = 1.0 / quadrant1And2;

	return (x < quadrant1And2)
		? 1 - x * slope
		: (x - quadrant1And2) * slope;
}

static double smoothstep(double x)
{
	/* f(x) = 3x^2 - 2x^3 = x^2(3 - 2x) */

	return (x * x) * (3 - 2 * x);
}

static double scale(double y)
{
	return 2 * (y - 0.5);
}
