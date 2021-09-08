PImage bg;
boolean swiping;
boolean lastPressed;
int y;
int lastY;
float total;
boolean check;
float distance;

void setup() {
  size(440, 700);
  bg = loadImage("Background.jpg");
  bg.resize(width, height);
}

void draw() {
  image(bg, 0, 0);
  if (mousePressed && lastPressed == false) {
    total = 0;
    swiping = true;
    lastY = mouseY;
  }
  if (mousePressed == false && swiping) {
    swiping = false;
    check = true;
  }
  
  if (swiping) {
    y = mouseY;
    total += (lastY - y);
    distance = constrain(total, 0, 150);
    distance = map(total, 0, 700, 0, 150);
    noStroke();
    fill(0, distance);
    rect(0, 0, width, height);
    lastY = mouseY;
  }
  
  if (check == true) {
    if (total >= 300) {
      fill(0, 150);
      rect(0, 0, width, height);
    }
  }
  
  lastPressed = mousePressed;
}