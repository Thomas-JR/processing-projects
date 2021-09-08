Circle[] circles = new Circle[5];

void setup() {
  fullScreen();
  for (int i = 0; i < circles.length; i++) {
    circles[i] = new Circle(i);
  }
}

void draw() {
  background(0);
  for (int i = 0; i < circles.length; i++) {
    circles[i].update();
  }
}