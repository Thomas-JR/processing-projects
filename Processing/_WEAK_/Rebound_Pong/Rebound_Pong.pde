float ballX = 40;
float ballY = 300;
float xInc = 10;
float yInc = 10;
int score = 0;
int ps = 0;
int hs = 0;
float time = 0;
boolean a = false;

void setup() {
  size (1000, 600);
}

void draw() {
  // Background
  background(255);
  fill(0);
  stroke (0);
  rect(-5, 50, 10, 600);
  rect(0, 595, 999, 50);
  fill(255, 0, 0, 200);
  rect(975, 50, 10, 550);
  fill(200);
  stroke(0);
  rect(0, 0, 999, 50);

  //Scores
  fill(0);
  stroke(255);
  PFont s1;
  s1 = createFont("Arial", 16, true);
  textFont(s1, 36);
  String ps = "Score = " + score;
  text(ps, 20, 40);
  //High Score
  PFont high;
  high = createFont("Arial", 16, true);
  textFont(high, 36);
  String highScore = "High Score = " + hs;
  text(highScore, 700, 40);

  //Refresh
  if (ballX >= 961) {
    if (score > hs) {
      hs = score;
    }
    score = 0;
    ballX = 40;
    ballY = 300;
    xInc = 10;
    yInc = random(10, 20);
    delay(1500);
  }

  //player
  rect(970, mouseY - 60, 20, 120);

  //ball
  if (ballX <= 10) {
    xInc = -xInc;
  }
  if (ballX >= 960 && ballX <= 980 && ballY >= mouseY - 60 && ballY <= mouseY + 60) {
    xInc = -xInc;
    xInc = xInc *1.1;
    score = score +10;
  }
  if (ballY <= 60 || ballY >= 590) {
    yInc = -yInc;
  }
  ballX = ballX + xInc;
  ballY = ballY + yInc;
  ellipse(ballX, ballY, 20, 20);
  //Finish
}