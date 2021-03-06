EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:cmos_ieee
LIBS:ti
LIBS:ESP8266
LIBS:tt-display-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L 7SEGMENTS AFF1
U 1 1 57619CA0
P 4800 1400
F 0 "AFF1" H 4800 1950 50  0000 C CNN
F 1 "7SEGMENTS" H 4800 950 50  0000 C CNN
F 2 "" H 4800 1400 50  0000 C CNN
F 3 "" H 4800 1400 50  0000 C CNN
	1    4800 1400
	1    0    0    -1  
$EndComp
$Comp
L 7SEGMENTS AFF2
U 1 1 57619E9D
P 4750 2750
F 0 "AFF2" H 4750 3300 50  0000 C CNN
F 1 "7SEGMENTS" H 4750 2300 50  0000 C CNN
F 2 "" H 4750 2750 50  0000 C CNN
F 3 "" H 4750 2750 50  0000 C CNN
	1    4750 2750
	1    0    0    -1  
$EndComp
$Comp
L TLC5916 U1
U 1 1 5761A010
P 2950 1300
F 0 "U1" H 2950 800 50  0000 C CNN
F 1 "TLC5916" H 2950 1800 50  0000 C CNN
F 2 "" H 2950 1300 60  0000 C CNN
F 3 "" H 2950 1300 60  0000 C CNN
	1    2950 1300
	1    0    0    -1  
$EndComp
Text GLabel 3500 1350 2    60   Input ~ 0
A1
Text GLabel 4050 1000 0    60   Output ~ 0
A1
Wire Wire Line
	4050 1000 4200 1000
$Comp
L GND #PWR?
U 1 1 5761A189
P 2350 950
F 0 "#PWR?" H 2350 700 50  0001 C CNN
F 1 "GND" H 2350 800 50  0000 C CNN
F 2 "" H 2350 950 50  0000 C CNN
F 3 "" H 2350 950 50  0000 C CNN
	1    2350 950 
	0    1    1    0   
$EndComp
Wire Wire Line
	2550 950  2350 950 
$Comp
L TLC5916 U2
U 1 1 5761A1B3
P 2950 2450
F 0 "U2" H 2950 1950 50  0000 C CNN
F 1 "TLC5916" H 2950 2950 50  0000 C CNN
F 2 "" H 2950 2450 60  0000 C CNN
F 3 "" H 2950 2450 60  0000 C CNN
	1    2950 2450
	1    0    0    -1  
$EndComp
Text GLabel 3700 1450 2    60   Input ~ 0
B1
Wire Wire Line
	3350 1450 3700 1450
Text GLabel 3500 1550 2    60   Input ~ 0
F1
Text GLabel 3700 1650 2    60   Input ~ 0
G1
Text GLabel 2350 1350 0    60   Input ~ 0
C1
Text GLabel 2100 1450 0    60   Input ~ 0
DP1
Text GLabel 2350 1550 0    60   Input ~ 0
D1
Text GLabel 2100 1650 0    60   Input ~ 0
E1
Wire Wire Line
	2550 1350 2350 1350
Wire Wire Line
	2550 1450 2100 1450
Wire Wire Line
	2550 1550 2350 1550
Wire Wire Line
	2550 1650 2100 1650
Wire Wire Line
	3350 1550 3500 1550
Wire Wire Line
	3350 1650 3700 1650
$Comp
L +12V #PWR?
U 1 1 5761A40E
P 5700 2300
F 0 "#PWR?" H 5700 2150 50  0001 C CNN
F 1 "+12V" H 5700 2440 50  0000 C CNN
F 2 "" H 5700 2300 50  0000 C CNN
F 3 "" H 5700 2300 50  0000 C CNN
	1    5700 2300
	0    1    1    0   
$EndComp
$Comp
L +12V #PWR?
U 1 1 5761A42A
P 5700 950
F 0 "#PWR?" H 5700 800 50  0001 C CNN
F 1 "+12V" H 5700 1090 50  0000 C CNN
F 2 "" H 5700 950 50  0000 C CNN
F 3 "" H 5700 950 50  0000 C CNN
	1    5700 950 
	0    1    1    0   
$EndComp
Wire Wire Line
	5400 950  5700 950 
Wire Wire Line
	5350 2300 5700 2300
Text GLabel 3500 2600 2    60   Input ~ 0
A2
Text GLabel 4000 2350 0    60   Output ~ 0
A2
Wire Wire Line
	4000 2350 4150 2350
Wire Wire Line
	3500 2600 3350 2600
