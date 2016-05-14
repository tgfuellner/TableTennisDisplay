# TableTennisDisplay
Display for counting Table Tennis Matches

## Components of the Display

* Attiny2313 
 * controls the 6 seven segment digits
 * Receives data from esp8266
 * Runs with 3.3V

* esp8266
 * Send data to Attiny
 * queries state of the buttons
 * Can be controled by mobile phone (mqtt or http)
 * implements counting behavieour
 * Runs with 3.3V

* Powered by 12V Lead Acid Battery

* DC-DC Converter for 3.3V

* DC-DC Converter for 9V  (Needed by seven segment digits)

## Counting behaviour

* Game is won with 2 points difference and with more than 10 points
* Indicate who has to serve - changes every 2 points or every 1 point if a player has more than 10 points

