Ball[] balls = new Ball[3];

void setup() {
  size(1000, 300);
  balls[0] = new Ball(width/4, height/2, 0);
  balls[1] = new Ball(width/4*3, height/2, 1);
  balls[2] = new Ball(width/2, height/2, 2);
}

void draw() {
  background(255);
  balls[0].update();
  balls[1].update();
  balls[2].update();
}

class Ball {
  float x, y, degrees, mass, radius, force;
  int pos;

  Ball(float x_, float y_, int position_) {
    x = x_;
    y = y_;
    degrees = random(360);
    radius = 50;
    mass = sq(PI*radius);
    force = 500000;
    pos = position_;
    if (pos == 1) {
      force = 50000;
    }
    if (pos == 2) {
      force = 250000;
    }
    else {
      degrees = random(0, 45);
    }
  }

  void update() {
    //Walls
    if (x <= radius) {
      x = radius;
      degrees = collision(90, degrees);
    }
    if (x >= width-radius) {
      x = width-radius;
      degrees = collision(270, degrees);
    }
    if (y <= radius) {
      y = radius;
      degrees = collision(180, degrees);
    }
    if (y >= height-radius) {
      y = height-radius;
      degrees = collision(0, degrees);
    }
    
    //Ball Collision
    for (int i = 0; i < balls.length; i++) {
      if (i != pos && dist(x, y, balls[i].x, balls[i].y) <= radius + balls[i].radius) {
        degrees = collision(atan((y-balls[i].y)/(x-balls[i].x))+90, degrees);
        float f = balls[i].force;
        balls[i].force = force;
        force = f;
      }
    }

    x += cos(radians(degrees)) * (force/mass);
    y += sin(radians(degrees)) * (force/mass);
    
    ellipse(x, y, radius*2, radius*2);
  }
}


float collision(float reflection_, float degrees_) {
  float angle = reflection_ - degrees_;
  angle = reflection_ + angle;
  if (angle < 0)
    angle += 360;
  if (angle > 360)
    angle -= 360;
  return angle;
}