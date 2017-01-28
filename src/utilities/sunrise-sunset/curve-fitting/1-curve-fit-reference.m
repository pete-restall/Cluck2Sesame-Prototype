% Sunrise and Sunset Coefficients for the Central Reference

data = load("-ascii", "sunrise-sunset-reference.txt")(1:366,:);
day = data(:,1);
sunriseReference = data(:,2);
sunsetReference = data(:,3);

sunriseInitialParameters = [
	0.436866;
	0.214981; 0.649690; -0.012062;
	0.010211; 0.028479; 1.777003;
	0.112530; 0.341738; 0.843106;
	0.4; 0.4; 0.4];

sunriseFittingOptions.bounds = repmat(
	[-Inf, +Inf],
	size(sunriseInitialParameters));

[fittedSunriseReference, sunriseCoefficients] = leasqr(
	day,
	sunriseReference,
	sunriseInitialParameters,
	@approximation,
	0.0001,
	20,
	ones(size(sunriseReference)),
	0.001 * ones(size(sunriseInitialParameters)),
	@dfdp,
	sunriseFittingOptions);

sunriseCoefficients

plot(day, sunriseReference, "-b;Actual;", day, fittedSunriseReference, "-r;Fitted;");
title("Fitting Attempt - Sunrise Reference");
figure;

sunsetInitialParameters = [
	0.734751;
	0.108605; 0.921565; 0.878228;
	0.013156; 0.287968; 1.729057;
	0.049902; 0.700207; 0.764309;
	0.9; 0.9; 0.9];

sunsetFittingOptions.bounds = repmat(
	[-Inf, +Inf],
	size(sunsetInitialParameters));

[fittedSunsetReference, sunsetCoefficients] = leasqr(
	day,
	sunsetReference,
	sunsetInitialParameters,
	@approximation,
	0.0001,
	20,
	ones(size(sunsetReference)),
	0.001 * ones(size(sunsetInitialParameters)),
	@dfdp,
	sunsetFittingOptions);

sunsetCoefficients

plot(day, sunsetReference, "-b;Actual;", day, fittedSunsetReference, "-r;Fitted;");
title("Fitting Attempt - Sunset Reference");
figure;

pause;
