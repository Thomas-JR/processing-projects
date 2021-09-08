Ball[] balls = new Ball[1];
boolean momentumR;
boolean momentumL;
boolean momentumU;

void setup() {
  size(displayWidth, 300, P2D);
  for (int i = 0; i < balls.length; i++) {
    balls[i] = new Ball();
  }
}

void draw() {
  background(0);
  fill(255);
  stroke(255);
  rect(width/2-50, 0, 100, height);
  for (int i = 0; i < balls.length; i++) {
    balls[i].update ();
    balls[i].rebound();
    balls[i].show();
  }
}

void keyReleased() {
  momentumL = false;
  momentumR = false;
  momentumU = false;
}

void keyPressed() {
  switch(keyCode) {
  case LEFT:
    momentumL = true;
    break;
  case RIGHT:
    momentumR = true;
    break;
  case UP:
    momentumU = true;
    break;
  }
}