class Segment {
  float x;
  float y;
  float size = width/12;
  int state = 0;
  int pos;
  int up, left, down, right;
  boolean air;

  Segment(float a, float b, int c) {
    x = a;
    y = b;
    pos = c;
  }

  void update() {
    if (mousePressed && !lastPressed) {
      if (state == 0 && dist(mouseX, mouseY, x, y) <= size/2) {
        if (turn % 2 == 0) {
          state = 1;
          turn += 1;
        } else {
          state = 2;
          turn += 1;
        }
      }
    }
    if (state == 1) {
      fill(0);
      ellipse(x, y, size, size);
    } else if (state == 2) {
      fill(255);
      ellipse(x, y, size, size);
    }
  }

  void Check() {
    if (pos > 8 && pos < 72) {
      if (pos % 9 == 0) {
        up = 3;
        down = segments[pos + 1].State();
        left = segments[pos - 9].State();
        right = segments[pos + 9].State();
      } else if (pos % 9 == 8) {
        up = segments[pos - 1].State();
        down = 3;
        left = segments[pos - 9].State();
        right = segments[pos + 9].State();
      } else {
        up = segments[pos - 1].State();
        down = segments[pos + 1].State();
        left = segments[pos - 9].State();
        right = segments[pos + 9].State();
      }
    } else if (pos < 9 || pos > 71) {
      if (pos != 0 && pos != 8 && pos != 72 && pos != 80) {
        up = segments[pos - 1].State();
        down = segments[pos + 1].State();
        if (pos < 9) {
          left = 3;
          right = segments[pos + 9].State();
        }
        if (pos > 71) {
          left = segments[pos - 9].State();
          right = 3;
        }
      }
      if (pos == 0) {
        left = 3;
        right = segments[pos + 9].State();
        up = 3;
        down = segments[pos + 1].State();
      }
      if (pos == 8) {
        left = 3;
        right = segments[pos + 9].State();
        up = segments[pos - 1].State();
        down = 3;
      }
      if (pos == 72) {
        left = segments[pos - 9].State();
        right = 3;
        up = 3;
        down = segments[pos + 1].State();
      }
      if (pos == 81) {
        left = segments[pos - 9].State();
        right = 3;
        up = segments[pos - 1].State();
        down = 3;
      }
    }

    if (state == 1) {
      if (left == 2 || left == 3) {
        if (right == 2 || right == 3) {
          if (down == 2 || down == 3) {
            if (up == 2 || up == 3) {
              state = 0;
            }
          }
        }
      }
    }
    else if (state == 2) {
      if (left == 1 || left == 3) {
        if (right == 1 || right == 3) {
          if (down == 1 || down == 3) {
            if (up == 1 || up == 3) {
              state = 0;
            }
          }
        }
      }
    }
  }

  int State() { 
    return state;
  }
}