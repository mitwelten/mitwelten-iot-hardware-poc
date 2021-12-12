// Using https://wiki.seeedstudio.com/Grove-OLED-Display-0.66-SSD1306_v1.0/
// Start the point at (32,16) instead of (0,0). The range is from (31,16) to (95,63).

//#include "Adafruit_TinyUSB.h"; // Fix https://github.com/adafruit/Adafruit_nRF52_Arduino/issues/653
#include <SPI.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>

#define VBATPIN A6
#define OLED_RESET 13 //4
#define SCREEN_ADDRESS 0x3C
#define SCREEN_WIDTH 128 // px
#define SCREEN_HEIGHT 64 // px

// Grove 0.66" display is shifted by off_x, off_y
const int off_x = 32; // x = 0 on display
const int off_y = 16; // y = 0 on display
const int dsp_w = 64; // != display.width()
const int dsp_h = 48; // != display.height()

const int len = dsp_w;
int pos = 0;
float values[len] = {0};

Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET); // Grove I2C, 0.66"

void setup() {
  //Serial.begin(115200);
  //while(!Serial) {}
  display.begin(SSD1306_SWITCHCAPVCC, SCREEN_ADDRESS);
}

void loop() {
  int a = analogRead(VBATPIN); // 0 - 1023
  values[pos] = (a * 2.0f * 3.3f) / 1024;
  //Serial.println(values[pos]);
  String vStr = String(values[pos], 1);
  vStr.concat("V");

  display.clearDisplay();
  //display.drawRect(off_x, off_y, dsp_w, dsp_h, SSD1306_WHITE);
  display.cp437(true); // 256 char 'Code Page 437' font
  display.setTextSize(1);
  display.setTextColor(SSD1306_WHITE);
  display.setCursor(off_x + 2, off_y + 0);
  display.println("U");
  display.setCursor(off_x + dsp_w - 24 + 1, off_y + 0);
  display.print(vStr);
  display.setCursor(off_x + 2, off_y + dsp_h - 10);
  display.println("-6h");
  display.setCursor(off_x + dsp_w - 6, off_y + dsp_h - 10);
  display.println("t");
  for (int x = 0; x < dsp_w; x += 2) { // dotted x-axis
        display.drawPixel(off_x + x, off_y + dsp_h - 1, SSD1306_WHITE);
  }
  for (int y = 0; y < dsp_h; y += 2) { // dotted y-axis
        display.drawPixel(off_x, off_y + dsp_h - 1 - y, SSD1306_WHITE);
  }
  int x = 0;
  for (int i = pos + 1; i < len; i++) { // old part of graph curve
      int y = dsp_h - (dsp_h * values[i] / 5.0);
      display.drawPixel(off_x + x, off_y + y, SSD1306_WHITE);
      x++;
  }
  for (int i = 0; i <= pos; i++) { // new part of graph curve
      int y = dsp_h - (dsp_h * values[i] / 5.0);
      display.drawPixel(off_x + x + i, off_y + y, SSD1306_WHITE);
  }
  display.display();
  pos = (pos + 1) % len;
  
  //delay(1000); // ms
  delay(5.625 * 60 * 1000); // ms
}
