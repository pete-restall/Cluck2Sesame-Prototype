# Cluck<sup>2</sup>Sesame - Yet Another Chicken Coop Door Opener

## What is it ?
It opens and closes the door of my wife's chicken coop based on Sunrise and
Sunset times so that she doesn't have to.  Or rather, it will do when I get
the time to finish it between paid work and free time.

## Why 'Cluck<sup>2</sup>Sesame' ?
Because 'Cluck Cluck Sesame' is obviously what the chickens would say if
they needed to open a door.  And 'Chicken Sesame' is a recipe.

## The Hardware and Firmware
The hardware and firmware are all mine.  The board is based around a
[PIC16F685](doc/datasheets/mcu/PIC16F685-I.pdf) as I've had some lying around
for years and was looking for an excuse to use them up.

The PIC16F685 is an 8-bit microcontroller with a whopping 4K of program words
(flash) and 256 bytes of RAM that can run at a respectable 8MHz (2MIPS)
without an external clock.  But more importantly it's got excellent
power-saving capabilities, which is critical when running off batteries.
Being a PIC it's also got a brilliant array of peripherals and an adequate
20-pin package.

The firmware is an experiment in writing test-first assembler, an endeavour
somewhat trickier than with high-level counterparts due to its lack of
encapsulation, global state, side-effects, the vagaries of linking, as well
as the verbosity of the language.  The tests are run in gpsim with bash
scripts for glue.  They are run as part of the automated Travis build.

## Pictures
| Freshly baked and stuffed PCB         | Attached to the Coop                        |
----------------------------------------|----------------------------------------------
| ![Stuffed PCB][stuffed-pcb-top-small] | ![Attached to Coop][attached-to-coop-small] |

## Build
[![Build Status](https://travis-ci.org/pete-restall/Cluck2Sesame.svg?branch=master)](https://travis-ci.org/pete-restall/Cluck2Sesame)

[stuffed-pcb-top-small]: doc/github/images/pcb-stuffed-top-400x228.png "Stuffed PCB (top)"
[attached-to-coop-small]: doc/github/images/attached-to-coop-304x228.png "Attached to Coop"
