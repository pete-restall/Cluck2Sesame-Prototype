% Sunrise and Sunset Coefficients for the Northern Reference

latitudeDifference = 5;
data = load("-ascii", "sunrise-sunset-reference.txt")(1:366,:);
day = data(:,1);
fittedSunriseReference = data(:,4);
fittedSunsetReference = data(:,5);
sunriseReference = data(:,6);
sunsetReference = data(:,7);
sunriseDifference = (sunriseReference - fittedSunriseReference) / latitudeDifference;
sunsetDifference = (sunsetReference - fittedSunsetReference) / latitudeDifference;

sunriseInitialParameters = [
	-0.0147342;
	-0.0063507; -0.3137602; -0.0036462;
	0.0054165; -0.6852013; 0.9275788;
	0.0094188; -0.7197909; -0.0034750;
	0.4; 0.4; 0.4];

sunriseFittingOptions.bounds = repmat(
	[-Inf, +Inf],
	size(sunriseInitialParameters));

[fittedSunriseDifference, sunriseCoefficients] = leasqr(
	day,
	sunriseDifference,
	sunriseInitialParameters,
	@approximation,
	0.0001,
	20,
	ones(size(sunriseDifference)),
	0.001 * ones(size(sunriseInitialParameters)),
	@dfdp,
	sunriseFittingOptions);

sunriseCoefficients

plot(day, sunriseDifference, "-b;Actual;", day, fittedSunriseDifference, "-r;Fitted;");
title("Fitting Attempt - Sunrise Difference (North)");
figure;

plot(day, sunriseReference, "-b;Actual;", day, fittedSunriseReference + fittedSunriseDifference * latitudeDifference, "-r;Fitted;");
title("Fitting Attempt - Sunrise (North)");
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

[fittedSunsetDifference, sunsetCoefficients] = leasqr(
	day,
	sunsetDifference,
	sunsetInitialParameters,
	@approximation,
	0.0001,
	20,
	ones(size(sunsetDifference)),
	0.001 * ones(size(sunsetInitialParameters)),
	@dfdp,
	sunsetFittingOptions);

sunsetCoefficients

plot(day, sunsetDifference, "-b;Actual;", day, fittedSunsetDifference, "-r;Fitted;");
title("Fitting Attempt - Sunset Difference (North)");
figure;

plot(day, sunsetReference, "-b;Actual;", day, fittedSunsetReference + fittedSunsetDifference * latitudeDifference, "-r;Fitted;");
title("Fitting Attempt - Sunset (North)");
figure;

pause;
