Spark[] sparks = new Spark [2000];
boolean go = false;
boolean reset = false;

void setup() {
  size (1600, 1000);
  for (int i = 0; i < sparks.length; i++) {
    sparks[i] = new Spark();
  }
}

void draw() {
  translate(width/2, height/2);
  background(0);
  if (go == true) {
    for (int i = 0; i < sparks.length; i++) {
      sparks[i].update();
      sparks[i].show();
    }
  }
}

void keyPressed() {
  switch(keyCode) {
  case UP:
    go = true;
    reset = false;
    break;
  case DOWN:
    reset = true;
    break;
  }
}