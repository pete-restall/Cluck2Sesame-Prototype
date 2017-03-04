%
( Stock is 30mm diameter Acetal Rod )
( B axis holds the stock and rotates around Y axis )
( Zero on top of the workpiece, in the centre X of the stock, centre Y of intended 5mm groove )

G90 ( Absolute Co-ordinates )
G21 ( Units are mm )
G94 ( Feeds are mm / minute )
G00 Z-1 ( Clearance height )

#1 = [3.175 * 0.5] ( Tool radius )
#2 = [#1 * 0.1] ( Allowance for finishing cut )
#3 = [975.4] ( Roughing feed rate, mm/min )
#4 = [#3 / 2] ( Finishing feed rate, mm/min ) 

( Groove roughing cuts - 4.6825mm wide )
G00 X-20 Y[-2.5 + #1 + #2]
M03 S12000
O100 call [5] [#2] [#3] [#4]
O200 call [5] [#2] [#3] [#4]
G00 Y[2.5 - #1 - #2]
O100 call [5] [#2] [#3] [#4]
O200 call [5] [#2] [#3] [#4]

( Groove finishing cuts - 0.159mm wide )
G00 Y[-2.5 + #1]
O100 call [5] [#2] [#4] [#4]
O200 call [5] [#2] [#4] [#4]
G00 Y[2.5 - #1]
O100 call [5] [#2] [#4] [#4]
O200 call [5] [#2] [#4] [#4]

( Facing roughing cuts - 2.159mm past the edge of the groove )
G00 Z-1
G00 Y[2.5 + 2 + #1 + #2]
O300 call [#3]

( Facing finishing cuts - 2mm past the edge of the groove )
G00 Y[2.5 + 2 + #1]
O300 call [#4]

( End of Program )
G00 Z-10
G00 X0 Y0
M05
M30

( Horizontal cut, to avoid plunges )
( #1 - Total depth, mm )
( #2 - Finishing cut depth, mm )
( #3 - Roughing feed rate, mm/min )
( #4 - Finishing feed rate, mm/min )
O100 sub
	G01 F[#3]
	#30 = [1 - #2]
	O101 do
		O110 call [#30]
		#30 = [#30 + 1]
	O101 while [#30 lt #1]
	G01 F[#4]
	O110 call [#1]
O100 endsub

( Horizontal cut for lead-in )
( #1 - Absolute Z )
O110 sub
	G00 Z[#1]
	G91
	G01 X20
	G00 X-20
	G90
O110 endsub

( Turned cut, 360 degrees clockwise around the B axis )
( #1 - Total depth, mm )
( #2 - Finishing cut depth, mm )
( #3 - Roughing feed rate, mm/min )
( #4 - Finishing feed rate, mm/min )
O200 sub
	#30 = [1 - #2]
	O201 do
		O210 call [#30] [#3]
		#30 = [#30 + 1]
	O201 while [#30 lt #1]
	O210 call [#1] [#4]
O200 endsub

( Turned cut, clockwise, assuming 15mm radius stock )
( #1 - Absolute Z )
( #2 - Feed rate, mm/min )
( #3 - Rotary feed rate, deg/min )
O210 sub
	G00 Z[#1]
	G91
	G01 X20 F[#2]
	G01 B-360 F[360 * #2 / [2 * 3.1415926535 * [15 - #1]]]
	G00 X-20
	G90
O210 endsub

( Facing )
( #1 - Feed rate, mm/min )
O300 sub
	#30 = 0
	O301 do
		O400 call [16] [40] [#1]
		O500 call
		#30 = [#30 + 1]
	O301 while [#30 lt 4]
O300 endsub

( Horizontal cut, facing )
( #1 - Total depth, mm )
( #2 - Total width, mm )
( #3 - Feed rate, mm/min )
O400 sub
	G01 F[#3]
	#30 = 1
	G00 Z[#30]
	O401 do
		O410 call [#2]
		#30 = [#30 + 2]
	O401 while [#30 lt #1]
O400 endsub

( Horizontal cut, Z increment and return, facing )
( #1 - Total width, mm )
O410 sub
	G91
	G01 X[#1]
	G00 Z1
	G01 X[-1 * #1]
	G00 Z1
	G90
O410 endsub

( Rotate B 90 degrees )
O500 sub
	G91
	G0 B90
	G90
O500 endsub
%
