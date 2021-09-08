class Planet {
  float r, g, b;
  int size;

  Planet() {
    r = random(0, 255);
    g = random(0, 255);
    b = random(0, 255);
    x = width / 2;
    xInc = 5;
    size = 80;
  }

  void update() {
    if (x <= 0+size/2+70) {
      x = 0+size/2+70;
      xInc = -xInc;
    }
    if (x >= width-size/2-70) {
      x = width-size/2-70;
      xInc = -xInc;
    }
    x = x + xInc;
  }

  void show() {
    noFill();
    stroke(0);
    strokeWeight(1);
    ellipse(x, 150, size, size);
    pnt.resize(size, size);
    image(pnt, x, 150);
  }

  void reset() {
    if (dist(x, 110, width/2, y) <= 30) {
      shoot = false;
      y = height - 130;
      score = score + 1;
      r = random(0, 255);
      g = random(0, 255);
      b = random(0, 255);
      if (xInc < 3 && xInc > 0) {
        xInc = 3;
        
      }
      if (xInc > -3 && xInc < 0) {
        xInc = -3;
      }
      x = random(10, width-10);
      bam.resize(160, 160);
      image(bam, pp, 150);
      lilPause = true;
      xInc = xInc + 1;
    }
    pp = x;
  }
}