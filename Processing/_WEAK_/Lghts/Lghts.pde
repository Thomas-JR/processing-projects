void setup() {
  size(1900, 1000);
  background(0);
}

void draw() {
  for (int x = 0; x < width; x = x + 100) {
    for (int y = 0; y < height; y = y + 100) {
      float r = random(0, 255);
      fill(r);
      stroke(0);
      rect(x, y, 100, 100);
    }
  }
}