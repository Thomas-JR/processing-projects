void shootThingo() {
  for (Shot s : shots) {
    if (!s.active) {
      s.startShot(shooter.pos1);
      s.dir = new PVector(cos(radians(shooter.rotation)), sin(radians(shooter.rotation)));
      return;
    }
  }
}

void keyPressed() {
  switch (keyCode) {
  case UP:
    shooter.thrust = true;
    break;
  case LEFT:
    shooter.left = true;
    break;
  case RIGHT:
    shooter.right = true;
    break;
  }
  if (key == ' ') {
    shootThingo();
  }
}

void keyReleased() {
  switch (keyCode) {
  case UP:
    shooter.thrust = false;
    break;
  case LEFT:
    shooter.left = false;
    break;
  case RIGHT:
    shooter.right = false;
    break;
  }
}
