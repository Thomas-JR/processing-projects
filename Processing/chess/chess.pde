import processing.sound.*;
SoundFile file;

Chess chess;

void setup() {
  fullScreen();
  chess = new Chess();
  rectMode(CENTER);
  textAlign(CENTER);
  imageMode(CENTER);
  fill(255);
  noStroke();
  chess.showBoard();

  file = new SoundFile(this, "sound.mp3");
}

void draw() {
}

void mouseClicked() {
  chess.highlightSquare();
}

void playSound() {
  file.play();
}
