import processing.serial.*;

Serial myPort;  // Create object from Serial class

void setup() {
  size(200, 200);  // Make our canvas 200 x 200 pixels big
  String portName = Serial.list()[2];  // Change the 0 to a 1, 2, etc to match your port
  myPort = new Serial(this, portName, 115200);
}

void draw() {
  // If we clicked in the window, send a 1
  if (mousePressed == true) {
    myPort.write('1');  
    println("1");
  } else {
    myPort.write('0');
  }
}
