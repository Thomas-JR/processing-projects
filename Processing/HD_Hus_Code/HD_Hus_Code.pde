float xlen;
float ylen;
float deg;
float radius = 200;
int total;
float a = 0;
float ai = 0.2;

void setup() {
  size(600, 600);
  background(0);
  noStroke();
  colorMode(HSB);
}

void draw() {
  a += ai;
  if (a <= 0 || a >= 255)
    ai =- ai;
  fill(a, 255, 255);
  deg += 10;
  radius -= 0.5;
  xlen = width/2 + cos(radians(deg)) * radius;
  ylen = height/2 + sin(radians(deg)) * radius;
  ellipse(xlen, ylen, 50, 50);
}