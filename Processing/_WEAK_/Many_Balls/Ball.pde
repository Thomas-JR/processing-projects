class Ball {
  float r = random(0, 255);
  float g = random(0, 255);
  float b = random(0, 255);
  float ballSpeed = 0;
  float ballX;
  float yV = 285;
  float yM = 0;
  float yI = 2;
  float size;

  Ball() {
    ballX = random(15, width-15);
    size = random(15, 30);
  }

  void update() {
    if (momentumL == true && ballSpeed > -100) {
      ballSpeed = ballSpeed - 0.50;
    } else if (momentumR == true && ballSpeed < 100) {
      ballSpeed = ballSpeed + 0.50;
    } else {
      if (ballSpeed > 0.1) {
        ballSpeed = ballSpeed - 0.10;
      } 
      if (ballSpeed < -0.1) {
        ballSpeed = ballSpeed + 0.10;
      }
    }
    if (momentumU == true && yV >= 300 - size/2 && yM < 20) {
      yM = yM + 20/size * 10;
    }
    yM = yM - yI;
    yV = yV - yM;
  }

  void rebound() {
    if (yV >= 300 - size/2) {
      yV = 300 - size/2;
      yM = -yM;
    }
    if (ballX >= width - 15) {
      ballX = width-15;
      ballSpeed = -ballSpeed;
    }
    if (ballX <= 15) {
      ballX = 15;
      ballSpeed = -ballSpeed;
    }
  }

  void show() {
    fill(r, g, b);
    noStroke();
    ballX = ballX + ballSpeed/size*10;
    ellipse(ballX, yV, size, size);
  }
}