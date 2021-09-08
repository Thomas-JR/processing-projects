Ball[] balls = new Ball[2];
boolean stopped, lastPressed;

void setup() {
  size(1200, 600);
  for (int i = 0; i < balls.length; i++) {
    balls[i] = new Ball(i);
  }
}

void draw() {
  background(100, 200, 150);
  stopped = true;
  for (int i = 0; i < balls.length; i++) {
    if (balls[i].speed > 0.1)
      stopped = false;
  }
  for (int i = 0; i < balls.length; i++) {
    balls[i].update();
  }
}




class Ball {
  float x, y, degrees, radius, speed;
  float r, g, b;
  int pos;

  Ball(int pos_) {
    pos = pos_;
    radius = 20;
    x = random(radius, width-radius);
    y = random(radius, height-radius);
    if (pos == 0) {
      r = g = b = 255;
      x = width/4;
      y = height/2;
    } else {
      r = random(255);
      g = random(255);
      b = random(255);
    }
  }

  void update() {
    //Friction
    if (speed > 0)
      speed -= 0.1;
    if (speed < 0.1)
      speed =0;

    //Cue code
    if (stopped && pos == 0) {
      float draw = constrain(dist(x, y, mouseX, mouseY), radius, 250);
      float deg = degrees(atan2(mouseY-y, mouseX-x));
      if (deg < 0)
        deg = map(deg, 0, -180, 360, 180);
      strokeWeight(6);
      stroke(150, 250, 100);
      line(x+cos(radians(deg+180))*(draw+300), y+sin(radians(deg+180))*(draw+300), x+cos(radians(deg+180))*draw, y+sin(radians(deg+180))*draw);
      if (mousePressed &! lastPressed) {
        speed = draw/10;
        degrees = deg;
      }
    }

    //Ball collisions
    for (int i = 0; i < balls.length; i++) {
      if (i != pos && dist(x, y, balls[i].x, balls[i].y) <= radius + balls[i].radius) {
        degrees = collision(degrees, degrees(atan2(y-balls[i].y, x-balls[i].x))+180);
        balls[i].degrees = degrees(atan2(y-balls[i].y, x-balls[i].x))+180;
        float power = degrees(atan2(y-balls[i].y, x-balls[i].x))+180;
        if (power < 0)
          power += 1;
        if (pos == 0)
          println(power);
        //degrees = collision(degrees, degrees(atan2(y-balls[i].y, x-balls[i].x))+180);
      }
    }

    //Wall collisions
    if (x <= radius) {
      degrees = collision (degrees, 90);
      x = radius;
    }
    if (x >= width-radius) {
      degrees = collision (degrees, 270);
      x = width-radius;
    }
    if (y <= radius) {
      degrees = collision (degrees, 360);
      y = radius;
    }
    if (y >= height-radius) {
      degrees = collision (degrees, 0);
      y = height-radius;
    }
    
    //degrees corretion
    if (degrees < 0)
      degrees += 360;
    else if (degrees > 360)
      degrees -= 360;
    if (pos == 0)
      //println(degrees);

    //Update ball
    x += cos(radians(degrees))*speed;
    y += sin(radians(degrees))*speed;
    noStroke();
    fill(r, g, b);
    ellipse(x, y, radius*2, radius*2);
  }
}

float collision(float degrees, float mirror) {
  float b = degrees-mirror;
  float c = mirror + 180 +(180-b);
  return c;
}