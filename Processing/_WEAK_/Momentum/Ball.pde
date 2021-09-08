void rebound() {
  if (ballX >= width - 15) {
    ballX = width-15;
    ballSpeed = -ballSpeed;
  }
  if (ballX <= 15) {
    ballX = 15;
    ballSpeed = -ballSpeed;
  }
}

void momentum() {
  if (momentumL == true && ballSpeed > -100) {
    ballSpeed = ballSpeed - 0.25;
  } else if (momentumR == true && ballSpeed < 100) {
    ballSpeed = ballSpeed + 0.25;
  } else {
    if (ballSpeed > 0.1) {
      ballSpeed = ballSpeed - 0.25;
    } 
    if (ballSpeed < -0.1) {
      ballSpeed = ballSpeed + 0.25;
    }
  }
}

void update() {
  fill(100);
  noStroke();
  yM = yM - yI;
  yV = yV - yM;
  if (yV >= 285) {
    yV = 285;
    yM = -yM;
  }
  ballX = ballX + ballSpeed;
  ellipse(ballX, yV, 30, 30);
}