$Comp
L GND #PWR?
U 1 1 5761A53E
P 2400 2100
F 0 "#PWR?" H 2400 1850 50  0001 C CNN
F 1 "GND" H 2400 1950 50  0000 C CNN
F 2 "" H 2400 2100 50  0000 C CNN
F 3 "" H 2400 2100 50  0000 C CNN
	1    2400 2100
	0    1    1    0   
$EndComp
$Comp
L TLC5916 U3
U 1 1 5761A56D
P 2950 3600
F 0 "U3" H 2950 3100 50  0000 C CNN
F 1 "TLC5916" H 2950 4100 50  0000 C CNN
F 2 "" H 2950 3600 60  0000 C CNN
F 3 "" H 2950 3600 60  0000 C CNN
	1    2950 3600
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 5761A5DF
P 2400 3250
F 0 "#PWR?" H 2400 3000 50  0001 C CNN
F 1 "GND" H 2400 3100 50  0000 C CNN
F 2 "" H 2400 3250 50  0000 C CNN
F 3 "" H 2400 3250 50  0000 C CNN
	1    2400 3250
	0    1    1    0   
$EndComp
$Comp
L TLC5916 U4
U 1 1 5761AF58
P 2950 4750
F 0 "U4" H 2950 4250 50  0000 C CNN
F 1 "TLC5916" H 2950 5250 50  0000 C CNN
F 2 "" H 2950 4750 60  0000 C CNN
F 3 "" H 2950 4750 60  0000 C CNN
	1    2950 4750
	1    0    0    -1  
$EndComp
$Comp
L TLC5916 U5
U 1 1 5761AFC0
P 2950 5900
F 0 "U5" H 2950 5400 50  0000 C CNN
F 1 "TLC5916" H 2950 6400 50  0000 C CNN
F 2 "" H 2950 5900 60  0000 C CNN
F 3 "" H 2950 5900 60  0000 C CNN
	1    2950 5900
	1    0    0    -1  
$EndComp
$Comp
L TLC5916 U6
U 1 1 5761B2CC
P 2950 7050
F 0 "U6" H 2950 6550 50  0000 C CNN
F 1 "TLC5916" H 2950 7550 50  0000 C CNN
F 2 "" H 2950 7050 60  0000 C CNN
F 3 "" H 2950 7050 60  0000 C CNN
	1    2950 7050
	1    0    0    -1  
$EndComp
Wire Wire Line
	2400 2100 2550 2100
Wire Wire Line
	2400 3250 2550 3250
$Comp
L GND #PWR?
U 1 1 5761BAC1
P 2450 4400
F 0 "#PWR?" H 2450 4150 50  0001 C CNN
F 1 "GND" H 2450 4250 50  0000 C CNN
F 2 "" H 2450 4400 50  0000 C CNN
F 3 "" H 2450 4400 50  0000 C CNN
	1    2450 4400
	0    1    1    0   
$EndComp
$Comp
L GND #PWR?
U 1 1 5761BAE4
P 2450 5550
F 0 "#PWR?" H 2450 5300 50  0001 C CNN
F 1 "GND" H 2450 5400 50  0000 C CNN
F 2 "" H 2450 5550 50  0000 C CNN
F 3 "" H 2450 5550 50  0000 C CNN
	1    2450 5550
	0    1    1    0   
$EndComp
$Comp
L GND #PWR?
U 1 1 5761BCBF
P 2450 6700
F 0 "#PWR?" H 2450 6450 50  0001 C CNN
F 1 "GND" H 2450 6550 50  0000 C CNN
F 2 "" H 2450 6700 50  0000 C CNN
F 3 "" H 2450 6700 50  0000 C CNN
	1    2450 6700
	0    1    1    0   
$EndComp
Wire Wire Line
	2450 6700 2550 6700
Wire Wire Line
	2450 5550 2550 5550
Wire Wire Line
	2450 4400 2550 4400
$Comp
L +3.3V #PWR?
U 1 1 5761CD4C
P 3450 950
F 0 "#PWR?" H 3450 800 50  0001 C CNN
F 1 "+3.3V" H 3450 1090 50  0000 C CNN
F 2 "" H 3450 950 50  0000 C CNN
F 3 "" H 3450 950 50  0000 C CNN
	1    3450 950 
	0    1    1    0   
