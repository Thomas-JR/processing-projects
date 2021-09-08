Square[] squares = new Square[16];
State state = new State();

float rectSize;
float rectSpacer;

void setup() {
  size(800, 800);
  rectMode(CENTER);
  textSize(60);
  textAlign(CENTER);
  colorMode(HSB);


  rectSize = min(width, height)/4.5;
  rectSpacer = (width-4*rectSize)/5;
  for (int i = 0; i < 16; i++)
    squares[i] = new Square(i);
  makeNumber(2);
}

void draw() {
  background(200);
  for (int y = 0; y < 4; y++) {
    for (int x = 0; x < 4; x++) {
      fill(220);
      rect((x+1)*rectSpacer + x*rectSize + rectSize/2, (y+1)*rectSpacer + y*rectSize + rectSize/2, rectSize, rectSize, 10);
    }
  }
  for (Square square : squares) {
    square.show();
  }
  state.update();
  if (keyPressed &! state.lastPressed && state.changed) {
    makeNumber(1);
  }
  state.lastPressed = keyPressed;
}

class Square {
  int x, y, ID, total;
  float xPos, yPos, targetXPos, targetYPos;

  Square(int ID_) {
    ID = ID_;
    x = ID % 4;
    for (int i = 0; i < 4; i++) { 
      if (15-i*4 >= ID) 
        y = 3-i;
    }
    xPos = (x+1)*rectSpacer + x*rectSize + rectSize/2;
    yPos = (y+1)*rectSpacer + y*rectSize + rectSize/2;
  }

  void show() {
    noStroke();
    if (total > 0) {
      fill(map(total, 0, 12, 25, 255), 255, 255);
      rect(xPos, yPos, rectSize, rectSize, 10);
      fill(255);
      text(str(int(pow(2, total))), xPos, yPos+20);
    }
  }
}

class State {
  int gameScore;
  boolean moving, up, down, left, right, changed, lastPressed, added;

  State() {
  }

  void update() {
    changed = false;
    if (up) {
      for (int i = 4; i < squares.length; i++) {
        added = false;
        if (squares[i].total > 0)
          moveUp(i);
      }
    }
    println(changed);
    if (down) {
      for (int i = squares.length-1; i >= 0; i--) {
        added = false;
        if (squares[i].total > 0)
          moveDown(squares[i].ID);
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

void makeNumber(int iterations_) {
  do {
    int randomSquare = int(random(0, 15));
    if (squares[randomSquare].total == 0) {
      if (random(10) > 8)
        squares[randomSquare].total = 2;
      else
        squares[randomSquare].total = 1;
      iterations_--;
    }
  } while (iterations_ > 0);
}

void keyPressed() {
  if (!state.moving) {
    switch (keyCode) {
      case UP:
      state.up = true;
      break;
      case DOWN:
      state.down = true;
      break;
      case LEFT:
      state.left = true;
      break;
      case RIGHT:
      state.right = true;
      break;
    }
  }
}

void keyReleased() {
  if (!state.moving) {
    switch (keyCode) {
      case UP:
      state.up = false;
      break;
      case DOWN:
      state.down = false;
      break;
      case LEFT:
      state.left = false;
      break;
      case RIGHT:
      state.right = false;
      break;
    }
  }
}
