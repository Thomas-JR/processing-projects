Shooter shooter;
Shot[] shots = new Shot[100];
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
Fragment[] fragments = new Fragment [1];

void setup() {
  fullScreen();
  shooter = new Shooter();
  for (int i = 0; i < shots.length; i++)
    shots[i] = new Shot();
  for (int i = 0; i < 6; i++)
    asteroids.add(new Asteroid(2));
  for (int i = 0; i < fragments.length; i++)
    fragments[i] = new Fragment();
  background(0);
}

void draw() {
  fill(0, 30);
  rect(0, 0, width, height);
  background(0);
  if (shooter.alive) {
    shooter.update();
    shooter.show();
  }
  for (Shot s : shots) {
    if (s.active) {
      s.show();
    }
  }
  for (int i = 0; i < asteroids.size(); i++) {
    asteroids.get(i).show();
  }
  if (fragments[0].active) {
    for (Fragment fragment : fragments)
      fragment.update();
  }
}
