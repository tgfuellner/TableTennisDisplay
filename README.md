# TableTennisDisplay
Display for counting Table Tennis Matches

## Components of the Display

* Attiny2313 
 * controlls the 6 seven segment digits
 * Receives data from esp8266
 * Runs with 3.3V

* esp8266
 * Send data to Attiny
 * queries state of the buttons
 * controlls the OLED display
 * Can be controled by mobile phone (mqtt or http)
 * implements counting behavieour
 * Runs with 3.3V

* Powered by 12V Lead Acid Battery

* DC-DC Converter for 3.3V

* DC-DC Converter for 9V  (Needed by seven segment digits)

* Seven Segment Displays
 * 4 Big red LED common anode for the points
 * 2 smaller green LED common kathode for the games

* Small OLED Display for feedback and guidance for the umpire

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

* Setup menu right after powering the display on
* default: 3 games of 5
* 2 of 3
* 4 of 7
* 5 of 9
