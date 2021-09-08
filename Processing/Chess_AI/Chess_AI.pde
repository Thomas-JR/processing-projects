import processing.sound.*;
SoundFile file;
Board board;

void setup() {
  size(800, 800);
  board = new Board();
  imageMode(CENTER);
  noStroke();
}

void draw() {
  translate(0, height);
  board.update();
}
