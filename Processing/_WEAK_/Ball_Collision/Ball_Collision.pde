Ball[] balls = new Ball[30];
PVector gravity;
float radius = 50;
float speed = 2;

void setup() {
  fullScreen();
  gravity = new PVector(0, 0);
  for (int i = 0; i < balls.length; i++) {
    balls[i] = new Ball(random(radius, width-radius), random(radius, height-radius), random(radius/2, radius), i);
  }
  //colorMode(HSB);
  textSize(24);
  //noStroke();
}

void draw() {
  background(0);
  for (Ball b1 : balls) {
    for (Ball b2 : balls) {
      if (b2 != b1 && dist(b1.pos.x, b1.pos.y, b2.pos.x, b2.pos.y) <= b1.radius + b2.radius)
        b1.ballCollision(b2);
    }
  }
  for (Ball b : balls) {
    b.update();
  }
}
