class blob {
  float x;
  float y;
  float size;
  float r;
  float g;
  float b;

  blob() {
    x = random(-width/2, width/2);
    y = random(-height/2, height/2);
    size = random(6, 12);
    r = random(0, 255);
    g = random(0, 255);
    b = random(0, 255);
  }

  void update() {
    fill(r, g, b);
    if (dist(x, y, px, py) <= psize/2 + size/2) {
      psize += size/30;
      x = random(-width/2, width/2);
      y = random(-height/2, height/2);
      screenSize -= size/1000;
      if (dist(x, y, px, py) <= psize/2 + size/2) {
        size = 0;
      }
    }
    ellipse(x, y, size, size);
  }
}