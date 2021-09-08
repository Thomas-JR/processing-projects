Backing backing;

void setup() {
  fullScreen();  
  backing = new Backing();
}

void draw() {
  background(255);
  if (backing.started) {
    backing.show();
  } else {
    backing.create();
  }
  backing.update();
}
