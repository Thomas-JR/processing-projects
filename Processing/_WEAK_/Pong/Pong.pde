int ballx = 60;
float bally = 500;
float yinc = 10;
int xinc = 10;
int p2x = 1465;
int p2y = 500;
int score1 = 0;
int score2 = 0;

void setup() {
  size(1280, 720);
}

void draw() {
  //Background
  background(0, 100, 255);
  stroke(0, 0);
  for (int yB = 0; yB < height; yB = yB + 100) {
    rect(width/2-10, yB+20, 20, 50);
  }

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
  text(p1s, width/2 - 80, 40);
  text(p2s, width/2 + 30, 40);

  //Refresh
  if (ballx <= 0) {
    score2 = score2 + 1;
    delay(1500);
    p2y = 500;
    ballx = 60;
    xinc = 10;
    bally = 500;
  }
  if (ballx >= width) {
    score1 = score1 + 1;
    delay(1500);
    p2y = 500;
    ballx = 60;
    bally = 500;
  }

  //Player 1
  int p1y = mouseY;
  fill(255);
  stroke(0);
  rect(5, p1y - 60, 30, 120);

  //Player 2
  if (p2y < bally) {
    p2y = p2y + 10;
  }
  if (p2y > bally) {
    p2y = p2y - 10;
  }
  rect(width-40, p2y - 60, 30, 120);

  //Ball
  if (ballx == 50 && bally <= p1y + 60 && bally >= p1y - 60) {
    xinc = -xinc;
  }
  if (ballx == width - 60 && bally <= p2y + 60 && bally >= p2y - 60) {
    xinc = -xinc;
  }
  if (bally <= 0 || bally >= height) {
    yinc = -yinc;
  }
  ballx = ballx + xinc;
  bally = bally + yinc;
  ellipse(ballx, bally, 30, 30);
}