int x = 5;
int y = 400;
int a = 5;
int c = 5;

void setup() {
  size (1200, 400);
}

void draw() {
  //Background
  background(0);
  PFont pot;
  pot = createFont("Arial", 16, true);
  textFont(pot, 200);
  String potato = "POTATO";
  float r = random(0, 255);
  float g = random(0, 255);
  float b = random(0, 255);
  fill(r, g, b);
  if (y == 400 || y == 140) {
    c = -c;
  }
  if (x == 420 || x == 0) {
    a = -a;
  }
  y = y + c;
  x = x + a;
  text(potato, x, y);
  delay(10);
}