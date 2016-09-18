Customer:
---------
Pete Restall (Parity Computer Consultancy Limited) - pete@restall.net
Any problems / questions, please do not hesitate to get in touch.

Guidelines Followed From:
-------------------------
http://www.pcbtrain.co.uk/schematic/pcb-technical-advice/

Design Tools Used:
------------------
DesignSpark 7.1
GC-Prevue 20.3.6

Track and Spacing:
------------------
Minimum 6mil.

Layers:
-------
All viewed from above, no mirroring.  Solder Resist layers are negatives, all
others are positives.  See "Cluck2Sesame Layers.pdf" for a non-Gerber
representation of what the individual layers should look like.

Board Outline:
--------------
All layers contain a zero-width board outline.  Outline size is
3.542in x 1.968in and >= 10mil from any feature, copper or otherwise.

Vias and Silkscreen:
--------------------
Some vias are partially covered with silkscreen; this is not anticipated to
be an issue since they should be covered / plugged with resist.

Pads and Silkscreen:
--------------------
CONN204 silkscreen touches the M3 washer pad in the top-left of the board.
The silkscreen can be removed where necessary, but please advise if this is
an issue.

Vias and Pads:
--------------
Some vias are very close to pads, but the outer edge of drill holes should
be >= 6mil from the edge of the pad.  This may or may not be an issue (ie.
solder resist), but please advise if it is.

There are two vias inside the thermal pad of U101.  These should not be
tented as they provide thermal relief.  Please advise if this is an issue.

Drill Holes:
------------
All are through-plated and are finished sizes; no adjustments have been made
for plating thickness.  All are >= 10mil from the edge of the board.  Please
advise if any drill sizes are found to be incompatible with your processes.
Annular rings >= 6mil.

Data Formats:
-------------
More detailed information can be found in "DesignSpark Plot Report.TXT", but
in summary:

---------------
Gerber Settings
---------------

    Leading zero suppression.
    G01 assumed throughout.
    Line termination <*> <CR> <LF>.
    2.4 format absolute inches.
    Format commands defined in Gerber file.
    Aperture table defined in Gerber file.
    Hardware arcs allowed.

--------------
Drill Settings
--------------

    Excellon Format 1
    Format 3.4 absolute in inches.
    No zero suppression.