$EndComp
$Comp
L +3.3V #PWR?
U 1 1 5761CD76
P 3450 2100
F 0 "#PWR?" H 3450 1950 50  0001 C CNN
F 1 "+3.3V" H 3450 2240 50  0000 C CNN
F 2 "" H 3450 2100 50  0000 C CNN
F 3 "" H 3450 2100 50  0000 C CNN
	1    3450 2100
	0    1    1    0   
$EndComp
$Comp
L +3.3V #PWR?
U 1 1 5761CD99
P 3450 3250
F 0 "#PWR?" H 3450 3100 50  0001 C CNN
F 1 "+3.3V" H 3450 3390 50  0000 C CNN
F 2 "" H 3450 3250 50  0000 C CNN
F 3 "" H 3450 3250 50  0000 C CNN
	1    3450 3250
	0    1    1    0   
$EndComp
$Comp
L +3.3V #PWR?
U 1 1 5761D014
P 3450 4400
F 0 "#PWR?" H 3450 4250 50  0001 C CNN
F 1 "+3.3V" H 3450 4540 50  0000 C CNN
F 2 "" H 3450 4400 50  0000 C CNN
F 3 "" H 3450 4400 50  0000 C CNN
	1    3450 4400
	0    1    1    0   
$EndComp
$Comp
L +3.3V #PWR?
U 1 1 5761D037
P 3450 5550
F 0 "#PWR?" H 3450 5400 50  0001 C CNN
F 1 "+3.3V" H 3450 5690 50  0000 C CNN
F 2 "" H 3450 5550 50  0000 C CNN
F 3 "" H 3450 5550 50  0000 C CNN
	1    3450 5550
	0    1    1    0   
$EndComp
$Comp
L +3.3V #PWR?
U 1 1 5761D1A2
P 3450 6700
F 0 "#PWR?" H 3450 6550 50  0001 C CNN
F 1 "+3.3V" H 3450 6840 50  0000 C CNN
F 2 "" H 3450 6700 50  0000 C CNN
F 3 "" H 3450 6700 50  0000 C CNN
	1    3450 6700
	0    1    1    0   
$EndComp
Wire Wire Line
	3350 6700 3450 6700
Wire Wire Line
	3350 5550 3450 5550
Wire Wire Line
	3350 4400 3450 4400
Wire Wire Line
	3350 3250 3450 3250
Wire Wire Line
	3350 2100 3450 2100
Wire Wire Line
	3350 950  3450 950 
Text GLabel 1800 1050 0    60   Input ~ 0
SDI
Wire Wire Line
	2550 1050 1800 1050
Wire Wire Line
	3350 1150 4000 1150
Wire Wire Line
	4000 1150 4000 1900
Wire Wire Line
	4000 1900 2050 1900
Wire Wire Line
	2050 1900 2050 2200
Wire Wire Line
	2050 2200 2550 2200
Wire Wire Line
	3350 2300 3700 2300
Wire Wire Line
	3700 2300 3700 3000
Wire Wire Line
	3700 3000 2000 3000
Wire Wire Line
	2000 3000 2000 3350
Wire Wire Line
	2000 3350 2550 3350
Wire Wire Line
	3350 3450 3600 3450
Wire Wire Line
	3600 3450 3600 4150
Wire Wire Line
	3600 4150 2050 4150
Wire Wire Line
	2050 4150 2050 4500
Wire Wire Line
	2050 4500 2550 4500
Wire Wire Line
	3350 4600 3450 4600
Wire Wire Line
	3450 4600 3450 5300
Wire Wire Line
	3450 5300 2200 5300
Wire Wire Line
	2200 5300 2200 5650
Wire Wire Line
	2200 5650 2550 5650
Wire Wire Line
	3350 5750 3450 5750
Wire Wire Line
	3450 5750 3450 6450
Wire Wire Line
	3450 6450 2200 6450
Wire Wire Line
	2200 6450 2200 6800
Wire Wire Line
	2200 6800 2550 6800
Wire Wire Line
	3350 1350 3500 1350
Text Notes 5200 1300 0    60   ~ 0
Left Game klein
Text Notes 4300 3750 0    60   ~ 0
Left Point Einer
Text Notes 5400 2700 0    60   ~ 0
Left Point Zehner
Text Notes 4300 4900 0    60   ~ 0
Right Point Zehner
Text Notes 4300 5900 0    60   ~ 0
Right Point Einer
Text Notes 4350 7100 0    60   ~ 0
Right Game klein
$Comp
L LED D1
U 1 1 5761F321
P 1700 4900
F 0 "D1" H 1700 5000 50  0000 C CNN
F 1 "LED" H 1700 4800 50  0000 C CNN
F 2 "" H 1700 4900 50  0000 C CNN
F 3 "" H 1700 4900 50  0000 C CNN
	1    1700 4900
	-1   0    0    1   
