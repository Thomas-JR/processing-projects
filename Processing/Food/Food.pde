int food = 500;
float x;
float y;
float xInc;
float yInc;
int size = 100;
boolean death = false;

void setup() {
  size(displayWidth, displayHeight);
  x = displayWidth/2;
  y = displayHeight/2;
  xInc = random (-20, 20);
  yInc = random (-20, 20);
}

void draw() {
  if (death == true) {
    background(255, 0, 0);
  } else {
    background(255);
  }
  fill(255, 0);
  rect(30, height-120, 500, 50);
  fill(0, 255, 0);
  rect(30, height-120, food, 50);
  if (food >= 0) {
    food = food - 2;
  }
  fill(0, 255, 0);
  ellipse (x, y, size, size);
  if (food <= 490 && mousePressed && dist(mouseX, mouseY, x, y) <= 100) {
    food = food + 4;
  }
  x = x + xInc;
  y = y + yInc;
  if (x >= width-size/2 || x <= size/2) {
    xInc = -xInc;
    yInc = random(-20, 20);
  }
  if (y >= height-size || y <= size/2) {
    yInc = -yInc;
    xInc = random(-20, 20);
  }
  if (food >= 500) {
    death = false;
  }
  if (food <= 0) {
    death = true;
  }
}