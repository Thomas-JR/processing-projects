Laser[] lasers = new Laser[240];
Asteroid[] asteroids = new Asteroid[20];
Explosion[] explosions = new Explosion[1000];
float x, y, o, a, degrees;
float speed = 10;
boolean lastPressed, shoot;
int total;
int explosionSize = 50;

void setup() {
  size(displayWidth, 1000);
  x = width/2;
  y = height/2;
  strokeWeight(5);
  for (int i = 0; i < lasers.length; i++) {
    lasers[i] = new Laser(0, 0, degrees, false);
  }
  for (int i = 0; i < asteroids.length; i++) {
    asteroids[i] = new Asteroid();
  }
  for (int i = 0; i < explosions.length; i++) {
    explosions[i] = new Explosion(0, 0, false, 0, 0, 0);
  }
}

void draw() {
  //Background and angle
  background(0);
  o = mouseY - y;
  a = mouseX - x;
  degrees = degrees(atan(o/a));
  if (mouseX < x)
    degrees += 180;

  //Make a new Laser
  if (mousePressed && (mouseButton == LEFT) && total % 5 == 0) {
    for (int i = 0; i < lasers.length; i++) {
      if (lasers[i].on() == false) {
        lasers[i] = new Laser(x+cos(radians(degrees))*40, y+sin(radians(degrees))*40, degrees, true);
        break;
      } else {
        continue;
      }
    }
  }

  //Update the lasers
  for (int i = 0; i < lasers.length; i++) {
    lasers[i].update();
  }

  //Make the Space Ship
  stroke(255);
  if (mousePressed && (mouseButton == RIGHT)) {
    x += cos(radians(degrees))*speed;
    y += sin(radians(degrees))*speed;
  }
  spaceShip(x, y, degrees);

  //Update the asteroids
  for (int i = 0; i < asteroids.length; i++) {
    asteroids[i].update();
    if (asteroids[i].active()) {
      if (dist(x, y, asteroids[i].x, asteroids[i].y()) < asteroids[i].s()*2+20) {
        textSize(124);
        textAlign(CENTER);
        text("YOU LOSE", width/2, height/2);
        noLoop();
      }
    }
  }
  
  //Explode the aseroids
  for (int i = 0; i < explosions.length; i++) {
    explosions[i].update();
  }

  //Update global variables
  lastPressed = mousePressed;
  total += 1;
}

void spaceShip(float x, float y, float degrees) {
  line(x+cos(radians(degrees-120))*30, y+sin(radians(degrees-120))*30, x+cos(radians(degrees))*40, y+sin(radians(degrees))*40);
  line(x+cos(radians(degrees+120))*30, y+sin(radians(degrees+120))*30, x+cos(radians(degrees))*40, y+sin(radians(degrees))*40);
  line(x+cos(radians(degrees-120))*30, y+sin(radians(degrees-120))*30, x+cos(radians(degrees+120))*30, y+sin(radians(degrees+120))*30);
}

void explode(float x, float y, float r, float g, float b) {
  int total = 0;
  for (int i = 0; i < explosions.length; i++) {
    if (explosions[i].on() == false) {
      explosions[i] = new Explosion(x, y, true, r, g, b);
      total += 1;
      if (total > explosionSize)
        break;
    }
  }
}

class Asteroid {
  float x, y, degrees, speed, size, r, g, b;
  boolean active = true;

  Asteroid() {
    x = random(width);
    y = random(height);
    while (dist(x, y, width/2, height/2) <= 200) {
      x = random(width);
      y = random(height);
    }

    degrees = random(360);
    speed = random(1, 5);
    size = random(2, 6);
    size = int(size);
    r = random(255);
    g = random(255);
    b = random(255);
  }

  void update() {
    if (active) {
      fill(r, g, b);
      stroke(255);
      x += cos(radians(degrees))*speed;
      y += sin(radians(degrees))*speed;
      if (x <= 0)
        x = width;
      else if (x >= width)
        x = 0;
      if (y <= 0)
        y = height;
      else if (y >= height)  y = 0;
      ellipse(x, y, PI*(sq(size*2)), PI*(sq(size*2)));
    }
  }

  void halve() {
    size -= 1;
    if (size < 2) {
      size = 0;
      active = false;
    }
  }

  float x() {
    return x;
  }
  float y() {
    return y;
  }
  float s() {
    return PI*(sq(size));
  }
  boolean active() {
    return active;
  }
  float r() {
    return r;
  }
  float g() {
    return g;
  }
  float b() {
    return b;
  }
}

class Explosion {
  float x, y, degrees, speed, shade, r, g, bl;
  boolean active;

  Explosion(float a, float b, boolean c, float d, float e, float f) {
    x = a;
    y = b;
    speed = random(10);
    degrees = random(360);
    active = c;
    r = d;
    g = e;
    bl = f;
    shade = 255;
  }

  void update() {
    if (active) {
      x += cos(radians(degrees)) * speed;
      y -= sin(radians(degrees)) * speed;
      
      fill(r, g, bl, shade);
      noStroke();
      ellipse(x, y, 5, 5);
      shade -= 5;
    }
    if (shade <= 0)
      active = false;
  }

  boolean on() { 
    return active;
  }
}
class Laser {
  float x, y, degrees, lastX, lastY;
  int total;
  boolean active;

  Laser (float a, float b, float c, boolean d) {
    x = a;
    y = b;
    degrees = c;
    noStroke();
    active = d;
  }

  void update() {
    if (active) {
      x += cos(radians(degrees))*10;
      y += sin(radians(degrees))*10;
      strokeWeight(5);
      if (total > 0)
        stroke(255, 0, 0);
      else noStroke();
      line(x, y, lastX, lastY);
      lastX = x;
      lastY = y;
      total += 1;
      //Explode the asteroids
      for (int i = 0; i < asteroids.length; i++) {
        if (dist(x, y, asteroids[i].x(), asteroids[i].y()) < asteroids[i].s()*2) {
          asteroids[i].halve();
          active = false;
          explode(asteroids[i].x(), asteroids[i].y(), asteroids[i].r(), asteroids[i].g(), asteroids[i].b());
        }
      }
    }
    if (x < 0 || x > width || y < 0 || y > height) {
      active = false;
    }
  }

  boolean on() { 
    return active;
  }
}