$EndComp
$Comp
L LED D2
U 1 1 5761F71A
P 2200 4900
F 0 "D2" H 2200 5000 50  0000 C CNN
F 1 "LED" H 2200 4800 50  0000 C CNN
F 2 "" H 2200 4900 50  0000 C CNN
F 3 "" H 2200 4900 50  0000 C CNN
	1    2200 4900
	-1   0    0    1   
$EndComp
Wire Wire Line
	2400 4900 2550 4900
Wire Wire Line
	1900 4900 2000 4900
$Comp
L +12V #PWR?
U 1 1 5761F937
P 1350 4900
F 0 "#PWR?" H 1350 4750 50  0001 C CNN
F 1 "+12V" H 1350 5040 50  0000 C CNN
F 2 "" H 1350 4900 50  0000 C CNN
F 3 "" H 1350 4900 50  0000 C CNN
	1    1350 4900
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1350 4900 1500 4900
Text Notes 1450 5100 0    60   ~ 0
Seperation
Text GLabel 1500 1150 0    60   Input ~ 0
CLK
Text GLabel 1500 2300 0    60   Input ~ 0
CLK
Text GLabel 1500 3450 0    60   Input ~ 0
CLK
Text GLabel 1550 4600 0    60   Input ~ 0
CLK
Text GLabel 1550 5750 0    60   Input ~ 0
CLK
Text GLabel 1550 6900 0    60   Input ~ 0
CLK
Wire Wire Line
	1500 1150 2550 1150
Wire Wire Line
	1500 2300 2550 2300
Wire Wire Line
	1500 3450 2550 3450
Wire Wire Line
	1550 4600 2550 4600
Wire Wire Line
	1550 5750 2550 5750
Wire Wire Line
	1550 6900 2550 6900
Text GLabel 1750 1250 0    60   Input ~ 0
LE
Text GLabel 1750 2400 0    60   Input ~ 0
LE
Text GLabel 1700 3550 0    60   Input ~ 0
LE
Text GLabel 1750 4700 0    60   Input ~ 0
LE
Text GLabel 1750 5850 0    60   Input ~ 0
LE
Text GLabel 1750 7000 0    60   Input ~ 0
LE
Wire Wire Line
	1750 4700 2550 4700
Wire Wire Line
	1750 5850 2550 5850
Wire Wire Line
	1750 7000 2550 7000
Wire Wire Line
	1700 3550 2550 3550
Wire Wire Line
	1750 2400 2550 2400
Wire Wire Line
	1750 1250 2550 1250
Text GLabel 3750 1250 2    60   Input ~ 0
OE
Wire Wire Line
	3750 1250 3350 1250
Text GLabel 3500 2400 2    60   Input ~ 0
OE
Text GLabel 3400 3550 2    60   Input ~ 0
OE
Text GLabel 3550 4700 2    60   Input ~ 0
OE
Wire Wire Line
	3500 2400 3350 2400
Wire Wire Line
	3400 3550 3350 3550
Wire Wire Line
	3550 4700 3350 4700
Text GLabel 3600 5850 2    60   Input ~ 0
OE
Text GLabel 3600 7000 2    60   Input ~ 0
OE
Wire Wire Line
	3600 5850 3350 5850
Wire Wire Line
	3600 7000 3350 7000
$Comp
L R R?
U 1 1 57623C05
P 3750 900
F 0 "R?" V 3830 900 50  0000 C CNN
F 1 "820" V 3750 900 50  0000 C CNN
F 2 "" V 3680 900 50  0000 C CNN
F 3 "" H 3750 900 50  0000 C CNN
	1    3750 900 
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR?
U 1 1 57623C8F
P 3750 700
F 0 "#PWR?" H 3750 450 50  0001 C CNN
F 1 "GND" H 3750 550 50  0000 C CNN
F 2 "" H 3750 700 50  0000 C CNN
F 3 "" H 3750 700 50  0000 C CNN
	1    3750 700 
	-1   0    0    1   
$EndComp
Wire Wire Line
	3350 1050 3750 1050
Wire Wire Line
	3750 750  3750 700 
