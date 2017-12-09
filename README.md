# TableTennisDisplay
Display for counting Table Tennis Matches

## Components of the Display for Version 1 with 7-Segment LEDs

* esp8266 (Wemos D1 mini)
 * Send data to LED Driver Shift Register TLC5916IN 
 * queries state of the buttons
 * controlls the OLED display
 * Can be controled by mobile phone (mqtt or http)
 * implements counting behavieour
 * Runs with 3.3V

* Powered by 12V Lead Acid Battery

* DC-DC Converter for 3.3V

* Seven Segment Displays
 * 4 Big red LED common anode for the points
 * 2 smaller green LED common kathode for the games

* LED Driver Shift Register TLC5916IN 
 * [Datasheet](http://docs-europe.electrocomponents.com/webdocs/12f7/0900766b812f7b59.pdf)

* Small OLED Display ssd1306 for umpire feedback and guidance

## Components of the Display for Version 2 with Hub75 64x32 RGB Matrix

* esp8266 (Wemos D1 mini)
 * Send data to RGB Matrix over i2c to HUB75 Controler
 * queries state of the buttons
 * controlls the OLED display
 * implements counting behavieour
 * Runs with 3.3V

* Powered by Stock 5V USB Powerbank

* HUB75 64x32 RGB Matrix

* HUB75 Controler: Arduino Mega

* Small OLED Display ssd1306 for umpire feedback and guidance

## Components of the Display for Version 3 with Hub75 64x32 RGB Matrix

* esp8266 (Wemos D1 mini)
 * Send data to RGB Matrix over i2c to HUB75 Controler
 * queries state of the buttons
 * controlls the OLED display
 * implements counting behavieour
 * Runs with 3.3V

* Powered by Stock 5V USB Powerbank

* HUB75 64x32 RGB Matrix

* HUB75 Controler: Custom made Atmega128 board
 * See https://easyeda.com/thomas.gfuellner/TTDisplay64x32-LDrpmkwus

* Small OLED Display ssd1306 for umpire feedback and guidance

## Counting behaviour

* Game is won with 2 points difference and with more than 10 points
* Indicate who has to serve - changes every 2 points or every 1 point if a player has more than 10 points
* Recognise game won
 * write message on OLED
 * increase game count
 * after Button press: reset points and swap game display digits
* In the last game: swap side if one player reaches 5 points
 * write message to OLED
 * do swaping after pressing of a button 

## Setup
### Menu right after powering the display on

* Hold back button on Power on: Join a existing Wifi or make a own AP
* Which side serves first

### Menu after long button press
* Number of games to play:
 * default: 3 games of 5
 * 2 of 3
 * 4 of 7
 * 5 of 9
* LED Brightness

## HTTP
### Remote control over Wifi

* Press an hold right back button an power the Display on
* Choose own Network not connected to internet
* Join the Wifi Network created by the Display
 * The Name is e.g. TTDisplay3
 * Ip of Display is 192.168.4.1
* There are following actions:
 * http://192.168.4.1:8080/
 * http://192.168.4.1:8080/incrRight
 * http://192.168.4.1:8080/incrLeft
 * http://192.168.4.1:8080/decrRight
 * http://192.168.4.1:8080/decrLeft
 * http://192.168.4.1:8080/finishGame
 * http://192.168.4.1:8080/swapSide
 * http://192.168.4.1:8080/count
 * http://192.168.4.1:8080/reset
 * http://192.168.4.1:8080/rightServe
 * http://192.168.4.1:8080/leftServe
 * http://192.168.4.1:8080/setNames


