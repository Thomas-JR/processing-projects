class Asteroid {
  PVector pos;
  float angle, speed, radius;
  IntList r;
  int definement, type;

  Asteroid(int type_) {
    while (true) {
      pos = new PVector(random(width), random(height));
      if (dist(pos.x, pos.y, width/2, height/2) > 250)
        break;
    }
    type = type_;
    angle = random(360);
    speed = 2;
    r = new IntList(0);
    if (type == 2) {
      radius = 100;
      definement = 20;
    } else if (type == 1) {
      radius = 60;
      definement = 10;
    } else {
      radius = 30;
      definement = 5;
    }
    for (int i = 0; i < definement; i++) {
      if (random(definement) > definement-1)
        r.append(int(random(-50, -40)));
      else
        r.append(int(random(-10, 10)));
    }
  }

  void show() {
    noFill();
    stroke(255);
    pos.x += cos(radians(angle))*speed;
    pos.y += sin(radians(angle))*speed;

    if (pos.x < 0) pos.x += width;
    if (pos.x > width) pos.x -= width;
    if (pos.y < 0) pos.y += height;
    if (pos.y > height) pos.y -= height;

    float lx = pos.x + radius + r.get(0);
    float ly = pos.y;
    for (int i = 0; i < definement; i++) {
      float x = pos.x + cos(radians((360/definement)*i))*(radius+r.get(i));
      float y = pos.y + sin(radians((360/definement)*i))*(radius+r.get(i));
      line(x, y, lx, ly);
      lx = x;
      ly = y;
    }
    
    line(pos.x + radius + r.get(0), pos.y, lx, ly);
  }
}
