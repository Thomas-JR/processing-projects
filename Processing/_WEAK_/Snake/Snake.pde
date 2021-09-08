int directionX = 20;
int directionY = 0;
boolean directionU = false;
boolean directionD = false;
boolean directionR = true;
boolean directionL = false;
int x = -20;
int y = 0;
float foodX = random ( 0, 660);
float foodY = random (0, 660);

void setup() {
  background(0, 255, 100);
  size (600, 600);
}

void draw() {
  // Food
  rect (foodX, foodY, 20, 20, 10);

  // update Snake Direction
  x = x + directionX;
  y = y + directionY;
  rect(x, y, 20, 20);
  delay(100);

  //Death from Sides
  if (x < 0) {
    background(0, 255, 100);
    directionX = 20;
    directionY = 0;
    x = -20;
    y = 0;
  }
  if (x > width) {
    background(0, 255, 100);
    directionX = 20;
    directionY = 0;
    x = -20;
    y = 0;
  }
  if (y < 0) {
    background(0, 255, 100);
    directionX = 20;
    directionY = 0;
    x = -20;
    y = 0;
  }
  if (y > height) {
    background(0, 255, 100);
    directionX = 20;
    directionY = 0;
    x = -20;
    y = 0;
  }
}

void keyPressed() {
  switch(keyCode) {
  case UP:
    directionU = true;
    directionD = false;
    directionL = false;
    directionR = false;
    directionX = 0;
    directionY = -20;
    break;
  case DOWN:
    directionU = false;
    directionD = true;
    directionL = false;
    directionR = false;
    directionX = 0;
    directionY = 20;
    break;
  case LEFT:
    directionU = false;
    directionD = false;
    directionL = true;
    directionR = false;
    directionX = -20;
    directionY = 0;
    break;
  case RIGHT:
    directionU = false;
    directionD = false;
    directionL = false;
    directionR = true;
    directionX = 20;
    directionY = 0;
    break;
  }
}