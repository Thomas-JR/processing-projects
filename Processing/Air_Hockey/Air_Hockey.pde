Ball[] balls = new Ball[1];
PVector gravity, mouse;
float radius = 100;
float speed = 10;
Puck pucky = new Puck(radius/2);

void setup() {
  fullScreen();
  mouse = new PVector(mouseX, mouseY);
  gravity = new PVector(0, 0);
  for (int i = 0; i < balls.length; i++) {
    balls[i] = new Ball(random(radius, width-radius), random(radius, height-radius), radius, i);
  }
}

void draw() {
  background(100, 200, 255);
  mouse = new PVector(mouseX, mouseY);
  for (Ball b1 : balls) {
    if (dist(pucky.pos.x, pucky.pos.y, b1.pos.x, b1.pos.y) <= pucky.radius + radius)
      b1.puckCollision(pucky);
    for (Ball b2 : balls) {
      if (b2 != b1 && dist(b1.pos.x+b1.vel.x, b1.pos.y+b1.vel.y, b2.pos.x+b2.vel.x, b2.pos.y+b2.vel.x) <= b1.radius + b2.radius)
        b1.ballCollision(b2);
    }
  }
  pucky.update();
  for (Ball b1 : balls) {
    b1.update();
  }
}