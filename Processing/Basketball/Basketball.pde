int boardX;
int boardY;
float ballX;
int ballY;
int boardInc = 2;
float ballInc;
boolean lastPressed;
boolean shoot;
int momentum;
float ballSize = 100;
int score = 0;

void setup() {
  size(600, displayHeight);
  ballX = width/2;
  ballY = height-150;
  boardX = width/2;
  boardY = 50;
}

void draw() {
  //Background
  background(255);
  text(score, 0, 0);
  
  //Board
  strokeWeight(3);
  fill(255);
  rect(boardX-100, boardY, 200, 120);
  ellipse(boardX, boardY + 100, 100, 25);
  boardX = boardX + boardInc;
  if (boardX >= width-100 || boardX <= 100) {
    boardInc = -boardInc;
  }
  
  //Ball
  fill(255,100,0);
  strokeWeight(2);
  ellipse(ballX, ballY, ballSize, ballSize);
  ellipse(ballX, ballY, ballSize-ballSize/6, ballSize);
  ellipse(ballX, ballY, ballSize/2, ballSize);
  
  
  //Trajectory
  if (mousePressed == true && lastPressed == false) {
    shoot = true;
    momentum = 35;
    ballInc = map(mouseX, 0, width, -10, 10);
  }
  
  //Shoot
  if (shoot == true) {
    ballX = ballX + ballInc;
    ballY = ballY - momentum;
    momentum = momentum - 1;
    ballSize = ballSize - 0.5;
  }
  
  //Score
  fill(0);
  if (ballY >= 100 && ballY<=130 && momentum <= 0 && ballX<=boardX+150 && ballX>=boardX+50) {
    score = score + 1;
    shoot = false;
    ballX = width/2;
    ballY = height-150;
    ballSize = 100;
  }
  if (ballY >= height+50 && momentum <= 0) {
    score = 0;
    shoot = false;
    ballX = width/2;
    ballY = height-150;
    ballSize = 100;
  }
  PFont s;
  s = createFont("Arial", 16, true);
  textFont(s, 36);
  String p = " " + score;
  text(p, 0, 30);
    
  
  lastPressed = mousePressed;
}