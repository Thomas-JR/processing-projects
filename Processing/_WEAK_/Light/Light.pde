float degrees = 0;
float x, y;
float xStart;
float yStart;
float lightDensity = 0.5;
float raySize = 5;

void setup() {
  size(displayWidth, 660, P2D);
  xStart = width/2;
  yStart = height/2;
}

void draw() {
  if (mousePressed) {
    xStart = mouseX;
    yStart = mouseY;
  }
  background(0);
  for (float degrees = 0; degrees < 360; degrees += lightDensity) {
    for (int radius = 0; radius < max(width, height)*1.2; radius ++) {
      x = xStart+cos(radians(degrees))*radius;
      y = yStart+sin(radians(degrees))*radius;
      if (x <= 0 || x >= width || y <= 0 || y >= height || dist(x, y, width/4, height/2) <= 100)
        break;
    }
    stroke(255, 255, 255);
    strokeWeight(raySize);
    line(xStart, yStart, x, y);
  }
}