// I2c Driver on Arduino Mega
// For 32x64 RGB LED matrix.

// NOTE THIS CAN ONLY BE USED ON A MEGA! NOT ENOUGH RAM ON UNO!
// See https://www.arduino.cc/en/Tutorial/MasterWriter

#include <Adafruit_GFX.h>   // Core graphics library
#include <RGBmatrixPanel.h> // Hardware-specific library
#include "Ubuntu_C16pt7b.h"
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
const uint16_t BLACK = matrix.Color333(0,0,0);
const uint16_t RED = matrix.Color333(2,0,0);
const uint16_t GREEN = matrix.Color333(0,1,0);



int leftGames = 0;
int leftPoints = 1;

int rightGames = 0;
int rightPoints = 8;

bool leftIsServing = true;

void showScore() {
  // fill the screen with 'black'
  matrix.fillScreen(BLACK);
  
  matrix.setFont(&Ubuntu_C16pt7b);
  matrix.setTextWrap(false); // Don't wrap at end of line - will do ourselves

  int x;

  // Points
  if (leftPoints < 10) {
      x = 9;
  } else {
      x = 0;
  }
  matrix.setCursor(x, 21);
  matrix.setTextColor(RED);
  matrix.print(leftPoints);

  matrix.setCursor(28, 19);
  matrix.setTextColor(WHITE);
  matrix.print(":");

  if (rightPoints < 10) {
      x = 43;
  } else {
      x = 38;
  }
  matrix.setTextColor(RED);
  matrix.setCursor(x, 21);
  matrix.print(rightPoints);


  // Games
  matrix.setFont(NULL);
  matrix.setTextSize(1);     // size 1 == 8 pixels high

  matrix.setCursor(0, 24);
  matrix.setTextColor(WHITE);
  matrix.print(leftGames);

  matrix.setCursor(59, 24);
  matrix.setTextColor(WHITE);
  matrix.print(rightGames);


  // Server
  if (leftIsServing) {
      matrix.drawRect(7, 24, 10, 7, GREEN);
      matrix.drawLine(7, 24, 16, 30, GREEN);
      matrix.drawLine(7, 30, 16, 24, GREEN);
  } else {
      matrix.drawRect(47, 24, 10, 7, GREEN);
      matrix.drawLine(47, 24, 56, 30, GREEN);
      matrix.drawLine(47, 30, 56, 24, GREEN);
  }
}

void receiveEvent(int howMany) {
  leftGames = Wire.read();
  leftPoints = Wire.read();
  rightGames = Wire.read();
  rightPoints = Wire.read();
  leftIsServing = Wire.read();

  showScore();
}

void setup() {
  Wire.begin(8);                // join i2c bus with address #8
  Wire.onReceive(receiveEvent); // register event

  matrix.begin();
  
  showScore();
}


void loop() {
  delay(10);
}
