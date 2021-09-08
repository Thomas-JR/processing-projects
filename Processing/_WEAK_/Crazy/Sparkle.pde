class Sparkle {
  float x;
  float y;
  float size;
  float gravityV;
  float gravityH;
  Sparkle() {
    x = random (-width/2, width/2);
    y = random (-height, height/2);
    size = random (3, 6);
    gravityV = random(-10, 10);
    gravityH = random(-10, 10);
  }
  void rebound() {
    if (y <= -height/2 || y >= height/2) {
      gravityV = -gravityV;
    }
    if (x <= -width/2 || x >= width/2) {
      gravityH = -gravityH;
    }
  }
  void update() {
    y = y + gravityV;
    x = x + gravityH;
    ellipse(x, y, size, size);
  }
}