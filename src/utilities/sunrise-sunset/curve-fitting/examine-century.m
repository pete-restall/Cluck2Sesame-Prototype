data = load("-ascii", "sunrise-sunset.txt");
day = data(:,1);
referenceSunrise = data(:,2);
fittedSunrise = data(:,3);
referenceSunset = data(:,4);
fittedSunset = data(:,5);

plot(day, referenceSunrise, "-b;Reference;", day, fittedSunrise, "-r;Fitted;");
title("Fitted Sunrise");
figure;

plot(day, referenceSunset, "-b;Reference;", day, fittedSunset, "-r;Fitted;");
title("Fitted Sunset");
figure;
pause;
