fd = fopen("../../trigonometry/cordic/cordic-fixed-sine-table.bin", "rb", "b");
global cordicSin = fread(fd, [1,65536], "int16");
fclose(fd);

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
sunriseReference = data(:,10);
sunsetReference = data(:,11);
sunriseReferenceA = data(:,12);
sunsetReferenceA = data(:,13);
sunriseReferenceB = data(:,14);
sunsetReferenceB = data(:,15);

lowerBound = -1;
upperBound = 1 - (1 / 65536);

function y = sinLookup(phi)
	global cordicSin;
	y = sin(phi * 2 * pi);
endfunction

function Y = approximation(x, p)
	phi = x / 366;
	cordicAngleA = p(3) + p(4) * phi;
	cordicAngleB = p(6) + p(7) * phi;
	cordicAngleC = p(9) + p(10) * phi;
	cordicAngleD = p(12) + p(13) * phi;
	a = p(2) * arrayfun(@sinLookup, cordicAngleA);
	b = p(5) * arrayfun(@sinLookup, cordicAngleB);
	c = p(8) * arrayfun(@sinLookup, cordicAngleC);
	d = p(11) * arrayfun(@sinLookup, cordicAngleD);
	Y = (p(1) + a + b + c + 0);
endfunction

initialParameters = [
	0.436866;
	0.214981; 0.649690; -0.012062;
	0.010211; 0.028479; 1.777003;
	0.112530; 0.341738; 0.843106;
	0.4; 0.4; 0.4];

fittingOptions.bounds = repmat(
	[-Inf, +Inf],
	size(initialParameters));

[fittedSunriseReference, coefficients] = leasqr(
	x,
	sunriseReference,
	initialParameters,
	@approximation,
	0.0001,
	20,
	ones(size(y)),
	0.001 * ones(size(initialParameters)),
	@dfdp,
	fittingOptions);

plot(x, sunriseReference, "-b;Actual;", x, fittedSunriseReference, "-r;Fitted;");
title("Fitting Attempt - Sunrise Reference");
figure;
coefficients

pause;
quit;

plot(x, sunriseA, "-b;A;", x, sunriseB, "-r;B;", x, sunriseC, "-g;C;", x, sunriseD, "-k;D;");
title("Four Corners of the UK - Sunrise");
figure;

[fittedReference, referenceCoefficients] = leasqr(
	x,
	sunriseReference,
	initialParameters,
	@approximation,
	0.0001,
	200,
	ones(size(y)),
	0.001 * ones(size(initialParameters)),
	@dfdp,
	fittingOptions);

referenceCoefficients

plot(x, sunriseReference, "-r;Reference;", x, sunriseReferenceA, "-g;A;", x, sunriseReferenceB, "-m;B;", x, fittedReference, "-k;Fitted Reference;");
title("Latitude Changes in Reference - Sunrise");
figure;

sunriseReference = fittedReference;

sunriseDifferenceA = sunriseReferenceA - sunriseReference;
sunriseDifferenceB = sunriseReference - sunriseReferenceB;
plot(x, sunriseDifferenceA, "-r;A - R;", x, sunriseDifferenceB, "-g;B - R;");
title("Differences between Latitude Changes - Sunrise");
figure;

[fittedA, coefficientsA] = leasqr(
	x,
	sunriseDifferenceA / (60 - 55),
	initialParameters,
	@approximation,
	0.0001,
	200,
	ones(size(y)),
	0.001 * ones(size(initialParameters)),
	@dfdp,
	fittingOptions);

coefficientsA

[fittedB, coefficientsB] = leasqr(
	x,
	sunriseDifferenceB / (60 - 55),
	initialParameters,
	@approximation,
	0.0001,
	200,
	ones(size(y)),
	0.001 * ones(size(initialParameters)),
	@dfdp,
	fittingOptions);

coefficientsB

sunriseEstimateA = sunriseReference + sunriseDifferenceA;
sunriseFittedEstimate = sunriseReference + fittedA * 5;
plot(x, sunriseReferenceA, "-r;Actual;", x, sunriseEstimateA, "-g;Estimated A;", x, sunriseFittedEstimate, "-m;Fitted Estimate;");
title("Estimate for A - Sunrise");
figure;

sunriseEstimateB = sunriseReference - sunriseDifferenceB;
sunriseFittedEstimate = sunriseReference + fittedB * -5;
plot(x, sunriseReferenceB, "-r;Actual;", x, sunriseEstimateB, "-g;Estimated B;", x, sunriseFittedEstimate, "-m;Fitted Estimate;");
title("Estimate for B - Sunrise");
figure;

pause;
