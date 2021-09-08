Main main;

void setup() {
  size(800, 800);
  main = new Main(10);
  noStroke();
}

void draw() {
  background(0);
  main.update();
}

void keyPressed() {
  main.addBall();
  //switch (key) {
  //  case UP:
  //  main.setGravity(Direction.UP);
  //  break;
  //  case DOWN:
  //  main.setGravity(Direction.DOWN);
  //  break;
  //  case LEFT:
  //  main.setGravity(Direction.LEFT);
  //  break;
  //  case RIGHT:
  //  main.setGravity(Direction.RIGHT);
  //  break;
  //}
}

void mousePressed() {
  main.removeBall(new PVector(mouseX, mouseY));
}
