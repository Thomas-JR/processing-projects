float x, y, lastX, lastY, degrees, radius;

void setup() {
  fullScreen();
  x = width/2;
  lastX = x;
  lastY = y;
  stroke(255);
  strokeWeight(3);
  background(0);
}

void draw() {
  float chance = random(10);
  fill(0, 20);
  rect(0, 0, width, height);
  if (chance > 9) {
    while (y < height) {
      degrees = random(30, 150);
      radius = random(20, 30);
      x += cos(radians(degrees))*radius;
      y += sin(radians(degrees))*radius;
      line(x, y, lastX, lastY);
      lastX = x;
      lastY = y;
    }
  }
  x = random(width);
  y = 0;
  lastX = x;
  lastY = y;
}