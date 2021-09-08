glob[] glob = new glob[1];
blob[] blobs = new blob[1000];
boolean up;
boolean down;
boolean left;
boolean right;
float px;
float py;
float psize;
float screenx = width/2;
float screeny = height/2;
float screenSize = 5;

void setup() {
  size (displayWidth, displayHeight);
  for (int i = 0; i < glob.length; i++) {
    glob[i] = new glob();
  }
  for (int i = 0; i < blobs.length; i++) {
    blobs[i] = new blob();
  }
  noStroke();
}

void draw() {
  translate(width/2 - px*2, height/2 - py*2);
  background(255);
  scale(screenSize);
  for (int i = 0; i < glob.length; i++) {
    glob[i].update();
    glob[i].show();
  }
  for (int i = 0; i < blobs.length; i++) {
    blobs[i].update();
  }
}

void keyPressed() {
  switch(keyCode) {
  case UP:
    up = true;
    break;
  case DOWN:
    down = true;
    break;
  case LEFT:
    left = true;
    break;
  case RIGHT:
    right = true;
    break;
  }
}

void keyReleased() {
  switch(keyCode) {
  case UP:
    up = false;
    break;
  case DOWN:
    down = false;
    break;
  case LEFT:
    left = false;
    break;
  case RIGHT:
    right = false;
    break;
  }
}