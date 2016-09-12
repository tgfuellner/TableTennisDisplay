// I2c Driver on Arduino Mega
// For 32x64 RGB LED matrix.

// NOTE THIS CAN ONLY BE USED ON A MEGA! NOT ENOUGH RAM ON UNO!
// See https://www.arduino.cc/en/Tutorial/MasterWriter

#include <Adafruit_GFX.h>   // Core graphics library
#include <RGBmatrixPanel.h> // Hardware-specific library
#include "Ubuntu_C16pt7b.h"
#include <Fonts/FreeSans9pt7b.h>
#include <Wire.h>

#define OE   9
#define LAT 10
#define CLK 11
#define A   A0
#define B   A1
#define C   A2
#define D   A3

RGBmatrixPanel matrix(A, B, C, D, CLK, LAT, OE, false, 64);

const uint16_t WHITE = matrix.Color333(1,1,1);
const uint16_t BLUE = matrix.Color333(0,0,1);
const uint16_t BLACK = matrix.Color333(0,0,0);
const uint16_t RED = matrix.Color333(1,0,0);
const uint16_t GREEN = matrix.Color333(0,1,0);
//const uint16_t YELLOWISH = matrix.Color888(16,0,0);  das dunkelste
const uint16_t YELLOWISH = matrix.Color333(1,0,0);

bool newDataArived = false;


int leftGames = 0;
int leftPoints = 0;

int rightGames = 0;
int rightPoints = 0;

enum State {
    timeout = 0,
    left = 1, right = 2    // Side to serve
};
State state = timeout;


void showScore() {
  digitalWrite(OE, HIGH);   // Stop led flashing

  // fill the screen with 'black'
  matrix.fillScreen(BLACK);
  
  matrix.setFont(&Ubuntu_C16pt7b);
  matrix.setTextWrap(false); // Don't wrap at end of line - will do ourselves

  int x;
  uint16_t color;

  if (state == timeout) {
      if (leftPoints < 10) {
          x = 27;
      } else {
          x = 18;
      }
      color = GREEN;
      if (leftPoints < 11) {
          color = RED;
      }
      matrix.setCursor(x, 26);
      matrix.setTextColor(color);
      matrix.print(leftPoints);
      digitalWrite(OE, LOW);
      return;
  }

  // Left Points and Games
  if (leftPoints < 10) {
      x = 8;
      color = GREEN;

      matrix.setFont(&FreeSans9pt7b);
      matrix.setTextColor(BLUE);
      matrix.setCursor(-1, 31);
      matrix.print(leftGames);
  } else {
      color = RED;
      x = 0;

      matrix.setFont(NULL);
      matrix.setTextColor(BLUE);
      matrix.setTextSize(1);     // size 1 == 8 pixels high
      matrix.setCursor(1, 24);
      matrix.print(leftGames);
  }
  matrix.setFont(&Ubuntu_C16pt7b);
  matrix.setCursor(x, 21);
  matrix.setTextColor(color);
  matrix.print(leftPoints);

  matrix.setCursor(28, 19);
  matrix.setTextColor(BLUE);
  matrix.print(":");

  if (rightPoints < 10) {
      x = 43;
      color = GREEN;

      matrix.setFont(&FreeSans9pt7b);
      matrix.setTextColor(BLUE);
      matrix.setCursor(54, 31);
      matrix.print(rightGames);
  } else {
      x = 38;
      color = RED;

      matrix.setFont(NULL);
      matrix.setTextColor(BLUE);
      matrix.setTextSize(1);     // size 1 == 8 pixels high
      matrix.setCursor(58, 24);
      matrix.print(rightGames);
  }
  matrix.setFont(&Ubuntu_C16pt7b);
  matrix.setTextColor(color);
  matrix.setCursor(x, 21);
  matrix.print(rightPoints);


  // Server
  if (state==left) {
      matrix.fillCircle(14,27,3,GREEN);
  } else if (state==right) {
      matrix.fillCircle(49,27,3,GREEN);
  }

  digitalWrite(OE, LOW);
}

void showGreeting() {
  digitalWrite(OE, HIGH);   // Stop led flashing

  // fill the screen with 'black'
  matrix.fillScreen(BLACK);
  
  matrix.setFont(&Ubuntu_C16pt7b);
  matrix.setTextWrap(false); // Don't wrap at end of line - will do ourselves


  matrix.setCursor(0, 26);
  matrix.setTextColor(YELLOWISH);
  matrix.print("Hallo");

  digitalWrite(OE, LOW);
}

void receiveEvent(int howMany) {
  leftGames = Wire.read();
  leftPoints = Wire.read();
  rightGames = Wire.read();
  rightPoints = Wire.read();
  state = static_cast<State>(Wire.read());

  newDataArived = true;
}

void testScore(int lg,int lp, int rg,int rp, State s) {
  leftGames = lg;
  leftPoints = lp;
  rightGames = rg;
  rightPoints = rp;
  state = s;

  newDataArived = true;
}


void setup() {
  Wire.begin(8);                // join i2c bus with address #8
  Wire.onReceive(receiveEvent); // register event

  matrix.begin();
  
  testScore(3,11, 2,9, right);
  //showGreeting();
}


void loop() {
  delay(10);
  if (newDataArived) {
      showScore();
      newDataArived = false;
  }
}
