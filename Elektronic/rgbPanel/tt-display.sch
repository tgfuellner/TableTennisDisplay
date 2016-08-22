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
LIBS:ESP8266
LIBS:arduino_shieldsNCL
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
Text Notes 7300 1050 0    60   ~ 0
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
Oled and Hub75
Text Label 7000 1500 0    39   ~ 0
A0
$Comp
L SW_PUSH SW3
U 1 1 57BAD221
P 6400 1000
F 0 "SW3" H 6550 1110 50  0000 C CNN
F 1 "Shift" H 6400 920 50  0000 C CNN
F 2 "" H 6400 1000 50  0000 C CNN
F 3 "" H 6400 1000 50  0000 C CNN
	1    6400 1000
	0    1    1    0   
$EndComp
$Comp
L GND #PWR?
U 1 1 57BAD46B
P 6750 700
F 0 "#PWR?" H 6750 450 50  0001 C CNN
F 1 "GND" H 6750 550 50  0000 C CNN
F 2 "" H 6750 700 50  0000 C CNN
F 3 "" H 6750 700 50  0000 C CNN
	1    6750 700 
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6400 700  6750 700 
Wire Wire Line
	6400 1300 6400 1800
Wire Wire Line
	6400 1800 7000 1800
$Comp
L ARDUINO_MEGA_SHIELD Hub75
U 1 1 57BAD64E
P 3100 4300
F 0 "Hub75 Driver" H 2700 6800 60  0000 C CNN
F 1 "ARDUINO_MEGA_SHIELD" H 3000 1600 60  0000 C CNN
F 2 "" H 3100 4300 60  0000 C CNN
F 3 "" H 3100 4300 60  0000 C CNN
	1    3100 4300
	1    0    0    -1  
$EndComp
Text GLabel 4150 4450 2    39   Output ~ 0
SCL
Wire Wire Line
	4000 4450 4150 4450
Text GLabel 4150 4350 2    39   Output ~ 0
SDA
Wire Wire Line
	4000 4350 4150 4350
$Comp
L USB_A P?
U 1 1 57BADAF6
P 3050 1000
F 0 "P?" H 3250 800 50  0000 C CNN
F 1 "USB_A" H 3000 1200 50  0000 C CNN
F 2 "" V 3000 900 50  0000 C CNN
F 3 "" V 3000 900 50  0000 C CNN
	1    3050 1000
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X02 P?
U 1 1 57BADBBB
P 1800 1100
F 0 "P?" H 1800 1250 50  0000 C CNN
F 1 "CONN_01X02" V 1900 1100 50  0000 C CNN
F 2 "" H 1800 1100 50  0000 C CNN
F 3 "" H 1800 1100 50  0000 C CNN
	1    1800 1100
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1850 1300 1850 2550
Wire Wire Line
	1850 2550 2100 2550
Wire Wire Line
	1750 1300 1750 2650
Wire Wire Line
	1750 2650 2100 2650
Wire Wire Line
	2850 1300 2850 1400
Wire Wire Line
	1850 1400 3900 1400
Connection ~ 1850 1400
Wire Wire Line
	3150 1300 3150 1500
Wire Wire Line
	1750 1500 4200 1500
Connection ~ 1750 1500
$Comp
L CONN_01X04 P?
U 1 1 57BAE4FB
P 4050 900
F 0 "P?" H 4050 1150 50  0000 C CNN
F 1 "CONN_01X04" V 4150 900 50  0000 C CNN
F 2 "" H 4050 900 50  0000 C CNN
F 3 "" H 4050 900 50  0000 C CNN
	1    4050 900 
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4200 1500 4200 1100
Connection ~ 3150 1500
Wire Wire Line
	3900 1400 3900 1100
Connection ~ 2850 1400
Text GLabel 4100 1250 3    39   Output ~ 0
SCL
Text GLabel 4000 1250 3    39   Output ~ 0
SDA
Wire Wire Line
	4000 1100 4000 1250
Wire Wire Line
	4100 1100 4100 1250
$Comp
L CONN_02X08 P?
U 1 1 57BAEA77
P 5600 5500
F 0 "P?" H 5600 5950 50  0000 C CNN
F 1 "Hub75" V 5600 5500 50  0000 C CNN
F 2 "" H 5600 4300 50  0000 C CNN
F 3 "" H 5600 4300 50  0000 C CNN
	1    5600 5500
	1    0    0    -1  
