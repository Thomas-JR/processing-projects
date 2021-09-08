int x;
int y;
int xInc = 10;
int yInc = 10;
boolean one = true;
boolean two = false;
boolean stop;
int r = 0;
int g = 125;
int b = 250;
int rInc = 1;
int gInc = 1;
int bInc = 1;

void setup() {
  frameRate(60);
  strokeWeight(2);
  size(720, 720);
  background(0);
}

void draw() {
  r = r + rInc;
  g = g + gInc;
  b = b + bInc;
  if (r >= 255 || r <= 0) {
    rInc = -rInc;
  }
  if (g >= 255 || g <= 0) {
    gInc = -gInc;
  }
  if (b >= 255 || b <= 0) {
    bInc = -bInc;
  }
  stroke(r, g, b);
  if (x <= width && stop == false) {
    if (x == width/2) {
      yInc = -yInc;
    }
    line(x, height/2, width/2, height/2 - y);
    x = x + xInc;
    y = y + yInc;
  }
  if (x == width || x == 0) {
    xInc = -xInc;
  }
}