$Comp
L R R?
U 1 1 57623D8C
P 3850 2200
F 0 "R?" V 3930 2200 50  0000 C CNN
F 1 "820" V 3850 2200 50  0000 C CNN
F 2 "" V 3780 2200 50  0000 C CNN
F 3 "" H 3850 2200 50  0000 C CNN
	1    3850 2200
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR?
U 1 1 57623E0C
P 4100 2200
F 0 "#PWR?" H 4100 1950 50  0001 C CNN
F 1 "GND" H 4100 2050 50  0000 C CNN
F 2 "" H 4100 2200 50  0000 C CNN
F 3 "" H 4100 2200 50  0000 C CNN
	1    4100 2200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3350 2200 3700 2200
Wire Wire Line
	4000 2200 4100 2200
$Comp
L R R?
U 1 1 57623EEC
P 3850 3350
F 0 "R?" V 3930 3350 50  0000 C CNN
F 1 "820" V 3850 3350 50  0000 C CNN
F 2 "" V 3780 3350 50  0000 C CNN
F 3 "" H 3850 3350 50  0000 C CNN
	1    3850 3350
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR?
U 1 1 57623F55
P 4100 3350
F 0 "#PWR?" H 4100 3100 50  0001 C CNN
F 1 "GND" H 4100 3200 50  0000 C CNN
F 2 "" H 4100 3350 50  0000 C CNN
F 3 "" H 4100 3350 50  0000 C CNN
	1    4100 3350
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3350 3350 3700 3350
Wire Wire Line
	4000 3350 4100 3350
$Comp
L R R?
U 1 1 576245A0
P 3800 4500
F 0 "R?" V 3880 4500 50  0000 C CNN
F 1 "820" V 3800 4500 50  0000 C CNN
F 2 "" V 3730 4500 50  0000 C CNN
F 3 "" H 3800 4500 50  0000 C CNN
	1    3800 4500
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR?
U 1 1 57624602
P 4050 4500
F 0 "#PWR?" H 4050 4250 50  0001 C CNN
F 1 "GND" H 4050 4350 50  0000 C CNN
F 2 "" H 4050 4500 50  0000 C CNN
F 3 "" H 4050 4500 50  0000 C CNN
	1    4050 4500
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3350 4500 3650 4500
Wire Wire Line
	3950 4500 4050 4500
$Comp
L R R?
U 1 1 576246F4
P 3850 5650
F 0 "R?" V 3930 5650 50  0000 C CNN
F 1 "820" V 3850 5650 50  0000 C CNN
F 2 "" V 3780 5650 50  0000 C CNN
F 3 "" H 3850 5650 50  0000 C CNN
	1    3850 5650
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR?
U 1 1 5762476B
P 4100 5650
F 0 "#PWR?" H 4100 5400 50  0001 C CNN
F 1 "GND" H 4100 5500 50  0000 C CNN
F 2 "" H 4100 5650 50  0000 C CNN
F 3 "" H 4100 5650 50  0000 C CNN
	1    4100 5650
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3350 5700 3350 5650
Wire Wire Line
	3350 5650 3700 5650
Wire Wire Line
	4000 5650 4100 5650
$Comp
L R R?
U 1 1 57624C90
P 3850 6800
F 0 "R?" V 3930 6800 50  0000 C CNN
F 1 "820" V 3850 6800 50  0000 C CNN
F 2 "" V 3780 6800 50  0000 C CNN
F 3 "" H 3850 6800 50  0000 C CNN
	1    3850 6800
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR?
U 1 1 57624D36
P 4100 6800
F 0 "#PWR?" H 4100 6550 50  0001 C CNN
F 1 "GND" H 4100 6650 50  0000 C CNN
F 2 "" H 4100 6800 50  0000 C CNN
F 3 "" H 4100 6800 50  0000 C CNN
	1    4100 6800
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3350 6800 3700 6800
Wire Wire Line
	4000 6800 4100 6800
$Comp
L ESP-12 U?
U 1 1 57657ADC
P 7900 1700
F 0 "U?" H 7900 1600 50  0000 C CNN
F 1 "ESP-12" H 7900 1800 50  0000 C CNN
F 2 "" H 7900 1700 50  0001 C CNN
F 3 "" H 7900 1700 50  0001 C CNN
	1    7900 1700
	1    0    0    -1  
