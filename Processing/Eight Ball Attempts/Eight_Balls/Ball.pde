class Ball {
  float x, y, degrees, speed, radius;
  boolean cue;
  float r, g, b;
  int pos;

  Ball(boolean a_, int pos_, float x_, float y_) {
    cue = a_;
    pos = pos_;
    x = x_;
    y = y_;
    radius = 20;
    if (!cue) {
      r = random(255);
      g = random(255);
      b = random(255);
    } else {
      r = 255;
      g = 255;
      b = 255;
    }
  }

  void update() {
    //Friction
    if (speed > 0)
      speed -= 0.1;
    if (speed < 0)
      speed = 0;
    else if (speed < 0.2) {
      stroke(200, 200, 50);
      strokeWeight(5);
      if (cue)
        line(x+cos(radians(degrees+180))*power, y+sin(radians(degrees+180))*power, x+cos(radians(degrees+180))*(power+250), y+sin(radians(degrees+180))*(power+250));
      speed = 0;
    }


    for (int i = 0; i < balls.length; i++) {
      if (i != pos && dist(x, y, balls[i].x, balls[i].y) <= radius + balls[i].radius) {
        collision(degrees(atan2(y-balls[i].y, x-balls[i].x))+180);
        balls[i].degrees = degrees(atan2(y-balls[i].y, x-balls[i].x))+180;
        checked.append(i);
        checked.append(this.pos);
      }
    }

    //Move
    x += cos(radians(degrees))*speed;
    y += sin(radians(degrees))*speed;
    
    //Hit a side
    walls();

    //Draw
    noStroke();
    fill(r, g, b);
    ellipse(x, y, radius*2, radius*2);
  }

  void walls() {
    if (degrees >= 360)
      degrees -= 360;
    if (degrees <= 0)
      degrees += 360;

    if (x <= -tHor/2+radius/2) {
      x = -tHor/2+radius;
      if (degrees >= 180)
        degrees = map(degrees, 180, 270, 360, 270);
      else
        degrees = map(degrees, 180, 90, 0, 90);
    }
    if (x >= tHor/2-radius) {
      x = tHor/2-radius;
      if (degrees >= 270)
        degrees = map(degrees, 270, 360, 270, 180);
      else
        degrees = map(degrees, 0, 90, 180, 90);
    }

    if (y <= -tVer/2+radius) {
      y = -tVer/2+radius;
      degrees = map(degrees, 180, 360, 180, 0);
    }
    if (y >= tVer/2-radius) {
      y = tVer/2-radius;
      degrees = map(degrees, 0, 180, 360, 180);
    }
  }

  void collision(float a) {
    float b = degrees-a;
    float c = a + (180-b);
    if (c < 0)
      c += 360;
    else if (c > 360)
      c -= 360;
    degrees = c+180;
  }
}