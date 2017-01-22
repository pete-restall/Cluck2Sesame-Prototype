data = load("-ascii", "sunrise-sunset.txt")(1:366,:);
x = data(:,1);
y = data(:,2);

sunriseA = data(:,2);
sunsetA = data(:,3);
sunriseB = data(:,4);
sunsetB = data(:,5);
sunriseC = data(:,6);
sunsetC = data(:,7);
sunriseD = data(:,8);
sunsetD = data(:,9);

epsilon = 1 / 32768;
lowerBound = -1;
upperBound = 1 - epsilon;

function Y = approximation(x, p)
	Y = approximationTerm(x, p(1:4)) + approximationTerm(x, p([5,6,7,4])) + approximationTerm(x, p([8,9,10,4]));
endfunction

function Y = approximationTerm(x, p)
	Y = p(1) * sin(p(2) + p(3) * (x / size(x)(1) * 2 * pi)) + p(4);
endfunction

initialParameters = 0.5 * ones(10, 1);
fittingOptions.bounds = repmat(
	%[lowerBound, upperBound],
	[-inf, +inf],
	size(initialParameters));

[fittedY, coefficients] = leasqr(
	x,
	y,
	initialParameters,
	@approximation,
	0.0001,
	200,
	ones(size(y)),
	0.001 * ones(size(initialParameters)),
	@dfdp,
	fittingOptions);

handRolled = 0.15 * ones(size(x)); % 0.09 * sin(1.5 + 4 * x / size(x)(1) * 2 * pi) + 0.25;
plot(x, y, "-b;Actual;", x, fittedY, "-r;Fitted;", x, handRolled, "-g;Hand Rolled;");
title("Fitting Attempt");
figure;
coefficients

plot(x, sunriseA, "-b;A;", x, sunriseB, "-r;B;", x, sunriseC, "-g;C;", x, sunriseD, "-k;D;");
title("Four Corners of the UK - Sunrise");
figure;
pause;
