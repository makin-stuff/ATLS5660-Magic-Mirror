import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val;  // Data received from the serial port

void setup() {
  String portName = Serial.list()[2];  // Change the 0 to 1, 2, etc. to match your port
  myPort = new Serial(this, portName, 115200);
}

void draw() {
  // If data is available,
  if (myPort.available() > 0) {
    val = myPort.readStringUntil('\n');  // Read and store in val
  }
  println(val);  // Print it out in the console
}
