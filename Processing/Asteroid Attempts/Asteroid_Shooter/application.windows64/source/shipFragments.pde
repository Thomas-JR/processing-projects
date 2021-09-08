class Fragment {
  PVector pos, mom;
  float size, rotation;
  boolean active;

  Fragment() {
    size = 3;
  }

  void startup(PVector pos_, PVector mom_, float rotation_) {
    rotation = rotation_;
    pos = pos_;
    mom = mom_;
    mom.x += random(-1, 1);
    mom.y += random(-1, 1);
    active = true;
  }

  void update() {
    ellipse(pos.x, pos.y, size, size);
    pos.x += cos(radians(rotation));
    pos.y += sin(radians(rotation));
  }
}
