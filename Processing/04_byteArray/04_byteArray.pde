import processing.serial.*;
Serial myPort;  // Create object for serial port

char[] pixelInt = {0, 0, 255};  // LED matrix should be all red!


void setup() {
  size(320, 320);
  // Set up serial port
  String portName = Serial.list()[2];
  myPort = new Serial(this, portName, 115200);
  
  byte[] tempArray = new byte[pixelInt.length];
  for (int x = 0; x < pixelInt.length; x++) {
    tempArray[x] = byte(pixelInt[x]);
  }
  myPort.write(tempArray);
}

void draw() { 

}
