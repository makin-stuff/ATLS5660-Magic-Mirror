import processing.serial.*;
Serial myPort;  // Create object for serial port

void setup() {
  // Create canvas
  size(500, 700); 
  // Set up serial port
  String portName = Serial.list()[2];
  myPort = new Serial(this, portName, 115200);
}

void draw() {
  // Create the buttons
  fill(255, 0, 0);
  rect(100, 100, 300, 100);
  fill(0, 255, 0);
  rect(100, 300, 300, 100);
  fill(0, 0, 255);
  rect(100, 500, 300, 100);
}

void mousePressed() {
  if (mouseX > 100 & mouseX < 300) {
    // Clicked on red button
    if (mouseY > 100 & mouseY < 200) {
      println("Red");
      // Send message to Arduino
      myPort.write('1');
    }
    // Clicked on green button
    if (mouseY > 300 & mouseY < 400) {
      println("Green");
      // Send message to Arduino
      myPort.write('2');
    }
    // Clicked on blue button
    if (mouseY > 500 & mouseY < 600) {
      println("Blue");
      // Send message to Arduino
      myPort.write('3');
    }
  }
}
