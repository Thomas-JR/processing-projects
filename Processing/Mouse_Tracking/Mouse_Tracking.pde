float x;
float y;
int r = 0;
int g = 100;
int b = 200;
int rInc = 1;
int gInc = 3;
int bInc = 6;
float easing = 0.10;

void setup() {
  size(640, 360);
  noStroke();
  background(51);
}

void draw() { 
  r += rInc;
  g += gInc;
  b += bInc;
  if (r <= 0 || r >= 250) {
    rInc = -rInc;
  }
  if (g <= 0 || g >= 250) {
    gInc = -gInc;
  }
  if (b <= 0 || b >= 250) {
    bInc = -bInc;
  }
  
  float dx = mouseX - x;
  x += dx * easing;
  
  float dy = mouseY - y;
  y += dy * easing;
  
  fill(r, g, b);
  ellipse(x, y, 75, 75);
}