class Bubble {
  float x;
  float y;
  float yInc;
  float xInc;
  float size;

  Bubble() {
    x = random(0, width);
    y = random(height, height+height);
    size = random (20, 50);
    yInc = size/10;
  }

  void reset() {
    if (y <= 0) {
      y = height;
    }
    if (mousePressed == true && dist(mouseX, mouseY, x, y) <= size/2) {
      size = 0;
      image(pop, x, y, 100, 100);
    }
  }

  void update() {
    xInc = random (-3, 3);
    x = x + xInc;
    y = y - yInc;
  }

  void show() {
    image(bubble, x, y, size, size);
  }
}