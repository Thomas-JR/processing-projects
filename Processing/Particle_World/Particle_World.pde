Screen screen;

void setup() {
  size(1000, 800);
  screen = new Screen(5, 3, 100);
  rectMode(CENTER);
  frameRate(10);
}

void draw() {
  background(0);
  screen.update();
  println(screen.size);
}
