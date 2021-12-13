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

void setup() {
  // Initialize serial port
  SerialUSB.begin(9600);

  // Initialize the LED matrix
  matrix.begin();

  // For debug
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
  // If data is available to be read,
  while (SerialUSB.available()) {
    
    // Read r, g, b values
    r = SerialUSB.read();
    delay(1);
    g = SerialUSB.read();
    delay(1);
    b = SerialUSB.read();
    delay(1);
    
    // Draw pixel
    x = count % 32;
    y = count / 32;
    matrix.drawPixel(x,y, matrix.Color888(r, g, b));
    // Update counter
    count++;
  }

  // Reset variables
  count = 0;
  r = 0;
  g = 0;
  b = 0;
  delay(10);  // Don't hammer too hard on the serial bus
}
