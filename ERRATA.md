# Cluck<sup>2</sup>Sesame - Yet Another Chicken Coop Door Opener
# Errata, Suggested Improvements and Otherwise Undocumented Design Changes

## PCB
- After testing with the actual motor, the LM4040CYM3-2.5 would be best
  replaced with a reference of 2V (or 2.048V for another LM4040 series) for
  a cut-off of about 600mA; the firmware cut-off is about 500mA.  Don't forget
  to re-calculate R110 for the new quiescent current !

## Spool
- The tie-hole on the spool was increased from 0.5mm to 0.8mm to accomodate
  the multi-stranded line.  Multi-stranded line has less stretch and is a
  better fit for this application.

- The height of the stand-off for the spool was decreased as the width of the
  winding section was increased to 5mm.

## Motor
- The JGY-370 is a 6V motor running at around 3V.  While it is sufficient to
  raise and lower a door of about 500g, it wouldn't cope particularly well
  with the 1kg load that was the initial target weight.  Indeed, the current
  cut-off kicks in well before 1kg.
