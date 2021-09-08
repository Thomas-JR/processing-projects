int ballx = 60;
int bally = 500;
int score1 = 0;
int score2 = 0;
int xinc = 5;
int yinc = 5;
int p1y = 500;
int p2y = 500;

void setup() {
  size(1500, 1000);
}

void draw() {
  //Background
  background(0);
  stroke(0);
  rect(745, 0, 10, 1000);

  //Score
  fill(255);
  stroke(0);
  PFont s1;
  s1 = createFont("Arial", 16, true);
  textFont(s1, 36);
  PFont s2;
  String p1s = " " + score1;
  s2 = createFont("Arial", 16, true);
  textFont(s2, 36);
  String p2s = " " + score2;
  text(p1s, 630, 40);
  text(p2s, 830, 40);

  //Refresh
  if (ballx <= 0) {
    score2 = score2 + 1;
    delay(1500);
    bally = 500;
    ballx = 60;
    p1y = 500;
    p2y = 500;
    xinc = 5;
  }
  if (ballx >= 1500) {
    score1 = score1 + 1;
    delay(1500);
    bally = 500;
    ballx = 60;
    p1y = 500;
    p2y = 500;
  }

  //Player 1
  fill(20);
  stroke(0, 255, 0);
  rect(5, p1y - 60, 30, 120);

  //Player 2
  fill(20);
  stroke(255, 0, 0);
  int p2y = mouseY;
  rect(1465, p2y - 60, 30, 120);

  //Ball
  stroke(255);
  fill(255);
  ellipse(ballx, bally, 30, 30);
  if (bally <= 0 || bally >= 1000) {
    yinc = -yinc;
  }
  if (ballx == 50 && bally <= p1y + 60 && bally >= p1y - 60 || ballx == 1480 - 30 && bally <= p2y + 60 && bally >= p2y - 60) {
    xinc = -xinc;
  }
  ballx = ballx + xinc;
  bally = bally + yinc;
}

void keyPressed() {
  switch(key) {
    case 'w':
    if (p1y >= 70) {
      p1y = p1y - 15;
    }
    break;
    case 's':
    if (p1y <= 930) {
      p1y = p1y + 15;
    }
    break;
  }
}
/*
  switch(keyCode) {
  case UP:
    if (p2y >= 70) {
      p2y = p2y - 10;
    }
    break;
  case DOWN:
    if (p2y <= 930) {
      p2y = p2y + 10;
      break;
    }
  }*/