class Circle {
  float x, xInc, drag, maxSpeed, minSpeed;

  Circle(int pos) {
    x = -width/9*pos/10;
    maxSpeed = width/50;
    xInc = maxSpeed;
    minSpeed = maxSpeed / 2;
  }

  void update() {
    if (x <= width/9*3)
      xInc = maxSpeed;
    else if (x <= width/9*4)
      xInc = map(x, width/9*2, width/9*3, maxSpeed/2, minSpeed);
    else if (x <= width/9*5)
      xInc = minSpeed;
    else if (x <= width/9*6)
      xInc = map(x, width/9*5, width/9*6, minSpeed, maxSpeed);
    else if (x >= width/9*11)
      x = -width/9*2;
    x += xInc;
    ellipse(x, height/2, 30, 30);
  }
}