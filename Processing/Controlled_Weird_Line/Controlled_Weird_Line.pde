float x, y, lx, ly;
float t = 0;
float col;
boolean lastPressed;
float a = 0;

void setup() {
  size(700, 700);
  frameRate(1000);
  x = cos(radians(t))*200;
  y = sin(radians(a*t))*200;
  lx = x;
  ly = y;
  strokeWeight(10);
  colorMode(HSB);
  background(255);
}

void draw() {
  translate(width/2, height/2);
  x = cos(radians(t))*200;
  y = sin(radians(a*t))*200;
  stroke(col, 255, 255);
  line(x, y, lx, ly);
  lx = x;
  ly = y;
  t+=1;
  col += 0.01;
  if (col > 255)
    col = 0;
  if (mousePressed &! lastPressed) {
    a -= 0.1;
    if (mouseButton == LEFT)
    a += 0.2;
    t = 0;
    x = cos(radians(t))*200;
    y = sin(radians(a*t))*200;
    lx = x;
    ly = y;
    background(255);
  }
  lastPressed = mousePressed;
  noStroke();
  fill(255);
  rect(-50, height/3, 100,100);
  fill(0);
  text(a, 0, height/20*9);
}
