#!/bin/bash
NORTH=1;
SOUTH=-1;
EAST=1;
WEST=-1;

YEAR=2000;
LATITUDE_SIGN=${NORTH};
LATITUDE_DEGREES=51;
LATITUDE_MINUTES=30;

LONGITUDE_SIGN=${WEST};
LONGITUDE_DEGREES=0;
LONGITUDE_MINUTES=7;

OUTPUT_FILENAME="SunriseSunsetTable.txt";

wget -O ${OUTPUT_FILENAME} "http://aa.usno.navy.mil/cgi-bin/aa_rstablew.pl?ID=AA&year=${YEAR}&task=0&place=&lon_sign=${LONGITUDE_SIGN}&lon_deg=${LONGITUDE_DEGREES}&lon_min=${LONGITUDE_MINUTES}&lat_sign=${LATITUDE_SIGN}&lat_deg=${LATITUDE_DEGREES}&lat_min=${LATITUDE_MINUTES}&tz=0&tz_sign=-1";
perl -0777 -pi -e "s/^.*<pre>(.+)<\/pre>.*$/\1/is" ${OUTPUT_FILENAME};
