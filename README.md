# TableTennisDisplay
Display for counting Table Tennis Matches

## Components of the Display

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

* Small OLED Display sdd1306 for umpire feedback and guidance

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

* Join a existing Wifi or make a own AP
* Enter left and right player at game start
* Which side serves first

### Menu after long button press
* Number of games to play:
 * default: 3 games of 5
 * 2 of 3
 * 4 of 7
 * 5 of 9
* LED Brightness
