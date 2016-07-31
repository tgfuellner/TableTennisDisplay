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

#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <DNSServer.h>
#include <ESP8266WebServer.h>
#include <WiFiManager.h>          //https://github.com/tzapu/WiFiManager
#include <ESP8266HTTPClient.h>
#include <Ticker.h>

#define Sprintln(a)
// #define Sprintln(a) (Serial.println(a))
#define Sprintf(...)
// #define Sprintf(format, ...) (Serial.printf(format, __VA_ARGS__))

const char* ssid = "TTDisplay1";
const char* password = "12345678";  // set to "" for open access point w/o passwortd

HTTPClient http;

Ticker timer;

#define OLED_RESET -1
Adafruit_SSD1306 display(OLED_RESET);

#if (SSD1306_LCDHEIGHT != 64)
#error("Height incorrect, please fix Adafruit_SSD1306.h!");
#endif

class Buttons {
    public:

    // Wifi dont start if D3 (GPIO0) is used
    // before Wifi setup
    OneButton buttonRight;
    OneButton buttonLeft;
                                // second Parameter true means active Low with internal Pullup
    Buttons() : buttonRight(D3, true), buttonLeft(D4, true) {
        // D3 and D4 on Wemos have external Pullup
        digitalWrite(D3, LOW);   // turn off pullUp resistor
        digitalWrite(D4, LOW);   // turn off pullUp resistor
        buttonRight.setClickTicks(250);
        buttonLeft.setClickTicks(250);
    }

    void noButtonsCommands() {
        buttonRight.attachClick(NULL);
        buttonLeft.attachClick(NULL);
        buttonRight.attachDoubleClick(NULL);
        buttonLeft.attachDoubleClick(NULL);
    }
};

Buttons *b;
ESP8266WebServer *server=NULL;

// Config of Shiftregister/LED driver TLC5916
const int TLC_OE = D8;
const int TLC_CLK = D5;
const int TLC_SDI = D6;
const int TLC_LE = D7;

/*Segments
    - a -
   |     |
   f     b
   |     |
    - g -
   |     |
   e     c
   |     |
    - d -   dp
    
 Bit-order for shift register:
  a b f g e d dp c
*/

//                   abfgedpc
const byte zero  = 0b11101101;
const byte one   = 0b01000001;
const byte two   = 0b11011100;
const byte three = 0b11010101;
const byte four  = 0b01110001;
const byte five  = 0b10110101;
//                   abfgedpc
const byte six   = 0b10111101;
const byte seven = 0b11000001;
const byte eight = 0b11111101;
const byte nine  = 0b11110101;
const byte minus = 0b00010000;
const byte dot   = 0b00000010;



// Configured at startup:
boolean leftStartetToServe = true;
int gamesNeededToWinMatch = 3;
int brightness = 2;   // 50%
bool wantToJoinNetwork = true;
IPAddress ip;

// The Result:
const int MAX_GAMES = 9;
const int ZERO_RESULT = 19999;
const int END_MARK = -20000;

String nameOfPlayerWhoStartedLeft("LeftStarter");
String nameOfPlayerWhoStartedRight("RightStarter");

// Only points of Loser are stored
// If the player which startet to Serve wins, we habe positive values
// otherwise negative.
// 11:4 ==> 4
// 8:11 ==> -8
// 14:12 ==> 12
// 0:11 ==> -0
int resultPlayerStartetToServe[MAX_GAMES+1] = {END_MARK};

void gameOverSwapSide();
void lastGameSwapSide();
void startCount();
void showResult();
void serverSetup();
void setLEDCurrent(byte configCode);

String getRes(int res) {
    if (res == ZERO_RESULT) {
        return "0";
    }
    if (res == -ZERO_RESULT) {
        return "-0";
    }
    return String(res);
}

