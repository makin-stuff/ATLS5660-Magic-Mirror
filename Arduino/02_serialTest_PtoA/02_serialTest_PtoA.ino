char val; // Data received from the serial port
int ledPin = 13;  // Set the pin to digital I/O 13

void setup() {
  // put your setup code here, to run once:
  pinMode(LED_BUILTIN, OUTPUT);
  SerialUSB.begin(115200);
}

void loop() {
  // If data is available to read,
  if (SerialUSB.available()) {
    val = SerialUSB.read();  // Read it and store it in val
  }
  // If 1 was received
  if (val == '1') {
    // Turn the LED on 
    digitalWrite(LED_BUILTIN, HIGH);
  } else {
    // Turn the LED off
    digitalWrite(LED_BUILTIN, LOW);
  } 
  delay(10);
}
