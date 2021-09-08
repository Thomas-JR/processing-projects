class Ball {
  boolean moved;
  PVector pos, vel, newVel;
  float radius, phi;
  int ID;

  Ball(float x_, float y_, float radius_, int ID_) {
    ID = ID_;
    pos = new PVector(x_, y_);
    float randomNum = random(-5, 5);
    vel = new PVector(randomNum, 0-abs(randomNum));
    radius = radius_;
  }

  void update() {
    wallCollision();
    vel.add(gravity);
    if (moved) {
      pos.x = pos.x - cos(phi);
      pos.y = pos.y - sin(phi);
      vel = newVel;
    }
    pos.add(vel);
    ellipse(pos.x, pos.y, radius*2, radius*2);
    moved = false;
  }

  void wallCollision() {
    if (pos.x+vel.x <= radius) {
      vel.x =- vel.x;
      pos.x += radius - pos.x;
    }
    if (pos.x+vel.x >= width-radius) {
      vel.x =- vel.x;
      pos.x += width-radius - pos.x;
    }
    if (pos.y+vel.y <= radius) {
      vel.y =- vel.y;
      pos.y += radius - pos.y;
    }
    if (pos.y+vel.y >= height-radius) {
      vel.y =- vel.y;
      pos.y -= pos.y-(height-radius);
    }
  }

  void ballCollision(Ball b) {
    phi = atan2((b.pos.y-pos.y), (b.pos.x-pos.x));
    float angle1 = atan2(vel.y, vel.x);
    float angle2 = atan2(b.vel.y, b.vel.x);
    float v1 = vel.mag();
    float v2 = b.vel.mag();
    float m1 = PI*sq(radius);
    float m2 = PI*sq(b.radius);
    float xPrime = ((v1*cos(angle1-phi)*(m1-m2)+2*m2*v2*cos(angle2-phi))/(m1+m2))*cos(phi)-v1*sin(angle1-phi)*sin(phi);
    float yPrime = ((v1*cos(angle1-phi)*(m1-m2)+2*m2*v2*cos(angle2-phi))/(m1+m2))*sin(phi)+v1*cos(angle1-phi)*cos(phi);
    newVel = new PVector(xPrime, yPrime);
    moved = true;
  }
  
  void puckCollision(Puck p) {
    phi = atan2((p.pos.y-pos.y), (p.pos.x-pos.x));
    float angle1 = atan2(vel.y, vel.x);
    float angle2 = atan2(p.vel.y, p.vel.x);
    float v1 = vel.mag();
    float v2 = p.vel.mag();
    float m1 = PI*sq(radius);
    float m2 = PI*sq(p.radius);
    float xPrime = ((v1*cos(angle1-phi)*(m1-m2)+2*m2*v2*cos(angle2-phi))/(m1+m2))*cos(phi)-v1*sin(angle1-phi)*sin(phi);
    float yPrime = ((v1*cos(angle1-phi)*(m1-m2)+2*m2*v2*cos(angle2-phi))/(m1+m2))*sin(phi)+v1*cos(angle1-phi)*cos(phi);
    newVel = new PVector(xPrime, yPrime);
    moved = true;
  }
}