import processing.video.*;

import processing.serial.*;
Serial myPort;  // Create object for serial port

// Number of columns and rows in our system
// i.e. number of LEDs in the matrix
int cols = 32;
int rows = 32;
// Variable for capture device
Capture video;
int cellSize;

// Hold onto our pixel data
color[] pixelColors = new color[cols * rows];
int[] pixelInt = new int[cols * rows * 3];
char[] pixelChar = new char[cols * rows * 3];

void setup() {
  size(320, 320);
  // Figure out the size of the cell
  cellSize = width / cols;
  colorMode(RGB, 255, 255, 255, 100);
  rectMode(CENTER);
  
  video = new Capture(this, width, height);
  
  // Start capturing the images from the camera
  video.start();
  
  // Set up serial port
  String portName = Serial.list()[2];
  myPort = new Serial(this, portName, 9600);
}

void draw() { 
  if (video.available()) {
    video.read();
    video.loadPixels();
    
    // Begin loop for columns
    for (int i = 0; i < cols; i++) {
      // Begin loop for rows
      for (int j = 0; j < rows; j++) {

        // Where are we, pixel-wise?
        int x = i * cellSize;
        int y = j * cellSize;
        int loc = (video.width - x - 1) + y*video.width; // Reversing x to mirror the image

        // Each rect is colored based on the pixel
        float r = red(video.pixels[loc]);
        float g = green(video.pixels[loc]);
        float b = blue(video.pixels[loc]);
        // Make a new color
        color c = color(r, g, b);
        // Add this color to color array
        pixelColors[cols * i + j] = c;
        fill(c);
        noStroke();
        rect(x + cellSize/2, y + cellSize/2, cellSize, cellSize);
      }
    }
  }
  
    // Let's convert "color" pixel array to an array of separate r, g, b values
  // First, we need to iterate through every value of pixelColors
  for (int i = 0; i < pixelColors.length; i++) {
    // Add red value to array
    pixelInt[i*3] = int(red(pixelColors[i]));
    // Add green value to array
    pixelInt[i*3 + 1] = int(green(pixelColors[i]));
    // Add blue value to array
    pixelInt[i*3 + 2] = int(blue(pixelColors[i]));
  }
  // DEBUG
  printArray(pixelInt);
  
  // Ok, so now we have an array of raw r, g, b ints...
  // Let's convert to chars!
  for (int j = 0; j < pixelInt.length; j++) {
    pixelChar[j] = char(pixelInt[j]);
  }
  
  // byte array trick
  byte[] tempArray = new byte[pixelChar.length];
  for (int x = 0; x < pixelChar.length; x++) {
    tempArray[x] = byte(pixelChar[x]);
  }
  
  // Let's send the byte array out over serial now
  myPort.write(tempArray);
  
  delay(7000);
}

// If a key is pressed
//void keyPressed() {
//  // DEBUG
//  // Let's print the contents of the pixelColors array
//  //printArray(pixelColors);
//  // Let's convert "color" pixel array to an array of separate r, g, b values
//  // First, we need to iterate through every value of pixelColors
//  for (int i = 0; i < pixelColors.length; i++) {
//    // Add red value to array
//    pixelInt[i*3] = int(red(pixelColors[i]));
//    // Add green value to array
//    pixelInt[i*3 + 1] = int(green(pixelColors[i]));
//    // Add blue value to array
//    pixelInt[i*3 + 2] = int(blue(pixelColors[i]));
//  }
//  // DEBUG
//  printArray(pixelInt);
  
//  // Ok, so now we have an array of raw r, g, b ints...
//  // Let's convert to chars!
//  for (int j = 0; j < pixelInt.length; j++) {
//    pixelChar[j] = char(pixelInt[j]);
//  }
  
//  // byte array trick
//  byte[] tempArray = new byte[pixelChar.length];
//  for (int x = 0; x < pixelChar.length; x++) {
//    tempArray[x] = byte(pixelChar[x]);
//  }
  
//  // Let's send the byte array out over serial now
//  myPort.write(tempArray);
//}
