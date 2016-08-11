/*
  RGB LED Panel 32x64 testings


 */

const int OE = 9; // High disables Panel, Atmega8: 9,10,11
const int R1 = 2;
const int G1 = 3;
const int CLK = A0;
const int LAT = A1;


void panelShiftOut(uint8_t clockPin, uint8_t bitOrder,
          uint8_t r1, uint8_t g1)
{
    uint8_t i;

    for (i = 0; i < 8; i++)  {
        if (bitOrder == LSBFIRST) {
            //digitalWrite(dataPin, !!(val & (1 << i)));
        } else {
            digitalWrite(R1, !!(r1 & (1 << (7 - i))));
            digitalWrite(G1, !!(g1 & (1 << (7 - i))));
        }

        digitalWrite(clockPin, HIGH);
        digitalWrite(clockPin, LOW);        
    }
}


void setup() {
  // initialize serial communications at 9600 bps:
  //Serial.begin(9600);
  pinMode(R1, OUTPUT);
  pinMode(G1, OUTPUT);
  pinMode(CLK, OUTPUT);
  pinMode(LAT, OUTPUT);

  analogWrite(OE, 250); // 0=bright, 255=dim
  digitalWrite(LAT, LOW);

}

void loop() {
  for (int out=0; out<256; out++) {
    panelShiftOut(CLK, MSBFIRST, out,0);
    panelShiftOut(CLK, MSBFIRST, 0,0);
    panelShiftOut(CLK, MSBFIRST, 0,0);
    panelShiftOut(CLK, MSBFIRST, 0,out);
    panelShiftOut(CLK, MSBFIRST, 0,0);
    panelShiftOut(CLK, MSBFIRST, 0,0);
    panelShiftOut(CLK, MSBFIRST, 0,0);
    panelShiftOut(CLK, MSBFIRST, out,out);

    digitalWrite(LAT, HIGH);
    digitalWrite(LAT, LOW);

    delay(500);
  }
}
