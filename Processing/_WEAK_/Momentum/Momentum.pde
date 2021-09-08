boolean momentumR;
boolean momentumL;
float ballSpeed = 0;
float ballX = 950;
float yV = 285;
float yM = 0;
float yI = 1;

void setup() {
  size(1900, 300);
}

void draw() {
  background(255);
  rebound();
  momentum();
  update();
}

void keyReleased() {
  momentumL = false;
  momentumR = false;
}

void keyPressed() {
  switch(keyCode) {
  case RIGHT:
    momentumR = true;
    break;
  case LEFT:
    momentumL = true;
    break;
  case UP:
    if (yV >= 285) {
      yM = 20;
    }
    break;
  }
}