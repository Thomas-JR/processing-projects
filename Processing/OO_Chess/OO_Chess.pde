Board board;

void setup() {
  size(800, 800);
  noStroke();
  board = new Board();
}

void draw() {
  board.show();
}
