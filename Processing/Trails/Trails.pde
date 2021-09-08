Screen screen;

void setup() {
  fullScreen();
  //size(800, 800);
  screen = new Screen(1000, 5);
  noStroke();
}

void draw() {
  background(0);
  screen.update();
}
