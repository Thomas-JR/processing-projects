Line[] lines = new Line[0];
boolean last;
boolean draw;
int x;
int y;
int x2;
int y2;

void setup() {
  frameRate(60);
  size (displayWidth, displayHeight);
  strokeWeight(3);
}

void draw() {
  background(255);
  if (mousePressed == true && last == false) {
    x = mouseX;
    y = mouseY;
    draw = true;
  }
  if (mousePressed == false && last == true) {
    x2 = mouseX;
    y2 = mouseY;
    draw = false;
  }
  if (draw == false) {
    line(x,y,x2,y2);
  }
  if (draw == true) {
    x2 = mouseX;
    y2 = mouseY;
    line(x,y,x2,y2);
  }
  last = mousePressed;
}