class Atom {
  float colour, size;
  PVector pos, mom;

  Atom() {
    pos = new PVector(random(width), random(height));
    mom = new PVector();
    size = random(10, 25);
    colour = random(255);
  }

  void forces() {
    for (Atom a : atoms) {
      if (a != this) {
        float r = sqrt(sq(pos.x - a.pos.x) + sq(pos.y + a.pos.y));
        float t = atan2(pos.y - a.pos.y, pos.x - a.pos.x);
        if (r != 0) {
          mom.x += cos(t) * -100/sq(r);
          mom.y += sin(t) * -100/sq(r);
        }
      }
    }
  }

  void update() {
    noStroke();
    fill(colour, 255, 255);
    pos.x += mom.x;
    pos.y += mom.y;
    //walls();
    ellipse(pos.x, pos.y, size, size);
  }

  void walls() {
    if (pos.x + abs(size)/2 > width) {
      pos.x -= 2*((pos.x+abs(size)/2)-width);
      mom.x = -mom.x;
    }
    if (pos.y + abs(size)/2 > height) {
      pos.y -= 2*((pos.y+abs(size)/2)-height);
      mom.y = -mom.y;
    }
    if (pos.x - abs(size)/2 < 0) {
      pos.x += 2*((pos.x-abs(size)/2));
      mom.x = -mom.x;
    }
    if (pos.y - abs(size)/2 < 0) {
      pos.y += 2*abs((pos.y-abs(size)/2));
      mom.y = -mom.y;
    }
  }
}
