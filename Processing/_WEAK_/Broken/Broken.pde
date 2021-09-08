int x = 0;
int y = 0;
int dec = 0;
int inc = 40;

void setup() {
  size(720, 720);
  background(0);
}

void draw() {
  int size = width - dec;
  stroke(0);
  if (x <= width) {
    rect(x, y, size, size);
  }
  x = x + 10;
  y = y + 10;
  dec = dec + inc;
  inc = inc - 1;
}