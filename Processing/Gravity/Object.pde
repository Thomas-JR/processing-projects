class Object {
  PVector pos, momentum;
  float radius, mass, targetMass, r, g, b, phi;
  boolean active;
  int position;

  Object(boolean active_, float x_, float y_, float mx_, float my_, float mass_, int position_) {
    position = position_;
    active = active_;
    pos = new PVector(x_, y_);
    momentum = new PVector(-mx_/50, -my_/50);
    mass = 1;
    targetMass = mass_;
    r = random(255);
    g = random(r/2);
    if (g > r/4)
      g += r/2  ;
    b = 255-r-g;
  }

  void update() {
    //Gravity
    for (int i = 0; i < objects.length; i++) {
      if (objects[i].active && i != position && pos.x != objects[i].pos.x) {
        float force = (gravity * sqrt(targetMass/PI)*sqrt(objects[i].targetMass/PI)/sq(dist(pos.x, pos.y, objects[i].pos.x, objects[i].pos.y)))/mass;
        momentum.x += cos(atan2(objects[i].pos.y-pos.y, objects[i].pos.x-pos.x))*force;
        momentum.y += sin(atan2(objects[i].pos.y-pos.y, objects[i].pos.x-pos.x))*force;
      }
    }

    //Walls
    if (pos.x <= radius) {
      pos.x = radius;
      momentum.x =- momentum.x;
    }
    if (pos.x >= width-radius) {
      pos.x = width-radius;
      momentum.x =- momentum.x;
    }
    if (pos.y <= radius) {
      pos.y = radius;
      momentum.y =- momentum.y;
    }
    if (pos.y >= height-radius) {
      pos.y = height-radius;
      momentum.y =- momentum.y;
    }

    //Collision
    for (int i = 0; i < objects.length; i++) {
      if (objects[i].active && i != position && mass >= objects[i].mass) {
        if (dist(pos.x, pos.y, objects[i].pos.x, objects[i].pos.y) <= radius) {
          targetMass += objects[i].targetMass;
          objects[i] = new Object (false, 0, 0, 0, 0, 0, i);
        }
      }
    }

    //if (targetMass >= 1000)
    //  objects[position] = new Object(false, 0, 0, 0, 0, 0, position);

    //Momentum
    pos.x += momentum.x;
    pos.y += momentum.y;

    //Balls
    //mass = lerp(mass, targetMass, 0.01);
    mass = targetMass;
    radius = sqrt(mass/PI);
    fill(r, g, b);
    noStroke();
    ellipse(pos.x-width/2, pos.y-height/2, radius*2, radius*2);
  }
}
