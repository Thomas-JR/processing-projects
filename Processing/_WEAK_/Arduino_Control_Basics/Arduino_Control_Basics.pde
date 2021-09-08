import processing.serial.*;
Serial port;
float brightness;

void setup() {
  size(500, 500);
  port = new Serial(this, "COM5", 9600);
  port.bufferUntil('\n');
}

void draw() {
  background(0, map(brightness, 0, 1025, 0, 255), 0);
}

void serialEvent (Serial port) {
  brightness = float(port.readStringUntil('\n'));
}