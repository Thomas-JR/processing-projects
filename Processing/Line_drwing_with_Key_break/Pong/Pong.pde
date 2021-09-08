Player[] players = new Player[2];
float x, y, degrees, xInc, yInc, speed, yPos;
boolean canChange, lastFlip;
int score1, score2;
boolean up;
boolean down;

void setup() {
  fullScreen();
  rectMode(CENTER);
  textAlign(CENTER);
  textSize(50);
  noCursor();
  players[0] = new Player(width/100, 0);
  players[1] = new Player(width-width/100, 1);
  x = width/2; 
  y = height/2;
  speed = 8;
  randomDegrees();
  xInc = cos(radians(degrees))*speed;
  yInc = sin(radians(degrees))*speed;
}

void draw() {
  //background
  background(0);
  for (int i = height/20; i < height; i+= height/10) {
    fill(255);
    noStroke();
    rect(width/2, i, 10, height/20);
  }
  text(score1, width/30, height/30);
  text(score2, width-width/30, height/30);

  //update paddles
  for (int i = 0; i < players.length; i++) {
    players[i].update();
  }
  if (up)
    yPos -= 10;
  if (down)
    yPos += 10;
  players[0].y = yPos;
  players[1].y = mouseY;

  //ball
  if (y <= 25 || y >= height-25 &! lastFlip) {
    yInc =- yInc;
    lastFlip = true;
  } else
    lastFlip = false;
  x += xInc; 
  y += yInc;
  ellipse(x, y, 25, 25);
  players[0].check(x, y);
  players[1].check(x, y);
  if (x >= width/2-10 && x <= width/2+10)
    canChange = true;

  //Scores
  if (x <= -10 || x >= width+10) {
    if (x < 0)
      score2 ++;
    else if (x > width)
      score1 ++;
    players[0].reset();
    players[1].reset();
    x = width/2;
    y = height/2;
    randomDegrees();
    speed = 8;
    xInc = cos(radians(degrees))*speed;
    yInc = sin(radians(degrees))*speed;
  }
}

void keyPressed() {
  switch (keyCode) {
  case ENTER:
    players[0].reset();
    players[1].reset();
    x = width/2;
    y = height/2;
    randomDegrees();
    xInc = cos(radians(degrees))*speed;
    yInc = sin(radians(degrees))*speed;
    speed = 8;
    break;
  case UP:
    up = true;
    break;
  case DOWN:
    down = true;
    break;
  }
}

void keyReleased() {
  switch (keyCode) {
  case UP:
    up = false;
    break;
  case DOWN:
    down = false;
    break;
  }
}

void randomDegrees() {
  degrees = random(0, 1);
  if (degrees < 0.5) 
    degrees = random(135, 225);
  else
    degrees = random(45, -45);
}
