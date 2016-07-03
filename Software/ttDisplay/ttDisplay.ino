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

// Configured at startup:
boolean leftStartetToServe;
int gamesNeededToWinMatch;

// The Result:
const int MAX_GAMES = 9;
const int END_MARK = -1000;

// Only points of Loser are stored
// If the player which startet to Serve wins, we habe positive values
// otherwise negative.
// 11:4 ==> 4
// 8:11 ==> -8
// 14:12 ==> 12
int resultPlayerStartetToServe[MAX_GAMES+1];

void gameOverSwapSide();
void lastGameSwapSide();
void startCount();
void showResult();

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

class ScoreOneSide {
    public:
    int games;
    int points;
    ScoreOneSide *otherSide;

    boolean winsGame() {
        if (points > 10 && otherSide->points > 9 && points - otherSide->points == 2)
            return true;
        if (points == 11 && otherSide->points <= 9)
            return true;

        return false;
    }

};

class Score {
    public:
    ScoreOneSide left;
    ScoreOneSide right;
    boolean sideChanged = false;

    Score() {
        left.otherSide = &right;
        right.otherSide = &left;
    }

    void incrGames() {
        if (left.winsGame())
            left.games++;
        else
            right.games++;
    }

    void storeResult() {
        int totalPlayedGames = left.games + right.games;

        resultPlayerStartetToServe[totalPlayedGames] = 
                    (left.points > right.points) ? right.points : -left.points;

        if (!leftStartetToServe)
            resultPlayerStartetToServe[totalPlayedGames] *= -1;

        if (sideChanged)
            resultPlayerStartetToServe[totalPlayedGames] *= -1;

        if (totalPlayedGames % 2 == 1)
            resultPlayerStartetToServe[totalPlayedGames] *= -1;

        // Mark end of result:
        resultPlayerStartetToServe[totalPlayedGames+1] = END_MARK;
        resultPlayerStartetToServe[totalPlayedGames+1] = END_MARK;
    }

    void gameOverSwapSide() {
        storeResult();
        incrGames();
        int games = left.games;
        left.games = right.games;
        right.games = games;
        left.points = 0;
        right.points = 0;
        display.clearDisplay();
        showScore();
    }

