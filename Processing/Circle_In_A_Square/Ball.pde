class Ball {
  PVector pos, mom;
  float speed, direction, radius;
  int ID;
  float r, b;

  Ball(int ID_) {
    pos = new PVector(width/2, height/2);
    mom = new PVector();
    speed = 1;
    radius = 5;
    ID = ID_;
    direction = (2*PI/total) * ID+PI/4;
    mom.x = cos(direction);
    mom.y = sin(direction);
  }

  void update() {
    speed = map(mouseX, 0, width, 1, 10);
    pos.x += mom.x*speed;
    pos.y += mom.y*speed;
    mom.y += 0.0;
  }

  void show() {
    fill(255);
    noStroke();
    //ellipse(pos.x, pos.y, 5, 5);
    stroke(colour, 255, 255);
    strokeWeight(5);
    if (ID == balls.length-1)
      line(pos.x, pos.y, balls[0].pos.x, balls[0].pos.y);
    if (ID > 0) {
      line(pos.x, pos.y, balls[ID-1].pos.x, balls[ID-1].pos.y);
    }
  }

  void borders() {
    if (pos.x < radius) {
      mom.x *= -1;
      pos.x = abs(pos.x);
    }
    if (pos.x > width-radius) {
      mom.x *= -1;
      pos.x = width - (pos.x-width);
    }
    if (pos.y < radius) {
      mom.y *= -1;
      pos.y = abs(pos.y);
    }
    if (pos.y > height-radius) {
      mom.y *= -1;
      pos.y = height - (pos.y - height);
    }
    pos.x = constrain(pos.x, radius, width-radius);
    pos.y = constrain(pos.y, radius, width-radius);
    //pos.x += random(-0.5,0.5) *speed;
    //pos.y += random(-0.5,0.5) *speed;
  }
}
