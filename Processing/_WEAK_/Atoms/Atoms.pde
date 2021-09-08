Atom[] atoms = new Atom[100];

void setup() {
  fullScreen();
  for (int i = 0; i < atoms.length; i++) {
    atoms[i] = new Atom();
  }
  colorMode(HSB);
  background(255);
}

void draw() {
  background(255);
  for (Atom a : atoms) {
    a.forces();
  }
  for (Atom a : atoms) {
    a.update();
    //if (a.pos.x < 0 || a.pos.x > width) {
    //  println(a.pos.x, a.mom.x);
    //  exit();
    //}
  }
}

void keyPressed() {
  switch (keyCode) {
  case UP:
    break;
  case DOWN:
    break;
  case LEFT:
    break;
  case RIGHT:
    break;
  }
}
