float x;
float y;
float d;
int angle = 0;
float r;
float g;
float b;

void setup() {
  frameRate(60);
  size(500, 500);
  y = height/2;
  x = width/2;
  d = width * 0.8;
  noStroke();
  r = random(100, 150);
  g = random(100, 150);
  b = random(100, 150);
  background(255);
}

void draw() {
  angle += 5;
  fill(r,g,b);
  arc(x, y, d, d, 0, (PI/(180))*angle);
  fill(b,r,g);
  arc(x, y, d/3*2, d/3*2, 0, (PI/(180))*angle);
  fill(g,b,r);
  arc(x, y, d/3, d/3, 0, (PI/(180))*angle);
  if (angle >= 360) {
    angle = 0;
    r = random(0, 255);
    g = random(0, 255);
    b = random(0, 255);
  }
}