$EndComp
Wire Wire Line
	4000 5150 5350 5150
Text Notes 5250 5150 0    60   ~ 0
R1
Text GLabel 6050 5150 2    60   Input ~ 0
G1
Text GLabel 4200 5250 2    60   Input ~ 0
G1
Wire Wire Line
	5850 5150 6050 5150
Wire Wire Line
	4000 5250 4200 5250
Text Notes 5250 5250 0    60   ~ 0
B1
Wire Wire Line
	4000 5350 4700 5350
Wire Wire Line
	4700 5350 4700 5250
Wire Wire Line
	4700 5250 5350 5250
$Comp
L GND #PWR?
U 1 1 57BAEFCD
P 6250 5250
F 0 "#PWR?" H 6250 5000 50  0001 C CNN
F 1 "GND" H 6250 5100 50  0000 C CNN
F 2 "" H 6250 5250 50  0000 C CNN
F 3 "" H 6250 5250 50  0000 C CNN
	1    6250 5250
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5850 5250 6250 5250
Wire Wire Line
	4000 5450 4850 5450
Wire Wire Line
	4850 5450 4850 5350
Wire Wire Line
	4850 5350 5350 5350
Text Notes 5250 5350 0    60   ~ 0
R2
Text GLabel 4200 5550 2    60   Input ~ 0
G2
Text GLabel 6050 5350 2    60   Input ~ 0
G2
Wire Wire Line
	5850 5350 6050 5350
Wire Wire Line
	4000 5550 4200 5550
Wire Wire Line
	4000 5650 5000 5650
Wire Wire Line
	5000 5650 5000 5450
Wire Wire Line
	5000 5450 5350 5450
Text Notes 5250 5450 0    60   ~ 0
B2
$Comp
L GND #PWR?
U 1 1 57BAF56E
P 6250 5450
F 0 "#PWR?" H 6250 5200 50  0001 C CNN
F 1 "GND" H 6250 5300 50  0000 C CNN
F 2 "" H 6250 5450 50  0000 C CNN
F 3 "" H 6250 5450 50  0000 C CNN
	1    6250 5450
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5850 5450 6250 5450
Text GLabel 5250 5550 0    60   Input ~ 0
A
Wire Wire Line
	5250 5550 5350 5550
Text GLabel 1950 3050 0    60   Output ~ 0
A
Wire Wire Line
	2100 3050 1950 3050
Text GLabel 6050 5550 2    60   Input ~ 0
B
Wire Wire Line
	5850 5550 6050 5550
Text GLabel 1950 3150 0    60   Output ~ 0
B
Wire Wire Line
	1950 3150 2100 3150
Text GLabel 6050 5650 2    60   Input ~ 0
D
Wire Wire Line
	6050 5650 5850 5650
Text GLabel 5250 5650 0    60   Input ~ 0
C
Wire Wire Line
	5250 5650 5350 5650
Text GLabel 1950 3250 0    60   Output ~ 0
C
Text GLabel 1950 3350 0    60   Output ~ 0
D
Wire Wire Line
	1950 3250 2100 3250
Wire Wire Line
	1950 3350 2100 3350
$Comp
L GND #PWR?
U 1 1 57BB03A8
P 6250 5850
F 0 "#PWR?" H 6250 5600 50  0001 C CNN
F 1 "GND" H 6250 5700 50  0000 C CNN
F 2 "" H 6250 5850 50  0000 C CNN
F 3 "" H 6250 5850 50  0000 C CNN
	1    6250 5850
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5850 5850 6250 5850
Text GLabel 5250 5850 0    60   Input ~ 0
OE
Wire Wire Line
	5250 5850 5350 5850
Text GLabel 4150 2550 2    60   Output ~ 0
OE
Wire Wire Line
	4000 2550 4150 2550
Text GLabel 5250 5750 0    60   Input ~ 0
CLK
Wire Wire Line
	5250 5750 5350 5750
Text GLabel 4150 2350 2    60   Output ~ 0
CLK
Wire Wire Line
	4000 2350 4150 2350
Text GLabel 6050 5750 2    60   Input ~ 0
LAT
Wire Wire Line
	5850 5750 6050 5750
Text GLabel 4150 2450 2    60   Output ~ 0
LAT
Wire Wire Line
	4000 2450 4150 2450
Text Notes 8100 7500 0    60   ~ 0
TT Display with RGB Matrix
$EndSCHEMATC
