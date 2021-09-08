class Shooter {
  PVector pos, mom, pos1;
  float rotation, size, girth;
  boolean thrust, left, right, alive;

  Shooter() {
    alive = true;
    pos = new PVector(width/2, height/2);
    mom = new PVector();
    pos1 = new PVector();
    size = 40;
    girth = 145;
  }

  void update() {
    if (left) rotation -= 4;
    if (right) rotation += 4;
    if (thrust) {
      mom.x += cos(radians(rotation))/4;
      mom.y += sin(radians(rotation))/4;
    } else {
      mom.x *= 0.98;
      mom.y *= 0.98;
    }
    if (pos.x < 0) pos.x += width;
    if (pos.x > width) pos.x -= width;
    if (pos.y < 0) pos.y += height;
    if (pos.y > height) pos.y -= height;
    pos.add(mom);
  }

  void show() {
    PVector pos2, pos3, pos4, pos5;
    pos1 = new PVector(pos.x+cos(radians(rotation))*size, pos.y+sin(radians(rotation))*size);
    pos2 = new PVector(pos.x+cos(radians(rotation + girth))*size, pos.y+sin(radians(rotation + girth))*size);
    pos3 = new PVector(pos.x+cos(radians(rotation - girth))*size, pos.y+sin(radians(rotation - girth))*size);
    pos4 = new PVector(pos.x+cos(radians(rotation + 180))*size*0.55, pos.y+sin(radians(rotation + 180))*size*0.55);
    pos5 = new PVector(pos.x+cos(radians(rotation + 180))*size*1.3, pos.y+sin(radians(rotation + 180))*size*1.3);
    stroke(255);
    strokeWeight(2);
    line(pos1.x, pos1.y, pos2.x, pos2.y);
    line(pos1.x, pos1.y, pos3.x, pos3.y);
    float foo = 10;
    line(pos.x+cos(radians(rotation + girth))*size*2/3, pos.y+sin(radians(rotation + girth))*size*2/3, pos.x+cos(radians(rotation - girth))*size*2/3, pos.y+sin(radians(rotation - girth))*size*2/3);
    if (thrust && random(10) > 4) {
      line(pos4.x+cos(radians(rotation+90))*foo, pos4.y+sin(radians(rotation+90))*foo, pos5.x, pos5.y);
      line(pos4.x+cos(radians(rotation-90))*foo, pos4.y+sin(radians(rotation-90))*foo, pos5.x, pos5.y);
    }
    
    for (Asteroid asteroid : asteroids) {
      if (dist(asteroid.pos.x, asteroid.pos.y, pos.x, pos.y) < asteroid.radius + 40) {
        alive = false;
        for (Fragment fragment : fragments)
          fragment.startup(pos, mom, rotation);
        break;
      }
    }
  }
}
