class Puck {
  PVector pos, vel, lastVel, newVel;
  float radius;

  Puck(float radius_) {
    pos = new PVector(mouseX, mouseY);
    vel = new PVector();
    lastVel = new PVector();
    radius = radius_;
  }

  void update() {
    vel = new PVector(mouseX-lastVel.x, mouseY-lastVel.y);
    pos = new PVector(mouseX, mouseY);
    ellipse(pos.x, pos.y, radius*2, radius*2);
    lastVel = pos;
  }
}