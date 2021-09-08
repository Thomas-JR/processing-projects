Particle[] particles = new Particle[800];
float thrust;

void setup() {
  fullScreen();
  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle();
  }
}

void draw() {
  background(0);
  for (int i = 0; i < particles.length; i++) {
    particles[i].update();
  }
  thrust = 0;
}

void mouseWheel(MouseEvent event) {
  thrust = map(event.getCount(), -1, 1, 0.02, -0.02);
}