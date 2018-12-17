# RGB Matrix for Atmega128

## Compile

* Arduino install: https://github.com/MCUdude/MegaCore
* Library "RGB matrix Panel"
  * sed -i 's/TIMSK1/TIMSK/' /home/thomas/Arduino/libraries/RGB_matrix_Panel/RGBmatrixPanel.cpp
  * sed -i  's/TIFR1/TIFR/' /home/thomas/Arduino/libraries/RGB_matrix_Panel/RGBmatrixPanel.cpp
