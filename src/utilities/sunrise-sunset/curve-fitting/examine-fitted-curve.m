data = load("-ascii", "sunrise-sunset-fitted.txt");
x = data(:,1);
referenceSunrise = data(:,2);
fittedSunrise = data(:,3);

plot(x, referenceSunrise, "-b;Reference;", x, fittedSunrise, "-r;Fitted;");
title("Fitted Sunrise");
figure;
pause;
