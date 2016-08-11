import ssd1306
from machine import I2C, Pin
import math

i2c = I2C(sda=Pin(4), scl=Pin(5))
display = ssd1306.SSD1306_I2C(64, i2c)
display.fill(0)
#for x in range(0, 96):
#  display.pixel(x, 16+int(math.sin(x/32*math.pi)*7 + 8), 1)
display.text('Hallo',20,20)
display.text('Welt',60,60)
display.show()
