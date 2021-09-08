void makeNumber(int iterations_) {
  do {
    int randomSquare = int(random(0, 15));
    if (squares[randomSquare].total == 0) {
      if (random(10) == 9)
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