String urlencode(String str)
{
    String encodedString="";
    char c;
    char code0;
    char code1;
    char code2;
    Sprintln(String("urlencode org:")+str);
    for (int i =0; i < str.length(); i++){
      c=str.charAt(i);
      Sprintln(int(c));
      if (c == ' '){
        encodedString+= '+';
      } else if (isalnum(c) 
            || c==0xfc || c==0xf6 || c==0xe4 || c==0xdf // ü,ö,ä,ß
            || c==0xC4 || c==0xDC || c==0xD6) {  // Ä,Ü,Ö
        encodedString+=c;
      } else{
        code1=(c & 0xf)+'0';
        if ((c & 0xf) >9){
            code1=(c & 0xf) - 10 + 'A';
        }
        c=(c>>4)&0xf;
        code0=c+'0';
        if (c > 9){
            code0=c - 10 + 'A';
        }
        code2='\0';
        encodedString+='%';
        encodedString+=code0;
        encodedString+=code1;
        //encodedString+=code2;
      }
      yield();
    }
    Sprintln(encodedString);
    return encodedString;
    
}

unsigned char h2int(char c)
{
    if (c >= '0' && c <='9'){
        return((unsigned char)c - '0');
    }
    if (c >= 'a' && c <='f'){
        return((unsigned char)c - 'a' + 10);
    }
    if (c >= 'A' && c <='F'){
        return((unsigned char)c - 'A' + 10);
    }
    return(0);
}


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

