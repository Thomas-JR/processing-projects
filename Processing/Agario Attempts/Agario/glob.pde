class glob {
  float xInc;
  float yInc;
  float inc;
  float max = 5;
  float r;
  float g;
  float b;
  float easing = 0.01;

  glob() {
    px = 0;
    py = 0;
    inc = 0.2;
    psize = 50;
    r = random(0, 255);
    g = random(0, 255);
    b = random(0, 255);
  }

  void update() {
    if (up == true && yInc > -max) {
      yInc -= inc;
    }
    if (down == true && yInc < max) {
      yInc += inc;
    }
    if (left == true && xInc > -max) {
      xInc -= inc;
    }
    if (right == true && xInc < max) {
      xInc += inc;
    }

    if (up == false && yInc <= inc) {
      yInc += inc;
    }
    if (down == false && yInc >= inc) {
      yInc -= inc;
    }
    if (left == false && xInc <= inc) {
      xInc += inc;
    }
    if (right == false && xInc >= inc) {
      xInc -= inc;
    }
    float dx = mouseX - width/2-px;
    px += dx * easing;

    float dy = mouseY - height/2-py;
    py += dy * easing;
  }

  void show() {
    px += xInc;
    py += yInc;
    screenx += xInc;
    screeny += yInc;
    fill(r, g, b);
    ellipse(px, py, psize, psize);
  }
}