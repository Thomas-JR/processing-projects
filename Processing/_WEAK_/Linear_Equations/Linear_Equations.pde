float x;
float y;
float function;
float lastx;
float lasty;
int a = 1;

void setup() {
  size(displayWidth, 600);
  background(255);
  stroke(255);
  x = -width/2;
}

void draw() {
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
  translate(width/2, height/2);
  for (int x = -width/2; x < width/2; x++) {
    fill(0);
    y =- tan(2*x) + 3;
    line(x, y, lastx, lasty);
    lastx = x;
    lasty = y;
    stroke(0);
  }
  a += 5;
}