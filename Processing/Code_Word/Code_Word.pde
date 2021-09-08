int size = 16;
IntList squares;
float xLen, yLen;
int selected = 0;

void setup() {
  size(1000, 1000);
  xLen = width/size;
  yLen = height/size;
  squares = new IntList();
  for (int i = 0; i < size*size; i++) {
    squares.append(int(random(0)));
  }
}

void draw() {
  println(squares);
  if (keyPressed) {
    squares.set(selected, key-48);
  }
  int i = 0;
  for (int y = 0; y < size; y++) {
    for (int x = 0; x < size; x++) {
      fill(255);
      if (selected == i) fill(230);
      rect(3+x*xLen, 3+y*yLen, xLen, yLen);
      fill(0);
      text(squares.get(i), 3+x*xLen, 3+y*(yLen)+yLen);
      i++;
    }
  }
}

void keyPressed() {
  switch (keyCode) {
  case DOWN:
    if (selected < size*(size-1))
    selected += size;
    break;
  case UP:
    if (selected > size-1)
    selected -= size;
    break;
  case RIGHT:
    if (selected % size != size-1)
      selected ++;
    break;
  case LEFT:
    if (selected % size != 0)
    selected --;
    break;
  }
}