void writeLEDTenner(int number, bool wantDot) {
    number = number / 10;
    if (number == 0) {
      byte dotMask = 0;
      if (wantDot) {
          dotMask = dot;
      }
      shiftOut(TLC_SDI, TLC_CLK, MSBFIRST, 0b00000000|dotMask);
      return;
    }
    writeLEDDigit(number, wantDot);
}
void writeLEDDigit(int number, bool wantDot) {
    if (number < 0 || number > 9) {
      shiftOut(TLC_SDI, TLC_CLK, MSBFIRST, minus);
      return;
    }

    const static byte digits[] = {zero, one, two, three, four, five, six, seven, eight, nine};
    byte dotMask = 0;
    if (wantDot) {
        dotMask = dot;
    }
    shiftOut(TLC_SDI, TLC_CLK, MSBFIRST, digits[number]|dotMask);
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

    bool playersAreOnTheSideWhereTheyStarted() {
        int totalPlayedGames = left.games + right.games;

        return (totalPlayedGames % 2 == 0 && !sideChanged);
    }

    void storeResult() {
        int totalPlayedGames = left.games + right.games;
        int points = (left.points > right.points) ? right.points : -left.points;
        if (points == 0) {
            points = ZERO_RESULT;
        }

        if (!leftStartetToServe)
            points *= -1;

        if (sideChanged)
            points *= -1;

        if (totalPlayedGames % 2 == 0)
            points *= -1;

        resultPlayerStartetToServe[totalPlayedGames] = points;
        Sprintf("resultPlayerStartetToServe[%d] = %d\n", totalPlayedGames, points);
        // Mark end of result:
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


    void showScoreOnLEDs() {

        digitalWrite(TLC_LE, LOW);
        bool leftServe = leftHasToServe();

        writeLEDDigit(left.games, leftServe);
        writeLEDDigit(left.points%10, leftServe);
        writeLEDTenner(left.points, false);
        yield();
        writeLEDDigit(right.points%10, false);
        writeLEDTenner(right.points, !leftServe);
        writeLEDDigit(right.games, !leftServe);

        delay(20);
        digitalWrite(TLC_LE, HIGH);
    }

    String getCurentResult(bool matchIsFinished) {
        String result;
        for (int i=0; resultPlayerStartetToServe[i] != END_MARK; i++) {
            result += getRes(resultPlayerStartetToServe[i]);
            result += ' ';
        }

        if (matchIsFinished) {
            return result;
        }

        if (playersAreOnTheSideWhereTheyStarted()) {
            return result + left.points + ":" + right.points;
        } else {
            return result + right.points + ":" + left.points;
        }
    }

    void indicateSending(bool isSending) {
        if (isSending) {
            const int16_t x=40, y=43;
            int16_t xlu, ylu;
            uint16_t w, h;
            const char* msg = "Sende ..";

            display.setFont(NULL);
            display.setCursor(x,y);
            display.getTextBounds((char *)msg,x,y,&xlu,&ylu,&w,&h);
            w = 5 * (2+strlen(msg));  // Bug in getTextBounds()
            display.fillRect(xlu-2,ylu-2,w+4,h+4,BLACK);
            yield();
            display.drawRect(xlu-3,ylu-3,w+6,h+6,WHITE);
            display.print(msg);
            display.display();
        } else {
            showScoreOnOled();
        }
    }

    void dweetScore(bool matchIsFinished=false) {
        if (WiFi.status() == WL_CONNECTED) {
            if (!matchIsFinished) indicateSending(true);

            const int httpPort = 80;
            const char * host = "54.175.118.28"; // http://dweet.io/

            String base("/dweet/for/");
            String uri = base+ssid+"?score="+ssid
                            +urlencode(String("<br><b>"+nameOfPlayerWhoStartedLeft+" - "
                                                       +nameOfPlayerWhoStartedRight+"</b><br/>"
                                                       +getCurentResult(matchIsFinished)));
            Sprintln(String("http://")+host+uri);

            http.begin(host, httpPort, uri);
            int httpCode = http.GET();
            if(httpCode > 0) {
                /*
                Sprintf("[HTTP] GET... code: %d\n", httpCode);

                if(httpCode == HTTP_CODE_OK) {
                    http.writeToStream(&Serial);
                    Sprintln();
                }
                */
            } else {
                Sprintf("[HTTP] GET... failed, error: %s\n", http.errorToString(httpCode).c_str());
            }

            http.end();

           if (!matchIsFinished) indicateSending(false);
        }
    }

    void showBattery() {
        display.setFont(NULL);
        display.setCursor(2,56);
        int batVal = analogRead(A0);
        double voltage = map(batVal, 685, 1024, 100, 149) / 10.0;

        // Alternate Bat Status and Bat Voltage
        // avoid collision with oder Message
        if ((left.points+right.points) % 2 == 1 
            && left.points < 11 && right.points < 11
            && !isLastPossibleGame()) {
            if (voltage < 11.3) {
                display.print("Bat leer");
            } else if (voltage > 12.7) {
                display.print("Bat voll");
            } else  {
                display.print("Bat Ok");
            }
        } else {
            display.print(voltage, 1);
            display.print("V");
        }

        // For Voltage calibration
        //display.print(batVal);
    }

    void showScoreOnOled() {
        display.clearDisplay();
        handleGameDecision();
        yield();
        display.setFont(&FreeSans24pt7b);
        
        if (left.points < 10)
          display.setCursor(31,32);
        else
          display.setCursor(5,32);

        display.print(left.points);
        display.print(':');
        display.print(right.points);

        yield();

        showBattery();

        // Games in a smaller font
        display.setFont(&FreeSans12pt7b);
        display.setCursor(2,50);
        display.print(left.games);
        display.setCursor(113,50);
        display.print(right.games);

        showServer(leftHasToServe());

        display.display();
    }

    void showScore() {
        showScoreOnOled();
        yield();

        showScoreOnLEDs();
        dweetScore();
    }

    void showLongPressMenu(char *message) {
        display.setFont(NULL);
        display.setCursor(25,45);
        display.print(message);
        display.setCursor(40,55);
        display.print("Taste halten");
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
                b->buttonLeft.attachLongPressStart(showResult);
                b->buttonRight.attachLongPressStart(showResult);
                return;
            }

            showLongPressMenu("Seitenwechsel");
            b->buttonLeft.attachLongPressStart(::gameOverSwapSide);
            b->buttonRight.attachLongPressStart(::gameOverSwapSide);
            return;
        }

        if (isLastPossibleGame() && (left.points >= 5 || right.points >=5) && !sideChanged ) {
            showLongPressMenu("Seitenwechsel");
            b->buttonLeft.attachLongPressStart(::lastGameSwapSide);
            b->buttonRight.attachLongPressStart(::lastGameSwapSide);
            return;
        }
    }

    void count(ScoreOneSide &side, int n=1) {
        if (side.points == 0 && n <= 0)
             return;  // No negative points

        if (side.winsGame() && n>0)
            n = 0;

        side.points += n;

        showScore();
    }
};

