Drone droney = new Drone();
PImage thrustImage;

void setup() {
  fullScreen(P3D);
  droney.reset();
  background(255);
  thrustImage = loadImage("Rocket.png");
}

void draw() {
  //background(255);
  droney.show();
  droney.update();
}

void keyPressed() {
  switch(keyCode) {
  case UP:
    droney.thrust = true;
    break;
  case LEFT:
    droney.targetRotation = 20;
    break;
  case RIGHT:
    droney.targetRotation = -20;
    break;
  }
}

void keyReleased() {
  switch(keyCode) {
  case UP:
    droney.thrust = false;
    break;
  case LEFT:
    droney.targetRotation = 0;
    break;
  case RIGHT:
    droney.targetRotation = 0;
    break;
  }
}
