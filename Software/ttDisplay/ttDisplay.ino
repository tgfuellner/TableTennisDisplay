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
#include <Fonts/FreeSans9pt7b.h>
#include <OneButton.h>

#define OLED_RESET -1
Adafruit_SSD1306 display(OLED_RESET);

#if (SSD1306_LCDHEIGHT != 64)
#error("Height incorrect, please fix Adafruit_SSD1306.h!");
#endif

OneButton buttonRight(D3, true); // second Parameter true means active Low with internal Pullup
OneButton buttonLeft(D4, true);

boolean leftStartetToServe;
int gamesNeededToWinMatch;

void gameOverSwapSide();
void startCount();

class ScoreOneSide {
    public:
    int games;
    int points;
    ScoreOneSide *otherSide;

    boolean winsGame() {
        if (points > 10 && points - otherSide->points > 1)
            return true;
        return false;
    }

    void handleGameDecision() {
        if (winsGame()) {
            games++;
        } else if (otherSide->winsGame()) {
            otherSide->games++;
        } else {
            return;
        }

        display.setFont(NULL);
        display.setCursor(10,55);
        display.print("Taste lang halten");
        buttonLeft.attachLongPressStart(gameOverSwapSide);
        buttonRight.attachLongPressStart(gameOverSwapSide);
    }
};

void showServer(boolean isLeft) {
  if (isLeft) {
    display.drawFastVLine(0, 0, 64, 1);
    display.drawFastVLine(127, 0, 64, 0);
  } else {
    display.drawFastVLine(0, 0, 64, 0);
    display.drawFastVLine(127, 0, 64, 1);
  }
  display.display();
}

class Score {
    public:
    ScoreOneSide left;
    ScoreOneSide right;

    Score() {
        left.otherSide = &right;
        right.otherSide = &left;
    }

    void gameOverSwapSide() {
        int games = left.games;
        left.games = right.games;
        right.games = games;
        left.points = 0;
        right.points = 0;
        display.clearDisplay();
        showScore();
    }

    boolean leftHasToServe() {
        int player;
        int sumOfPoints = left.points + right.points;
        if (sumOfPoints < 20) 
            // First player if even
            player = int(sumOfPoints / 2) % 2;
        else
            player = sumOfPoints % 2;

        // Every other game server changes
        player = player + left.games+right.games - 1;
        if (leftStartetToServe) 
            return player%2;
        else
            return !player%2;
    }

    void showScore() {
        display.setFont(&FreeSans24pt7b);
        
        if (left.points < 10)
          display.setCursor(31,32);
        else
          display.setCursor(5,32);

        display.print(left.points);
        display.print(':');
        display.print(right.points);

        // Games in a smaller font
        display.setFont(&FreeSans12pt7b);
        display.setCursor(2,50);
        display.print(left.games);
        display.setCursor(113,50);
        display.print(right.games);

        showServer(leftHasToServe());

        display.display();
    }

    void count(ScoreOneSide &side, int n=1) {
        if (side.points == 0 && n <= 0)
             return;  // No negative points

        if (side.winsGame() && n<0)
            side.games--;

        side.points += n;

        display.clearDisplay();
        side.handleGameDecision();
        showScore();
    }
};

Score theScore;

void showSetupMenu() {
  display.setCursor(3,55);
  display.print("Ok");
  display.setCursor(43,55);
  display.print("Wechseln");
}

void showNumberOfGames(int gamesNeededToWinMatch) {
  static char*menuTexts[] = {"1 von 1?", "2 von 3?", "3 von 5?",
                             "4 von 7?", "5 von 9?"};
  display.clearDisplay();
  display.setCursor(3,15);
  display.print(menuTexts[gamesNeededToWinMatch-1]);
  display.setTextColor(WHITE);

  showSetupMenu();
  display.display();
}

void changeNumberOfGames() {
  gamesNeededToWinMatch++;
  if (gamesNeededToWinMatch > 5)
      gamesNeededToWinMatch = 1;
  showNumberOfGames(gamesNeededToWinMatch);
}

void numberOfGamesSetup() {
  gamesNeededToWinMatch = 3;
  showNumberOfGames(gamesNeededToWinMatch);
  buttonLeft.attachClick(startCount);
  buttonRight.attachClick(changeNumberOfGames);
}

void changeServer() {
  leftStartetToServe = !leftStartetToServe;
  showServer(leftStartetToServe);
}

void serverSetup() {
  display.clearDisplay();
  leftStartetToServe = true;
  showServer(leftStartetToServe);
  display.setTextColor(WHITE);
  display.setFont(&FreeSans9pt7b);
  display.setCursor(3,15);
  display.print("Aufschlag?");

  showSetupMenu();
  display.display();

  buttonLeft.attachClick(numberOfGamesSetup);
  buttonRight.attachClick(changeServer);
}



void noLongPressAction() {
  buttonLeft.attachLongPressStart(NULL);
  buttonRight.attachLongPressStart(NULL);
}

void clickRight() {
  noLongPressAction();
  theScore.count(theScore.right);
}
void clickLeft() {
  noLongPressAction();
  theScore.count(theScore.left);
}
void dclickRight() {
  noLongPressAction();
  theScore.count(theScore.right, -1);
}
void dclickLeft() {
  noLongPressAction();
  theScore.count(theScore.left, -1);
}
void gameOverSwapSide() {
  noLongPressAction();
  theScore.gameOverSwapSide();
}

void startCount() {
  display.clearDisplay();
  display.setTextColor(WHITE);
  theScore.showScore();

  buttonRight.attachClick(clickRight);
  buttonLeft.attachClick(clickLeft);
  buttonRight.attachDoubleClick(dclickRight);
  buttonLeft.attachDoubleClick(dclickLeft);
}


void setup()   {                
  //Serial.begin(9600);

  // by default, we'll generate the high voltage from the 3.3v line internally! (neat!)
  display.begin(SSD1306_SWITCHCAPVCC, 0x3C);  // initialize with the I2C addr 0x3D (for the 128x64)
  // init done
  

  // text display tests
  display.setTextSize(1);

  buttonRight.setClickTicks(300);
  buttonLeft.setClickTicks(300);

  // Start Options
  serverSetup();  // Button Method calls:
     // numberOfGamesSetup() which calls:
     // startCount()

}

void loop() {
    buttonRight.tick();
    buttonLeft.tick();
    delay(10);
}


