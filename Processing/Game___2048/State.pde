class State {
  int gameScore;
  boolean moving, up, down, left, right, changed, lastPressed, added;

  State() {
  }

  void update() {
    changed = false;
    if (up) {
      for (int x = 0; x <= 3; x++) {
        for (int y = 1; y <= 3; y++) {
          added = false;
          if (squares[y*4+x].total > 0)
            moveUp(y*4+x);
        }
      }
    }
    if (down) {
      for (int x = 0; x <= 3; x++) {
        for (int y = 3; y >= 0; y--) {
          added = false;
          if (squares[y*4 + x].total > 0)
            moveDown(squares[y*4 + x].ID);
        }
      }
    }
    if (left) {
      for (int x = 0; x <= 3; x++) {
        for (int y = 0; y <= 3; y++) {
          added = false;
          if (squares[y*4 + x].total > 0)
            moveLeft(squares[y*4 + x].ID);
        }
      }
    }
    if (right) {
      for (int x = 2; x >= 0; x--) {
        for (int y = 0; y <= 3; y++) {
          added = false;
          if (squares[y*4 + x].total > 0)
            moveRight(squares[y*4 + x].ID);
        }
      }
    }
    up = false;
    down = false;
    left = false;
    right = false;
  }

  void moveUp(int ID_) {
    if (squares[ID_].y > 0) {
      if (squares[ID_-4].total == 0) {
        squares[ID_ - 4].total = squares[ID_].total;
        squares[ID_].total = 0;
        changed = true;
        moveUp(ID_-4);
      } else if (!added && squares[ID_-4].total == squares[ID_].total) {
        squares[ID_-4].total ++;
        squares[ID_].total = 0;
        added = true;
        moveUp(ID_-4);
        changed = true;
      }
    }
  }

  void moveDown(int ID_) {
    if (squares[ID_].y < 3) {
      if (squares[ID_+4].total == 0) {
        squares[ID_ + 4].total = squares[ID_].total;
        squares[ID_].total = 0;
        moveDown(ID_+4);
        changed = true;
      } else if (!added && squares[ID_+4].total == squares[ID_].total) {
        squares[ID_ + 4].total ++;
        squares[ID_].total = 0;
        added = true;
        moveDown(ID_+4);
        changed = true;
      }
    }
  }

  void moveLeft(int ID_) {
    if (squares[ID_].x > 0) {
      if (squares[ID_-1].total == 0) {
        squares[ID_ - 1].total = squares[ID_].total;
        squares[ID_].total = 0;
        moveLeft(ID_-1);
        changed = true;
      } else if (!added && squares[ID_-1].total == squares[ID_].total) {
        squares[ID_ - 1].total ++;
        squares[ID_].total = 0;
        added = true;
        moveLeft(ID_-1);
        changed = true;
      }
    }
  }

  void moveRight(int ID_) {
    if (squares[ID_].x < 3) {
      if (squares[ID_+1].total == 0) {
        squares[ID_ + 1].total = squares[ID_].total;
        squares[ID_].total = 0;
        moveRight(ID_+1);
        changed = true;
      } else if (!added && squares[ID_+1].total == squares[ID_].total) {
        squares[ID_+1].total ++;
        squares[ID_].total = 0;
        added = true;
        moveRight(ID_+1);
        changed = true;
      }
    }
  }
}
