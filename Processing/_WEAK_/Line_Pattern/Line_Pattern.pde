float angle, s, radius;

void setup() {
  size(800, 800);
  radius = dist(width, height, 0, 0);
}

void draw() {
  background(255);
  angle = map(mouseX, 0, width, 0, 2*PI);
  s = map(height-mouseY, 0, height, 2, 100);
  for (int i = 0; i < height; i+= s) {
    line(0, i, width, i);
  }
  for (int i = 0; i < radius; i+= s) {
    line(0, i-sin(angle)*radius, width, height);
  }
}
