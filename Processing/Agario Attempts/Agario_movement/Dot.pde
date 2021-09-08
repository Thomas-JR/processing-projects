class Dot {
  float dotX;
  float dotY;
  float dotSize;
  float r;
  float g;
  float b;
  float bleet;

  Dot() {
    dotX = random(0, width);
    dotY = random(0, height);
    dotSize = random(15, 20);
    r = random(0, 255);
    g = random(0, 255);
    b = random(0, 255);
  }

  void loop() {
    if (size >= PI * ((dotSize/2) * (dotSize/2))) {
      if (dist(dotX, dotY, x, y) <= radius/2) {
        size += PI * ((dotSize/2) * (dotSize/2));
        dotSize = 0;
      }
    }

    fill(r, g, b);
    ellipse(dotX, dotY, dotSize, dotSize);
  }
}