class Player {
  float y, x, lastY;
  int pos;

  Player(float x_, int pos_) {
    x = x_;
    y = height/2;
    pos = pos_;
  }

  void update() {
    rect(x, y, 20, height/10);
    lastY = y;
  }

  void check(float x_, float y_) {
    if (x_ <= x+20+speed/2 && x_ >= x-20-speed/2 && canChange) {
      if (y_ >= y-height/20 && y_ <= y+height/20) {
        if (pos == 0) {
          degrees = map(y_-y, -width/20, width/20, -90, 90);
          //degrees += (y - lastY)*2;
        } else if (pos == 1) {
          degrees = map(y_-y, -width/20, width/20, 270, 90);
          //degrees += (y - lastY)*2;
        }
        speed += 1;
        xInc = cos(radians(degrees))*speed;
        yInc = sin(radians(degrees))*speed;
        canChange = false;
      }
    }
  }

  void reset() {
    y = height/2;
  }
}