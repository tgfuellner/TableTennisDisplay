/*********************************************************************
Table Tennis Score Board

Written by Thomas Gfüllner
BSD license
All text above, and the splash screen must be included in any redistribution
*********************************************************************/

#include <SPI.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include <Fonts/FreeSans24pt7b.h>
#include <Fonts/FreeSans12pt7b.h>
#include <OneButton.h>

#define OLED_RESET -1
Adafruit_SSD1306 display(OLED_RESET);

#if (SSD1306_LCDHEIGHT != 64)
#error("Height incorrect, please fix Adafruit_SSD1306.h!");
#endif

OneButton buttonRight(D3, true); // second Parameter true means active Low with internal Pullup
OneButton buttomLeft(D4, true);

boolean leftStartetToServe = true;

class Score {
    int gamesLeft;
    int gamesRight;
    int pointsLeft;
    int pointsRight;

    public: Score() {
    }

    boolean leftHasToServe() {
        int player;
        int sumOfPoints = pointsRight + pointsLeft;
        if (sumOfPoints < 20) 
            // First player if even
            player = int(sumOfPoints / 2) % 2;
        else
            player = sumOfPoints % 2;

        // Every other game server changes
        player = player + gamesRight+gamesLeft - 1;
        if (leftStartetToServe) 
            return player%2;
        else
            return !player%2;
    }

    void showScore() {
        display.clearDisplay();
        display.setFont(&FreeSans24pt7b);
        
        if (pointsLeft < 10)
          display.setCursor(31,32);
        else
          display.setCursor(5,32);

        display.print(pointsLeft);
        display.print(':');
        display.print(pointsRight);

        // Games in a smaller font
        display.setFont(&FreeSans12pt7b);
        display.setCursor(0,50);
        display.print(gamesLeft);
        display.setCursor(115,50);
        display.print(gamesRight);

        // Indicate who has to serve
        if (leftHasToServe())
            display.drawFastVLine(0, 0, 64, 1);
        else
            display.drawFastVLine(127, 0, 64, 1);

        display.display();
    }

    void leftCount(int n=1) {
        pointsLeft += n;
        showScore();
    }
    void rightCount(int n=1) {
        pointsRight += n;
        showScore();
    }
};

Score theScore;

void clickRight() {
  theScore.rightCount();
}
void clickLeft() {
  theScore.leftCount();
}
void dclickRight() {
  theScore.rightCount(-1);
}
void dclickLeft() {
  theScore.leftCount(-1);
}

void setup()   {                
  Serial.begin(9600);

  // by default, we'll generate the high voltage from the 3.3v line internally! (neat!)
  display.begin(SSD1306_SWITCHCAPVCC, 0x3C);  // initialize with the I2C addr 0x3D (for the 128x64)
  // init done
  
  // Clear the buffer.
  display.clearDisplay();

  // text display tests
  display.setTextSize(1);
  display.setTextColor(WHITE);
  theScore.showScore();

  buttonRight.attachClick(clickRight);
  buttomLeft.attachClick(clickLeft);
  buttonRight.attachDoubleClick(dclickRight);
  buttomLeft.attachDoubleClick(dclickLeft);
  buttonRight.setClickTicks(300);
  buttomLeft.setClickTicks(300);
}

void loop() {
    buttonRight.tick();
    buttomLeft.tick();
    delay(10);
}


