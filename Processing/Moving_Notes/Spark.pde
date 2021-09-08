class Spark {
  PVector pos, mom;
  float size, alive, g;
  
  Spark(float alive_, float x_, float y_) {
    alive = alive_;
    pos = new PVector(x_, y_);
    size = 5;
    float angle = random(90, 270);
    float vel = random(state.speed*0.5, state.speed*1.5);
    mom = new PVector(cos(radians(angle))*vel, sin(radians(angle))*vel);
    g = random(0, 100);
  }
  
  void update() {
    pos.add(mom);
    alive -= 5;
  }
  
  void show() {
    fill(255, g, 0, alive);
    noStroke();
    ellipse(pos.x, pos.y, size, size);
  }
}