    void lastGameSwapSide() {
        int tmp = left.games;

        left.games = right.games;
        right.games = tmp;

        tmp = left.points;
        left.points = right.points;
        right.points = tmp;

        sideChanged = true;

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

        if (leftStartetToServe && !sideChanged) 
            return !player%2;
        else
            return player%2;
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

    void showLongPressMenu(char *message) {
        display.setFont(NULL);
        display.setCursor(25,45);
        display.print(message);
        display.setCursor(10,55);
        display.print("Taste lang halten");
    }

    boolean isLastPossibleGame() {
        if (left.games + right.games == gamesNeededToWinMatch*2 - 2)
            return true;

        return false;
    }

    boolean isLastGame() {
        if (left.winsGame() && left.games == gamesNeededToWinMatch-1)
            return true;
        if (right.winsGame() && right.games == gamesNeededToWinMatch-1)
            return true;

        return false;
    }

    void handleGameDecision() {
        if (left.winsGame() || right.winsGame()) {
            if (isLastGame()) {
                showLongPressMenu("   Fertig");
                buttonLeft.attachLongPressStart(showResult);
                buttonRight.attachLongPressStart(showResult);
                return;
            }

            showLongPressMenu("Seitenwechsel");
            buttonLeft.attachLongPressStart(::gameOverSwapSide);
            buttonRight.attachLongPressStart(::gameOverSwapSide);
            return;
        }

        if (isLastPossibleGame() && (left.points >= 5 || right.points >=5) && !sideChanged ) {
            showLongPressMenu("Seitenwechsel");
            buttonLeft.attachLongPressStart(::lastGameSwapSide);
            buttonRight.attachLongPressStart(::lastGameSwapSide);
            return;
        }
    }

    void count(ScoreOneSide &side, int n=1) {
        if (side.points == 0 && n <= 0)
             return;  // No negative points

        if (side.winsGame() && n>0)
            n = 0;

        side.points += n;

        display.clearDisplay();
        handleGameDecision();
        showScore();
    }
};

Score theScore;

void showExpandedPoints(int r) {
  if (r > 0) {
      display.print((r>9) ? r+2 : 11);
      display.print(":");
      display.print(r);
  } else {
      r *= -1;
      display.print(r);
      display.print(":");
      display.print((r>9) ? r+2 : 11);
  }
}

void showResult() {
  theScore.storeResult();
  display.clearDisplay();
  display.setFont(&FreeSans9pt7b);
  display.setCursor(0,15);
  if (theScore.left.games+theScore.right.games > 6) {
      for (int i=0; resultPlayerStartetToServe[i] != END_MARK; i++) {
          if (i>0 && i%3 == 0) 
              display.print(",\n");
          display.print(resultPlayerStartetToServe[i]);
          if (resultPlayerStartetToServe[i+1] != END_MARK) 
              display.print(", ");
      }
  } else {
      for (int i=0; resultPlayerStartetToServe[i] != END_MARK; i++) {
          if (i>0 && i%2 == 0) 
              display.print("\n");
          showExpandedPoints(resultPlayerStartetToServe[i]);
          if (resultPlayerStartetToServe[i+1] != END_MARK) 
              display.print(", ");
      }
  }
  display.display();
}


#define OK "Ok"
#define OKx 3
#define OKy 55
#define WE "Wechsel"
#define WEx 47
#define WEy 55

void showSetupMenu() {
  int16_t x,y;
  uint16_t w,h;

  display.getTextBounds(OK,OKx,OKy,&x,&y,&w,&h);
  display.drawRect(x-2,y-2,w+4,h+4,WHITE);
  display.setCursor(OKx,OKy);
  display.print(OK);
  display.getTextBounds(WE,WEx,WEy,&x,&y,&w,&h);
  display.drawRect(x-2,y-2,w+4,h+4,WHITE);
  display.setCursor(WEx,WEy);
  display.print(WE);
}

void showNumberOfGames(int gamesNeededToWinMatch) {
  static char*menuTexts[] = {"1 von 1?", "2 von 3?", "3 von 5?",
                             "4 von 7?", "5 von 9?"};
  display.clearDisplay();
  display.setCursor(3,15);
  display.print(menuTexts[gamesNeededToWinMatch-1]);

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
  buttonLeft.attachClick(serverSetup);
  buttonRight.attachClick(changeNumberOfGames);
}

void changeServer() {
  leftStartetToServe = !leftStartetToServe;
  showServer(leftStartetToServe);
}

void serverSetup() {
  display.clearDisplay();
  showServer(leftStartetToServe);
  display.setCursor(3,15);
  display.print("Aufschlag?");
  showSetupMenu();
  display.display();

  buttonLeft.attachClick(startCount);
  buttonRight.attachClick(changeServer);
}

void optionSetup() {
  display.clearDisplay();
  leftStartetToServe = true;
  display.setFont(&FreeSans9pt7b);

  numberOfGamesSetup();
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
void lastGameSwapSide() {
    noLongPressAction();
    theScore.lastGameSwapSide();
}

void startCount() {
  display.clearDisplay();
  theScore.showScore();

  buttonRight.attachClick(clickRight);
  buttonLeft.attachClick(clickLeft);
  buttonRight.attachDoubleClick(dclickRight);
  buttonLeft.attachDoubleClick(dclickLeft);
}


void setup()   {                
  //Serial.begin(9600);  Serial.println("Start");

  // by default, we'll generate the high voltage from the 3.3v line internally! (neat!)
  display.begin(SSD1306_SWITCHCAPVCC, 0x3C);  // initialize with the I2C addr 0x3D (for the 128x64)
  // init done
  

  // text display tests
  display.setTextSize(1);
  display.setTextColor(WHITE);

  buttonRight.setClickTicks(300);
  buttonLeft.setClickTicks(300);

  // Start Options
  optionSetup();  // Button Method calls:
     // numberOfGamesSetup() which calls:
     // startCount()

}

void loop() {
    buttonRight.tick();
    buttonLeft.tick();
    delay(10);
}


