data = load("-ascii", "lookup.txt");
day = data(:,1);
referenceSunrise = data(:,2);
lookupSunrise = data(:,3);
referenceSunriseNorth = data(:,4);
lookupSunriseNorth = data(:,5);
referenceSunriseSouth = data(:,6);
lookupSunriseSouth = data(:,7);
referenceSunset = data(:,8);
lookupSunset = data(:,9);
referenceSunsetNorth = data(:,10);
lookupSunsetNorth = data(:,11);
referenceSunsetSouth = data(:,12);
lookupSunsetSouth = data(:,13);
arbitrarySunrise = data(:,14);
lookupArbitrarySunrise = data(:,15);
arbitrarySunset = data(:,16);
lookupArbitrarySunset = data(:,17);

plot(
	day, referenceSunrise, "-b;Reference;",
	day, lookupSunrise, "-r;Interpolated;",
	day, referenceSunriseNorth, "-g;Reference (North);",
	day, lookupSunriseNorth, "-m;Interpolated (North);",
	day, referenceSunriseSouth, "-y;Reference (South);",
	day, lookupSunriseSouth, "-k;Interpolated (South);");
title("Lookup Sunrise");
figure;

plot(
	day, referenceSunset, "-b;Reference;",
	day, lookupSunset, "-r;Interpolated;",
	day, referenceSunsetNorth, "-g;Reference (North);",
	day, lookupSunsetNorth, "-m;Interpolated (North);",
	day, referenceSunsetSouth, "-y;Reference (South);",
	day, lookupSunsetSouth, "-k;Interpolated (South);");
title("Lookup Sunset");
figure;

plot(
	day, arbitrarySunrise, "-b;Reference Sunrise;",
	day, lookupArbitrarySunrise, "-r;Interpolated Sunrise;",
	day, arbitrarySunset, "-g;Reference Sunset;",
	day, lookupArbitrarySunset, "-m;Interpolated Sunset;");
title("Arbitrary Sunrise / Sunset");
figure;
pause;
