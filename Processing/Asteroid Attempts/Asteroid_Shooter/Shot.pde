class Shot {
  PVector pos, dir;
  boolean active;
  float speed;
  int life;

  Shot() {
    speed = 20;
    dir = new PVector();
  }

  void show() {
    for (int i = 0; i < asteroids.size(); i++) {
      if (dist(asteroids.get(i).pos.x, asteroids.get(i).pos.y, pos.x, pos.y) < asteroids.get(i).radius + 30) {
        active = false;
        asteroids.remove(i);
        for (int j = 0; j < 2; j++) {
          asteroids.add(new Asteroid(asteroids.get(j).type-1));
          asteroids.get(j).pos = asteroids.get(i).pos;
        }
      }
    }

    fill(255);
    ellipse(pos.x, pos.y, 5, 5);

    pos.x += dir.x*speed;
    pos.y += dir.y*speed;
    if (pos.x < 0) pos.x += width;
    if (pos.x > width) pos.x -= width;
    if (pos.y < 0) pos.y += height;
    if (pos.y > height) pos.y -= height;
    life --;
    if (life <= 0)
      active = false;
  }

  void startShot(PVector pos_) {
    pos = pos_;
    life = 100;
    active = true;
  }
}
