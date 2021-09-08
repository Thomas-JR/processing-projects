
Ball[] balls = new Ball[1000];

void setup() {
  fullScreen();
  for (int i = 0; i < balls.length; i++) {
    balls[i] = new Ball(i);
  }
  noStroke();
}

void draw() {
  background(255);
  for (int i = 0; i < balls.length; i++) {
    balls[i].update();
  }
  println(degrees(atan2(balls[0].y-balls[1].y, balls[0].x-balls[1].x)));
}

class Ball {
  float x, y, speed, degrees, radius;
  int pos;
  float g;

  Ball(int pos_) {
    pos = pos_;
    radius = 30;
    x = random(radius, width-radius);
    y = random(radius, height-radius);
    degrees = random(360);
    speed = 1;
    g = random(255);
  }

  void update() {
    x += cos(radians(degrees)) * speed;
    y += sin(radians(degrees)) * speed;
    walls();
    for (int i = 0; i < balls.length; i++) {
      if (i != pos && dist(x, y, balls[i].x, balls[i].y) <= radius + balls[i].radius) {
        collision(degrees(atan2(y-balls[i].y, x-balls[i].x))+180);
        balls[i].degrees = degrees(atan2(y-balls[i].y, x-balls[i].x));
      }
    }
    fill(0, map(g, 0, 255, 100, 200), 0);
    ellipse(x, y, radius*2, radius*2);
  }

  void collision(float a) {
    float b = degrees-a;
    float c = a + (180-b);
    if (c < 0)
      c += 360;
    else if (c > 360)
      c -= 360;
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