int row = 4;
int col = 4;
int stage;
int lastStage;
boolean lastPressed;
Position[] positions = new Position[row*col];

void setup() {
  size(600, 600);
  rectMode(CENTER);
  int i = 0;
  for (int y = 0; y < col; y++) {
    for (int x = 0; x < row; x++) {
      positions[i] = new Position((width/(row+1))+x*(width/(row+1)), (height/(col+1))+y*(height/(col+1)), x, y);
      i += 1;
    }
  }
}

void draw() {
  background(255);
  //Go to the next stage
  if (keyPressed && !lastPressed)
    stage += 1;

  //Perform stage 1
  if (stage > lastStage) {
    if (stage == 1) {
      int c = 0;
      int r = row;
      int sub = 10;
      for (int i = 0; i < positions.length; i++) {
        if (positions[i].number() < sub)
          sub = positions[i].number();
        r -= 1;
        if (r <= 0) {
          r = row;
          for (int j = 0; j < row; j++) {
            positions[(c*4)+j].updateNumber(sub);
          }
          c += 1;
          sub = 10;
        }
      }
    }
    if (stage == 2) {
      int c = 0;
      int r = 0;
      int sub = 10;
      while (c < col) {
        if (positions[r*4+c].number() < sub)
          sub = positions[r*4+c].number();
        r += 1;
        if (r >= row) {
          r = 0;
          for (int j = 0; j < row; j++) {
            positions[j*4+c].updateNumber(sub);
          }
          c += 1;
          sub = 10;
        }
      }
    }
    if (stage == 3) {
      
    }
  }

  //Draw algebra representations for rows and columns
  text("a", width/(row*2)/2, height/(col+1)+height/(col+1)*0);
  text("b", width/(row*2)/2, height/(col+1)+height/(col+1)*1);
  text("c", width/(row*2)/2, height/(col+1)+height/(col+1)*2);
  text("d", width/(row*2)/2, height/(col+1)+height/(col+1)*3);
  text("w", width/(row+1)+width/(row+1)*0, height/(col*2)/2);
  text("x", width/(row+1)+width/(row+1)*1, height/(col*2)/2);
  text("y", width/(row+1)+width/(row+1)*2, height/(col*2)/2);
  text("z", width/(row+1)+width/(row+1)*3, height/(col*2)/2);

  //Draw and update the squares
  int i = 0;
  for (int y = 0; y < col; y++) {
    for (int x = 0; x < row; x++) {
      fill(255);
      rect((width/(row+1))+x*(width/(row+1)), (height/(col+1))+y*(height/(col+1)), width/(row+1), height/(col+1));
      positions[i].update();
      i += 1;
    }
  }
  lastPressed = keyPressed;
  lastStage = stage;
}