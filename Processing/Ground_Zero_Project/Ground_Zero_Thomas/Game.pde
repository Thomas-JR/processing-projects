class Game {
  //Game object that holds useful values
  float hunger, full, zombieSpeed, humanSpeed, humanFear;
  int minutes, lastSecond, xLen, yLen, selected, infected, clickPower, strongPerson;
  boolean lastPressed, play, started;
  PImage back, zombie, plant;

  Game() {
    lastSecond = second();
    infected = 500;
    full = 100;
    clickPower = 50;
    xLen = 6;
    yLen = 3;
    zombieSpeed = 2;
    humanSpeed = 4;
    humanFear = 0.99;
    strongPerson = 5;
  }

  void update() {
    if (minutes > 0) {
      //General updates for the games values
      zombie.resize(50, 80);
      plant.resize(80, 80);
    }
    //Update time and other information
    if (play && lastSecond != second()) {
      lastSecond = second();
      minutes += 2;
    }
    fill(0);
    textAlign(LEFT);
    textSize(16);
    text("Framerate = " + frameRate + "\nElapsed Time = " + minutes + " minutes", 50, 50);
    lastPressed = mousePressed;
  }
}