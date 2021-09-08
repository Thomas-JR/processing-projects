public class Flight {
  PVector pos, vel;
  private final static int MIN_SPEED = 1;

  Flight() {
    pos = new PVector(int(random(width)), int(random(height)));
    float angle = random(2*PI);
    float speed = random(MIN_SPEED, 5);
    vel = new PVector(speed*cos(angle), speed*sin(angle));
  }

  Flight(int x, int y) {
    pos = new PVector(x, y);
    float angle = random(2*PI);
    float speed = random(MIN_SPEED, 5);
    vel = new PVector(speed*cos(angle), speed*sin(angle));
  }

  Flight(int x, int y, float speed) {
    pos = new PVector(x, y);
    float angle = random(2*PI);
    vel = new PVector(speed*cos(angle), speed*sin(angle));
  }

  void update() {
    pos.add(vel);
    wallCollision();
  }

  void wallCollision() {
    if (pos.x <= 0) {
      pos.x = -pos.x;
      vel = randomDirection(3*PI/2);
    }
    if (pos.x >= width) {
      pos.x = 2*width - pos.x;
      vel = randomDirection(PI/2);
    }
    if (pos.y <= 0) {
      pos.y = -pos.y;
      vel = randomDirection(0);
    }
    if (pos.y >= height) {
      pos.y = 2*height - pos.y;
      vel = randomDirection(PI);
    }
  }

  PVector randomDirection(float angle) {
    float direction = angle + random(PI);
    return new PVector(vel.mag()*cos(direction), vel.mag()*sin(direction));
  }
  
  public void changeDirection(float angle) {
    vel.rotate(angle);
  }
}
