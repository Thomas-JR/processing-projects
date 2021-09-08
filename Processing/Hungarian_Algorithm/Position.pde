class Position {
  float a, x, y;
  int number, row, column;
  
  Position(float xPos, float yPos, int r, int c) {
    row = r;
    column = c;
    x = xPos;
    y = yPos;
    a = random(1, 10);
    for (int i = 1; i < 10; i++) {
      if (a - i < 1) {
        number = int(a);
        break;
      } else
        continue;
    }
  }
  
  void update() {
    textSize(30);
    textAlign(CENTER);
    fill(0);
    text(str(number), x, y+15);
  }
  
  void updateNumber(int sub) {
    number -= sub;
  }
  
  int row() {
    return row;
  }
  
  int col() {
    return col;
  }
  
  int number() {
    return number;
  }
}