Score theScore;

void showExpandedPoints(int r) {
  if (r > 0) {
      r = (r==ZERO_RESULT) ? 0:r;
      display.print((r>9) ? r+2 : 11);
      display.print(":");
      display.print(r);
  } else {
      r *= -1;
      r = (r==ZERO_RESULT) ? 0:r;
      display.print(r);
      display.print(":");
      display.print((r>9) ? r+2 : 11);
  }
}

void showResult() {
  b->noButtonsCommands();
  theScore.sideChanged = false;
  theScore.storeResult();
  
  display.clearDisplay();
  display.setFont(&FreeSans9pt7b);
  display.setCursor(0,15);
  if (theScore.left.games+theScore.right.games > 6) {
      for (int i=0; resultPlayerStartetToServe[i] != END_MARK; i++) {
          if (i>0 && i%3 == 0) 
              display.print(",\n");
          display.print(getRes(resultPlayerStartetToServe[i]));
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
  theScore.dweetScore(true);
}

void handleRoot() {
	server->send(200, "text/html", nameOfPlayerWhoStartedLeft + " - " + nameOfPlayerWhoStartedRight
            + "<font size=\"+2\">" + theScore.getCurentResult(false) +"</font>");
}

void handleSetNames() {
    nameOfPlayerWhoStartedLeft = server->arg("left");
    Sprintln(String("Name==")+nameOfPlayerWhoStartedLeft);
    nameOfPlayerWhoStartedRight = server->arg("right");

    String html= R"(<html><head><meta http-equiv="Content-Type" content="text/html;charset=iso-8859-1"></head><body>)";

    if (nameOfPlayerWhoStartedLeft.length() > 0 && nameOfPlayerWhoStartedRight.length() > 0) {
      html += String("<h2>Diese Namen wurden eingetragen:</h2><p>")
             +"Linker Spieler: "+nameOfPlayerWhoStartedLeft
             +"<br/>Rechter Spieler: "+nameOfPlayerWhoStartedRight+"</p><hr/>";
    }

    html += R"====(
<h2>Namen und Seite beim Spielbeginn:</h2>
<form action="setNames" id="form">
 <label for="left">Linker Spieler</label> 
 <input type="text" name="left" id="left" size="20" maxlength="30">

 <label for="right">Rechter Spieler</label>  
 <input type="text" name="right" id="right" size="20" maxlength="30">

 <input type="submit" value="Ok"></input>
</form></body>
)====";

    server->send(200, "text/html", html);
}


#define OK "Ok"
#define OKx 3
#define OKy 61
#define WEx 52
#define WEy 61

void showSetupMenu(char *rightMsg="Wechsel") {
  int16_t x,y;
  uint16_t w,h;

  display.setFont(&FreeSans9pt7b);
  display.getTextBounds(OK,OKx,OKy,&x,&y,&w,&h);
  display.drawRect(x-2,y-2,w+4,h+4,WHITE);
  display.setCursor(OKx,OKy);
  display.print(OK);
  
  if (rightMsg != NULL) {
      display.getTextBounds(rightMsg,WEx,WEy,&x,&y,&w,&h);
      display.drawRect(x-2,y-2,w+4,h+4,WHITE);
      display.setCursor(WEx,WEy);
      display.print(rightMsg);
  }
}

//////////////////////////////////////

void showBrightness() {
  static byte brightnessValues[] = {0b00000000, 0b00000001, 0b00000011, 0b00000111, 0b11111111};
  static char*menuTexts[] =        {"Min",      "25%",      "50%",      "75%",      "Max"};

  brightness = brightness % sizeof(brightnessValues);
  setLEDCurrent(brightnessValues[brightness]);

  display.clearDisplay();
  display.setCursor(3,15);
  display.print(String("Helligkeit: ") + menuTexts[brightness]);

  showSetupMenu();
  display.display();
}

void changeBrightness() {
  brightness++;
  showBrightness();
}

void brightnessSetup() {
  showBrightness();
  b->buttonLeft.attachClick(startCount);
  b->buttonRight.attachClick(changeBrightness);
}

//////////////////////////////////////

void changeServer() {
  leftStartetToServe = !leftStartetToServe;
  showServer(leftStartetToServe);
  theScore.showScoreOnLEDs();
}

void serverSetup() {
  display.clearDisplay();
  showServer(leftStartetToServe);
  theScore.showScoreOnLEDs();
  display.setCursor(3,15);
  display.print("Aufschlag?");
  showSetupMenu();
  display.display();

  b->buttonLeft.attachClick(startCount);
  b->buttonRight.attachClick(changeServer);
}

//////////////////////////////////////

void showNumberOfGames(int gamesNeededToWinMatch) {
  static char*menuTexts[] = {"1 von 1?", "2 von 3?", "3 von 5?",
                             "4 von 7?", "5 von 9?"};
  display.clearDisplay();

  display.setFont(NULL);
  display.setCursor(0, 30);
  display.print("Gewinnsaetze");

  display.setFont(&FreeSans9pt7b);
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
  showNumberOfGames(gamesNeededToWinMatch);
  b->buttonLeft.attachClick(brightnessSetup);
  b->buttonRight.attachClick(changeNumberOfGames);
}

//////////////////////////////////////

void showInfoPage() {
  display.clearDisplay();

  display.setFont(NULL);
  display.setCursor(0, 0);
  display.print("IP="); display.println(ip);

  if (wantToJoinNetwork) {
      display.println("\nTicker=");
      display.println("freeboard.io/board/Y25Tan");
  } else {
      display.println("\nKein Ticker");
      display.println("\nnicht im Netz!");
  }

  showSetupMenu(NULL);
  display.display();
}

void infoPage() {
  showInfoPage();
  b->buttonLeft.attachClick(numberOfGamesSetup);
  b->buttonRight.attachClick(numberOfGamesSetup);
}

//////////////////////////////////////

void swapPlayerNames() {
  String tmp = nameOfPlayerWhoStartedLeft;
  nameOfPlayerWhoStartedLeft = nameOfPlayerWhoStartedRight;
  nameOfPlayerWhoStartedRight = tmp;

  showPlayerNames();
  display.display();
}

void showPlayerNames() {
  display.clearDisplay();
  display.setFont(NULL);
  display.setCursor(0,0);
  display.print("Linker Spieler:\n");
  display.print(nameOfPlayerWhoStartedLeft);

  display.setCursor(0,22);
  display.print("   Rechter Spieler:\n");
  display.print("   ");
  display.print(nameOfPlayerWhoStartedRight);

  showSetupMenu();
  display.display();
}

void swapPlayerNamesSetup() {
  showPlayerNames();
  b->buttonLeft.attachClick(serverSetup);
  b->buttonRight.attachClick(swapPlayerNames);
}

//////////////////////////////////////

void showEnterPlayerNames() {
  display.clearDisplay();
  display.setFont(NULL);
  display.setCursor(0,0);
  display.print("Spieler eingeben mit:\n\n");
  display.print(ip); display.print("/setNames");

  showSetupMenu("Weiter");
  display.display();
}

void enterPlayerNames() {
  showEnterPlayerNames();
  b->buttonLeft.attachClick(swapPlayerNamesSetup);
  b->buttonRight.attachClick(serverSetup);
}

//////////////////////////////////////

void doWifiMode() {
  WiFiManager wifiManager;

  display.clearDisplay();
  display.setFont(&FreeSans9pt7b);
  display.setCursor(0,12);
  display.print("Wlan ...");
  display.display();

  if (wantToJoinNetwork) {
      wifiManager.setDebugOutput(false);
      //wifiManager.setTimeout(300);

      display.setFont(NULL);
      display.setCursor(0,25);
      display.print("Zum Einrichten mit\n\n   ");
      display.print(ssid);
      display.print("\n\nverbinden");
      display.display();

      if(wifiManager.autoConnect(ssid, password)) {
        ip = WiFi.localIP();
      } else {
        // failed to connect and hit timeout
      }
  } else {
      wifiManager.resetSettings();
      // AP mode
      WiFi.softAP(ssid, password);
      ip = WiFi.softAPIP();
  }

  server = new ESP8266WebServer(80);
  server->on("/", handleRoot);
  server->on("/setNames", handleSetNames);
  server->begin();

  enterPlayerNames();
}

void showWifiMode(bool wantToJoin) {
  display.clearDisplay();

  display.setFont(&FreeSans9pt7b);
  display.setCursor(3,15);
  if (wantToJoin) {
    display.print(ssid);
    display.setFont(NULL);
    display.setCursor(3,25);
    display.print("ins Wlan einbinden?");
  } else {
    display.print(ssid);
    display.setFont(NULL);
    display.setCursor(3,25);
    display.print("als eigenes Netz?");
  }

  showSetupMenu();
  display.display();
}

void changeWifiMode() {
  wantToJoinNetwork = !wantToJoinNetwork;
  showWifiMode(wantToJoinNetwork);
}

void wifiModeSetup() {
  showWifiMode(wantToJoinNetwork);
  b->buttonLeft.attachClick(doWifiMode);
  b->buttonRight.attachClick(changeWifiMode);
}

//////////// Timout //////////////////
static int timeoutTime=-1;
static bool thereIsANewTimoutValue=false;

void stopTimout() {
    timer.detach();
    thereIsANewTimoutValue=false;
    startCount();
}


// ISR should be small
void reduceTimout() {
  timeoutTime--;
  thereIsANewTimoutValue=true;
}

void showTimoutTime() {
  if (timeoutTime <= 0) {
      stopTimout();
      return;
  }

  digitalWrite(TLC_LE, LOW);
  writeLEDDigit(-1, false);
  writeLEDDigit(timeoutTime%10, false);
  writeLEDTenner(timeoutTime, false);
  yield();
  writeLEDDigit(timeoutTime%10, false);
  writeLEDTenner(timeoutTime, false);
  writeLEDDigit(-1, false);
  digitalWrite(TLC_LE, HIGH);

  yield();

  display.clearDisplay();
  display.setFont(&FreeSans24pt7b);
  display.setCursor(40,32);
  display.print(timeoutTime);
  showSetupMenu(NULL);
  display.display();
}

void startTimeout() {
  timeoutTime = 60;
  thereIsANewTimoutValue=true;
  b->buttonLeft.attachClick(stopTimout);
  b->buttonRight.attachClick(stopTimout);
  timer.attach(1, reduceTimout);
}

void askToStartTimout () {
  display.clearDisplay();
  display.setFont(&FreeSans9pt7b);
  display.setCursor(3,15);
  display.print("Timeout?");

  showSetupMenu("Nein");
  display.display();
  b->buttonLeft.attachClick(startTimeout);
  b->buttonRight.attachClick(infoPage);
}

//////////////////////////////////////

void startUpOptionSetup() {
  wifiModeSetup();
}

void optionSetup() {
  b->buttonLeft.attachLongPressStart(stopTimout);
  b->buttonRight.attachLongPressStart(stopTimout);
  askToStartTimout();
}


void defaultLongPressAction() {
  b->buttonLeft.attachLongPressStart(optionSetup);
  b->buttonRight.attachLongPressStart(optionSetup);
}

void clickRight() {
  defaultLongPressAction();
  theScore.count(theScore.right);
}
void clickLeft() {
  defaultLongPressAction();
  theScore.count(theScore.left);
}
void dclickRight() {
  defaultLongPressAction();
  theScore.count(theScore.right, -1);
}
void dclickLeft() {
  defaultLongPressAction();
  theScore.count(theScore.left, -1);
}
void gameOverSwapSide() {
    defaultLongPressAction();
    theScore.gameOverSwapSide();
}
void lastGameSwapSide() {
    defaultLongPressAction();
    theScore.lastGameSwapSide();
}

void startCount() {
  theScore.showScore();

  defaultLongPressAction();
  b->buttonRight.attachClick(clickRight);
  b->buttonLeft.attachClick(clickLeft);
  b->buttonRight.attachDoubleClick(dclickRight);
  b->buttonLeft.attachDoubleClick(dclickLeft);
}

void TLC_modeSwitch(bool isSpecial) {
  digitalWrite(TLC_OE, HIGH);
  digitalWrite(TLC_CLK, LOW);
  digitalWrite(TLC_LE, LOW);
  digitalWrite(TLC_CLK, HIGH);

  digitalWrite(TLC_CLK, LOW);
  digitalWrite(TLC_OE, LOW);
  digitalWrite(TLC_CLK, HIGH);

  digitalWrite(TLC_CLK, LOW);
  digitalWrite(TLC_OE, HIGH);
  digitalWrite(TLC_CLK, HIGH);

  digitalWrite(TLC_CLK, LOW);
  digitalWrite(TLC_LE, isSpecial);
  digitalWrite(TLC_CLK, HIGH);

  digitalWrite(TLC_CLK, LOW);
  digitalWrite(TLC_LE, LOW);
  digitalWrite(TLC_CLK, HIGH);
  digitalWrite(TLC_CLK, LOW);
}

void setLEDCurrent(byte configCode) {
  // Look at Datasheet Figure 22 on Page 25
  // configCode == 0 --> darkest
  //               0xff --> brightest

  // Switch to special mode
  TLC_modeSwitch(HIGH);

  for (int i=0; i<6; i++) {
    shiftOut(TLC_SDI, TLC_CLK, MSBFIRST, configCode);
  }
  delay(20);
  //digitalWrite(TLC_CLK, LOW);
  digitalWrite(TLC_LE, HIGH);
  //digitalWrite(TLC_CLK, HIGH);

  // Switch to normal mode
  TLC_modeSwitch(LOW);
  digitalWrite(TLC_OE, LOW);
}


void setup()   {                
  Serial.begin(115200);  Sprintln("Start");

  display.begin(SSD1306_SWITCHCAPVCC, 0x3C);
  
  display.setTextSize(1);
  display.setTextColor(WHITE);

  pinMode(TLC_OE, OUTPUT);
  pinMode(TLC_LE, OUTPUT);
  pinMode(TLC_CLK, OUTPUT);
  pinMode(TLC_SDI, OUTPUT);

  setLEDCurrent(0b00000011);    // 50%

  digitalWrite(TLC_OE, LOW);  // Enable all Segments
  digitalWrite(TLC_LE, LOW);
  shiftOut(TLC_SDI, TLC_CLK, MSBFIRST, nine);
  shiftOut(TLC_SDI, TLC_CLK, MSBFIRST, eight);
  shiftOut(TLC_SDI, TLC_CLK, MSBFIRST, seven);
  shiftOut(TLC_SDI, TLC_CLK, MSBFIRST, six);
  shiftOut(TLC_SDI, TLC_CLK, MSBFIRST, five);
  shiftOut(TLC_SDI, TLC_CLK, MSBFIRST, four);
  delay(20);
  digitalWrite(TLC_LE, HIGH);

  delay(100);

  display.clearDisplay();
  display.setFont(NULL);
  display.setCursor(0, 30);
  display.print("Wlan einrichten ..");
  display.display();

  
  b = new Buttons();

  // allow reuse (if server supports it)
  http.setReuse(true);


  // Start Options query
  startUpOptionSetup();
}

void loop() {
    b->buttonRight.tick();
    b->buttonLeft.tick();
    delay(10);

    if (server) {
        server->handleClient();
    }

    if (thereIsANewTimoutValue) {
        showTimoutTime();
        thereIsANewTimoutValue = false;
    }

}


