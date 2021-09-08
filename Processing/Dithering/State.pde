class Game {
  PImage img;

  Game() {
  }
}

class Point {
  PVector pos, vel;
  float r, g, b;
  float shade;

  Point(int x_, int y_, float r_, float g_, float b_) {
    r = r_;
    g = g_;
    b = b_;
    pos = new PVector(width/58*x_, height/58*y_);
    //MISTAKE
    //float angle = degrees(atan2(height/2-y_, width/2-x_));
    float angle = atan2(height/60*y_-height/2, width/60*x_-width/2);
    vel = new PVector(-cos(angle), -sin(angle));
    shade = map(r + g + b, 0, 255*3, 0, 255);
  }

  void show() {
    //fill(random(255));
    if (go)
      pos.add(vel);
    if (type != 0)
      fill(0);
    else
      fill(shade);
    fill(r, g, b);
    rectMode(CENTER);
    if (type == 1)
      ellipse(pos.x, pos.y, map(shade, 0, 255, 24, 6), map(shade, 0, 255, 24, 6));
    else if (type == 2)
      rect(pos.x, pos.y, map(shade, 0, 255, 24, 6), map(shade, 0, 255, 24, 6));
    else
      ellipse(pos.x, pos.y, 22, 22);
  }

  void update() {
  }
}