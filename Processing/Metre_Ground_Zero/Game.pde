class Game {
  //Game object that holds useful values
  int seconds, lastSecond, xLen, yLen, selected, infected, clickPower;
  boolean lastPressed, play, lastPlay, started;
  PImage back;
  float hunger, full, zombieSpeed, humanSpeed, humanFear;

  Game() {
    lastSecond = second();
    infected = 500;
    full = 100;
    clickPower = 10;
    xLen = 6;
    yLen = 3;
    zombieSpeed = 2;
    humanSpeed = 3;
    humanFear = 0.999;
  }

  void update() {
    if (play && lastSecond != second()) {
      lastSecond = second();
      seconds ++;
    }
    seconds ++;
    fill(0);
    textAlign(LEFT);
    textSize(16);
    text("Framerate = " + frameRate + "\nElapsed Time = " + state.seconds + " seconds", 50, 50);
    lastPressed = mousePressed;
  }
}