float x;
float y;

void setup() {
  size (1200, 800);
  background(0);
}

void draw() {
  Star(x, y);
  for (int x = 50; x < width; x = x + 100) {
    for (int y = 50; y < height; y = y + 100) {
      Star(x, y);
    }
  }
}

void Star(float x, float y) {
  fill(255);
  stroke(0);
  beginShape();
  vertex(x, y-50);
  vertex(x+14, y-20);
  vertex(x+47, y-15);
  vertex(x+23, y+7);
  vertex(x+29, y+40);
  vertex(x, y+25);
  vertex(x-29, y+40);
  vertex(x-23, y+7);
  vertex(x-47, y-15);
  vertex(x-14, y-20);
  vertex(x, y-50);
  endShape();
}