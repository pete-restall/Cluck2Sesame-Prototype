Version=10.012
Setting type=Postprocessor settings
Length unit CNC=2
Feed unit CNC=13
File extension=nc
Use arcs=yes
I/J relative=yes
Program start text=
[>>>]
%
( Zero is the XY centre of the centre hole, with Z on top of the box )
( The first hole to be milled is the button to be fitted at the bottom, right-hand-side )
( The second hole to be milled is the drainage / wire hole on the bottom of the box )
( The last hole to be milled is the button to be fitted at the bottom, left-hand-side )
( Workpiece is assumed to be the 120mm x 120mm Hammond enclosure, 3mm thick polycarbonate )
( Remember to make sure that Estlcam is in Climb Milling mode ! )

(Project <project>)
(Created by Estlcam version <version> build <build>)
(Machining time about <time> hours)

(Required tools:)
<tools>

G90
M03 S<s>

[<<<]
Program end text=
[>>>]

M05
M30
%

[<<<]
Operation start text=
[>>>]


(No. <order>: <name>)
[<<<]
Tool change text=
[>>>]
M05
T<t> M06 (Change tool: <n>)
M03
[<<<]
Start cut text=
End cut text=
Name x=Y
Format x=
Order x=2
Scale x=1
Enable x=yes
Repeat x=no
Name y=X
Format y=
Order y=3
Scale y=1
Enable y=yes
Repeat y=no
Name z=Z
Format z=
Order z=4
Scale z=-1
Enable z=yes
Repeat z=no
Name i=J
Format i=
Order i=5
Scale i=1
Enable i=yes
Repeat i=yes
Name j=I
Format j=
Order j=6
Scale j=1
Enable j=yes
Repeat j=yes
Name f=F
Format f=
Order f=7
Scale f=1
Enable f=yes
Repeat f=no
Name s=S
Format s=
Order s=8
Scale s=1
Enable s=yes
Repeat s=no
Name n=
Format n=
Order n=1
Scale n=1
Enable n=no
Repeat n=no
Plot axis Z=no
Up Z=
Down Z=
Rapid feed XY=
Rapid feed Z=
Initial value N=1
Command rapid move=G00
Command linear move=G01
Command clockwise arc=G02
Command counterclockwise arc=G03
Command order=1
Command repear=yes
Encoder=0
Delimiter= 
Decimal point=.
Line end=
Character replacements=
[>>>]
Ä|Ae
Ö|Oe
Ü|Ue
ä|ae
ö|oe
ü|ue
ß|ss
[<<<]
Lock units=no
Hash=19AD182B2CF3041F
