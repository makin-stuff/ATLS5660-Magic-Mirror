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

char val = '0'; // Temp variable to hold on to strings read from serial port

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
    val = SerialUSB.read(); // Read it and store it in val
  }

  // Now check the variable and turn on the LEDs accordingly
  if (val == '1') {
    matrix.fillScreen(matrix.Color333(7, 0, 0));
    //delay(1000);
  } else if (val == '2') {
    matrix.fillScreen(matrix.Color333(0, 7, 0));
    //delay(1000);
  } else if (val == '3') {
    matrix.fillScreen(matrix.Color333(0, 0, 7));
    //delay(1000);
  }

  val = '0';
  delay(10);  // Don't hammer too hard on the serial bus
}
