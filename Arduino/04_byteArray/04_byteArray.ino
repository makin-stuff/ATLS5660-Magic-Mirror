// Include Adafruit's library
#include <RGBmatrixPanel.h>

// Pin definitions for RGB matrix
#define CLK  8   // USE THIS ON ADAFRUIT METRO M0, etc.
#define OE   9
#define LAT 10
#define A   A0
#define B   A1
#define C   A2
#define D   A3

RGBmatrixPanel matrix(A, B, C, D, CLK, LAT, OE, false);

int r = 0; // Temp variable to hold on to ints read from serial port
int g = 0;
int b = 0;
int count = 0;
int x = 0;
int y = 0;
int pixelInt [3072];
bool newPixelFlag = false;

void setup() {
  // Initialize serial port
  SerialUSB.begin(115200);

  // Initialize the LED matrix
  matrix.begin();

  // For debug
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
  // If data is available to be read,
  if (SerialUSB.available()) {
    // Read r, g, b values
    r = SerialUSB.read();
    //int rInt = r - '0';
    delay(1);
    g = SerialUSB.read();
    //int gInt = g - '0';
    delay(1);
    b = SerialUSB.read();
    //int bInt = b - '0';
    delay(1);

    matrix.fillScreen(matrix.Color888(r, g, b));
  }

  // Reset r, g, b
  r = 0;
  g = 0;
  b = 0;
}
