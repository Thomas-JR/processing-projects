Circle[] circles = new Circle[3];
int inc = 50;

void setup() {
  size(600, 800);
  int distancer = inc;
  for(int i = 0; i < circles.length; i++) {
    circles[i] = new Circle(i, distancer);
    distancer -= inc;
  }
}

void draw() {
  background(255);
  for(int i = 0; i < circles.length; i++) {
    circles[i].update();
  }
}