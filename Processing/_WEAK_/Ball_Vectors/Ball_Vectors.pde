Ball[] balls = new Ball[100];

void setup() {
  fullScreen();
  for (int i = 0; i < balls.length; i++) {
    balls[i] = new Ball(i);
  }
  fill(200);
  stroke(0);
}

void draw() {
  background(255);
  for (int i = 0; i < balls.length; i++) {
    balls[i].update();
  }
}

class Ball {
  float x, y, speed, degrees, radius;
  int pos;

  Ball(int pos_) {
    pos = pos_;
    radius = 15;
    x = random(radius, width-radius);
    y = random(radius, height-radius);
    degrees = random(360);
    speed = 0.1;
  }

  void update() {
    speed = int(map(mouseY, 0, height, 100, 0));
    x += cos(radians(degrees)) * speed;
    y += sin(radians(degrees)) * speed;
    walls();
    for (int i = 0; i < balls.length; i++) {
      if (i != pos && dist(x, y, balls[i].x, balls[i].y) <= radius + balls[i].radius) {
        collision(degrees(atan2(y-balls[i].y, x-balls[i].x))+180);
        balls[i].degrees = degrees(atan2(y-balls[i].y, x-balls[i].x))+180;
      }
    }
    if (pos == 0)
      fill(0);
    ellipse(x, y, radius*2, radius*2);
    fill(200);
  }

  void collision(float a) {
    float b = degrees-a;
    float c = a + (180-b);
    degrees = c;
  }

  void walls() {
    if (x <= radius)
      degrees = flip(degrees, 270);
    if (x >= width-radius)
      degrees = flip(degrees, 90);
    if (y <= radius)
      degrees = flip(degrees, 180);
    if (y >= height-radius)
      degrees = flip(degrees, 0);
  }
}

float flip(float d, float r) {
  if (r > 360)
    r -= 360;
  if (r < 0)
    r += 360;
  d -= r;
  d = r+(360-d);
  if (d > 360)
    d -= 360;
  if (d < 0)
    d += 360;
  return d;
}
