#include <Wire.h>

void setup() {
  Wire.begin(); // join i2c bus (address optional for master)
}

byte leftPoints = 0;
byte leftGames = 0;

byte rightPoints = 0;
byte rightGames = 0;

byte leftIsServing = 0;

void loop() {
  Wire.beginTransmission(8); // transmit to device #8
  Wire.write(leftGames);
  Wire.write(leftPoints);
  Wire.write(rightGames);
  Wire.write(rightPoints);
  Wire.write(leftIsServing);
  Wire.endTransmission();    // stop transmitting

  leftPoints++;
  if (leftPoints > 11) {
      leftPoints = 0;
      leftGames++;
  }

  if (leftPoints % 2 == 0) {
      leftIsServing = (!leftIsServing);
  }

  delay(1500);
}