$EndComp
Text Label 7000 1700 0    39   ~ 0
D0
Text Label 7000 1800 0    39   ~ 0
D5
Text Label 7000 1900 0    39   ~ 0
D6
Text Label 7000 2000 0    39   ~ 0
D7
Text Label 8800 1600 0    39   ~ 0
D1
Text Label 8800 1700 0    39   ~ 0
D2
Text Label 8800 1800 0    39   ~ 0
D3
Text Label 8800 1900 0    39   ~ 0
D4
Text Label 8800 2000 0    39   ~ 0
D8
Text Notes 6550 1050 0    60   ~ 0
D0-D8 for Wemos D1 mini
$Comp
L +3.3V #PWR?
U 1 1 5765823D
P 7900 750
F 0 "#PWR?" H 7900 600 50  0001 C CNN
F 1 "+3.3V" H 7900 890 50  0000 C CNN
F 2 "" H 7900 750 50  0000 C CNN
F 3 "" H 7900 750 50  0000 C CNN
	1    7900 750 
	1    0    0    -1  
$EndComp
Wire Wire Line
	7900 750  7900 800 
$Comp
L GND #PWR?
U 1 1 576582E3
P 7900 2700
F 0 "#PWR?" H 7900 2450 50  0001 C CNN
F 1 "GND" H 7900 2550 50  0000 C CNN
F 2 "" H 7900 2700 50  0000 C CNN
F 3 "" H 7900 2700 50  0000 C CNN
	1    7900 2700
	1    0    0    -1  
$EndComp
Wire Wire Line
	7900 2600 7900 2700
$Comp
L SW_PUSH SW1
U 1 1 57658513
P 9850 1000
F 0 "SW1" H 10000 1110 50  0000 C CNN
F 1 "Right" H 9850 920 50  0000 C CNN
F 2 "" H 9850 1000 50  0000 C CNN
F 3 "" H 9850 1000 50  0000 C CNN
	1    9850 1000
	0    1    1    0   
$EndComp
$Comp
L SW_PUSH SW2
U 1 1 576586A6
P 10250 1000
F 0 "SW2" H 10400 1110 50  0000 C CNN
F 1 "Left" H 10250 920 50  0000 C CNN
F 2 "" H 10250 1000 50  0000 C CNN
F 3 "" H 10250 1000 50  0000 C CNN
	1    10250 1000
	0    1    1    0   
$EndComp
Wire Wire Line
	8800 1800 9850 1800
Wire Wire Line
	9850 1800 9850 1300
Wire Wire Line
	8800 1900 10250 1900
Wire Wire Line
	10250 1900 10250 1300
$Comp
L GND #PWR?
U 1 1 57658873
P 9750 700
F 0 "#PWR?" H 9750 450 50  0001 C CNN
F 1 "GND" H 9750 550 50  0000 C CNN
F 2 "" H 9750 700 50  0000 C CNN
F 3 "" H 9750 700 50  0000 C CNN
	1    9750 700 
	0    1    1    0   
$EndComp
Wire Wire Line
	9750 700  10250 700 
Connection ~ 9850 700 
Text GLabel 9050 1600 2    39   Output ~ 0
SCL
Wire Wire Line
	8800 1600 9050 1600
Text GLabel 9050 1700 2    39   Output ~ 0
SDA
Wire Wire Line
	8800 1700 9050 1700
Text Notes 9250 1650 0    39   ~ 0
Oled
Text GLabel 6900 1800 0    39   Output ~ 0
CLK
Wire Wire Line
	7000 1800 6900 1800
Text GLabel 6900 1900 0    39   Output ~ 0
SDI
Wire Wire Line
	6900 1900 7000 1900
Text GLabel 6900 2000 0    39   Output ~ 0
LE
Wire Wire Line
	6900 2000 7000 2000
Text GLabel 9050 2000 2    39   Output ~ 0
OE
Wire Wire Line
	9050 2000 8800 2000
$Comp
L R 1.22M
U 1 1 5766C0DC
P 6750 1500
F 0 "1.22M" V 6830 1500 50  0000 C CNN
F 1 "R" V 6750 1500 50  0000 C CNN
F 2 "" V 6680 1500 50  0000 C CNN
F 3 "" H 6750 1500 50  0000 C CNN
	1    6750 1500
	0    1    1    0   
$EndComp
Wire Wire Line
	6900 1500 7000 1500
$Comp
L +12V #PWR?
U 1 1 5766C200
P 6450 1500
F 0 "#PWR?" H 6450 1350 50  0001 C CNN
F 1 "+12V" H 6450 1640 50  0000 C CNN
F 2 "" H 6450 1500 50  0000 C CNN
F 3 "" H 6450 1500 50  0000 C CNN
	1    6450 1500
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6600 1500 6450 1500
Text Label 7000 1500 0    39   ~ 0
A0
Text Notes 6400 1450 0    39   ~ 0
Voricht: Wemos A0\nist Spannungsteiler
$EndSCHEMATC
