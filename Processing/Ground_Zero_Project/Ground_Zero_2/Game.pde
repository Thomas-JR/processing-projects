class Game {
  //Game object that holds useful values
  float hunger, full, zombieSpeed, humanSpeed, humanFear;
  int minutes, lastSecond, xLen, yLen, selected, infected, clickPower;
  boolean lastPressed, play, started;
  PImage back;

  Game() {
    lastSecond = second();
    infected = 500;
    full = 100;
    clickPower = 100;
    xLen = 6;
    yLen = 3;
    zombieSpeed = 2;
    humanSpeed = 3;
    humanFear = 0.9999;
  }

  void update() {
    //Update time and other information
    if (play && lastSecond != second()) {
      lastSecond = second();
      minutes += 2;
    }
    fill(0);
    textAlign(LEFT);
    textSize(16);
    text("Framerate = " + frameRate + "\nElapsed Time = " + state.minutes + " minutes", 50, 50);
    lastPressed = mousePressed;
  }
}