Laser[] lasers = new Laser[240];
Asteroid[] asteroids = new Asteroid[500];
Explosion[] explosions = new Explosion[1000];
float x, y, o, a, degrees;
boolean lastPressed, shoot, win, go, update;
int total;
float speed = 10;
int level;
int difficulty;
int explosionSize = 10;
float shootSpeed = 5;
boolean traditional;
float opacity;

void setup() {
  frameRate(50);
  fullScreen();
  x = width/2;
  y = height/2;
  strokeWeight(5);
  rectMode(CENTER);
  update = true;
  go = false;
  for (int i = 0; i < lasers.length; i++) {
    lasers[i] = new Laser(0, 0, degrees, false);
  }
  for (int i = 0; i < asteroids.length; i++) {
    asteroids[i] = new Asteroid(false, false, 0, 0, 0, 0, 0, 0, 0);
  }
  for (int i = 0; i < explosions.length; i++) {
    explosions[i] = new Explosion(0, 0, false, 0, 0, 0);
  }
}

void draw() {
  noStroke();
  if (!go) {
    background(0);
    fill(255);
    textAlign(CENTER);
    textSize(120);
    text("ASTEROID", width/2, height/8);
    textSize(60);
    text("Hold left click to shoot or hold right click to move.", width/2, height/3);

    //Play Button
    if (mouseX >= width/3 && mouseX <= width-width/3 && mouseY >= height/2-50 && mouseY <= height/2+50) {
      fill(100);
      if (mousePressed) {
        level = 5;
        resetAsteroids();
        go = true;
        update = true;
      }
    } else
      fill(50);
    stroke(255);
    rect(width/2, height/2, width/3, 100);
    fill(255);
    text("PLAY", width/2, height/2+20);

    //Difficulty
    fill(50);
    stroke(255);
    rect(width/2, height-height/3, width/4, 100);
    if (mouseX >= width/2-width/24*4 && mouseX <= width/2-width/24*3 && mouseY >= height-height/3-50 && mouseY <= height-height/3+50) {
      fill(100);
      if (mousePressed && !lastPressed) {
        if (difficulty > 0)
          difficulty -= 1;
      }
    } else
      fill(50);
    rect(width/2-width/24*3.5, height-height/3, width/24, 100);
    if (mouseX <= width/2+width/24*4 && mouseX >= width/2+width/24*3 && mouseY >= height-height/3-50 && mouseY <= height-height/3+50) {
      fill(100);
      if (mousePressed && !lastPressed) {
        if (difficulty < 2)
          difficulty += 1;
      }
    } else
      fill(50);
    rect(width/2+width/24*3.5, height-height/3, width/24, 100);
    fill(255);
    text("<", width/2-width/24*3.5, height-height/3+20);
    text(">", width/2+width/24*3.5, height-height/3+20);
    if (difficulty == 0)
      text("EASY", width/2, height-height/3+20);
    else if (difficulty == 1)
      text("MEDIUM", width/2, height-height/3+20);
    else if (difficulty == 2)
      text("HARD", width/2, height-height/3+20);

    //Shot type Button
    if (mouseX >= width/3 && mouseX <= width-width/3 && mouseY >= height-height/6-50 && mouseY <= height-height/6+50) {
      fill(100);
      if (mousePressed && !lastPressed) {
        if (traditional)
          traditional = false;
        else
          traditional = true;
      }
    } else
      fill(50);
    stroke(255);
    rect(width/2, height-height/6, width/3, 100);
    fill(255);
    if (traditional)
      text("Traditional", width/2, height-height/6+20);
    else
      text("Power Play", width/2, height-height/6+20);
  } else {

    //Background
    background(0);

    if (update) {
      //Angle
      o = mouseY - y;
      a = mouseX - x;
      degrees = degrees(atan(o/a));
      if (mouseX < x)
        degrees += 180;

      //Make a new Laser
      if (traditional) {
        if (mousePressed && !lastPressed && (mouseButton == LEFT)) {
          for (int i = 0; i < lasers.length; i++) {
            if (lasers[i].on() == false) {
              lasers[i] = new Laser(x+cos(radians(degrees))*40, y+sin(radians(degrees))*40, degrees, true);
              break;
            } else {
              continue;
            }
          }
        }
      } else if (mousePressed && (mouseButton == LEFT) && total % (difficulty+1)*5 == 0) {
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

      //Update the Space Ship
      stroke(255);
      if (mousePressed && (mouseButton == RIGHT) && dist(x, y, mouseX, mouseY) > 10) {
        x += cos(radians(degrees))*speed;
        y += sin(radians(degrees))*speed;
      }

      //Update the asteroids
      for (int i = 0; i < asteroids.length; i++) {
        asteroids[i].update();
        asteroids[i].show();
        if (asteroids[i].on() && dist(x, y, asteroids[i].x, asteroids[i].y()) < asteroids[i].s()*2+20) {
          update = false;
        }
      }
    } else {
      for (int i = 0; i < asteroids.length; i++) {
        asteroids[i].show();
      }
      opacity += 5;
      textSize(124);
      textAlign(CENTER);
      fill(255);
      text("YOU LOSE", width/2, height/3);
      if (mouseX >= width/8*3 && mouseX <= width-width/8*3 && mouseY >= height/2-height/20 && mouseY <= height/2+height/20) {
        fill(150);
        if (mousePressed && !lastPressed && opacity >= 250) {
          update = true;
          x = width/2;
          y = height/2;
          for (int i = 0; i < level; i++) {
            resetAsteroids();
          }
        }
      } else
        fill(50);
      rect(width/2, height/2, width/4, height/10);
      fill(255);
      textSize(60);
      text("Retry", width/2, height/2+20);
      if (mouseX >= width/8*3 && mouseX <= width-width/8*3 && mouseY >= height-height/3-height/20 && mouseY <= height-height/3+height/20) {
        fill(150);
        if (mousePressed && !lastPressed) {
          go = false;
          level = 10;
          x = width/2;
          y = height/2;
          resetAsteroids();
        }
      } else
        fill(50);
      rect(width/2, height-height/3, width/4, height/10);
      fill(255);
      text("Exit", width/2, height-height/3+20);
    }

    spaceShip(x, y, degrees);

    int score = 0;
    for (int i = 0; i < asteroids.length; i++) {
      if (asteroids[i].on() == false)
        score += 1;
      if (score >= asteroids.length) {
        textSize(124);
        textAlign(CENTER);
        fill(255);
        text("YOU WIN!", width/2, height/3);
        win = true;
      }
    }

    if (win) {
      textSize(60);
      textAlign(CENTER);
      fill(50);
      if (mouseX >= width/8*3 && mouseX <= width-width/8*3 && mouseY >= height/2-height/20 && mouseY <= height/2+height/20) {
        fill(150);
        if (mousePressed && !lastPressed) {
          if (traditional)
            level += 3;
          else
            level += 5;
          x = width/2;
          y = height/2;
          for (int i = 0; i < lasers.length; i++)
            lasers[i] = new Laser(0, 0, 0, false);
          resetAsteroids();
        }
      } else
        fill(50);
      rect(width/2, height/2, width/4, height/10);
      fill(255);
      text("Continue", width/2, height/2+20);
      if (mouseX >= width/8*3 && mouseX <= width-width/8*3 && mouseY >= height-height/3-height/20 && mouseY <= height-height/3+height/20) {
        fill(150);
        if (mousePressed && !lastPressed) {
          level = 5;
          go = false;
        }
      } else
        fill(50);
      rect(width/2, height-height/3, width/4, height/10);
      fill(255);
      text("Exit", width/2, height-height/3+20);
    }

    //Explode the asteroids
    for (int i = 0; i < explosions.length; i++) {
      explosions[i].update();
    }

    //Update global variables
    total += 1;
    win = false;
  }
  int p = 0;
  for (int i = 0; i < asteroids.length; i++) {
    if (asteroids[i].on() == true)
      p += 1;
  } 
  lastPressed = mousePressed;
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

void resetAsteroids() {
  for (int i = 0; i < asteroids.length; i++) {
    asteroids[i] = new Asteroid(false, false, 0, 0, 0, 0, 0, 0, 0);
  }
  for (int i = 0; i < level; i++) {
    asteroids[i] = new Asteroid(true, false, 0, 0, 0, 0, 0, 0, 0);
  }
}

class Asteroid {
  float x, y, degrees, size, r, g, b;
  boolean active;

  Asteroid(boolean act, boolean clone, float xPos, float yPos, float deg, float s, float red, float green, float blue) {
    active = act;
    if (!clone) {
      x = random(width);
      y = random(height);
      while (dist(x, y, width/2, height/2) <= 300) {
        x = random(width);
        y = random(height);
      }
      degrees = random(360);
      size = random(2, 6);
      size = int(size);
      r = random(255);
      g = random(255);
      b = random(255);
    } else {
      x = xPos;
      y = yPos;
      degrees = deg;
      size = s;
      r = red;
      g = green;
      b = blue;
    }
  }

  void update() {
    if (active) {
      x += cos(radians(degrees))*(-size+8+(difficulty+1));
      y += sin(radians(degrees))*(-size+8+(difficulty+1));
      if (x <= 0)
        x = width;
      else if (x >= width)
        x = 0;
      if (y <= 0)
        y = height;
      else if (y >= height)  y = 0;
    }
  }

  void show() {
    if (active) {
      fill(r, g, b);
      stroke(255);
      ellipse(x, y, PI*(sq(size*2)), PI*(sq(size*2)));
    }
  }

  void halve() {
    size -= 1;
    if (size < 2) {
      active = false;
    } else {
      int score = 0;
      for (int i = 0; i < asteroids.length; i++) {
        if (asteroids[i].on() == false && score < 1) {
          asteroids[i] = new Asteroid(true, true, x, y, random(360), size, r, g, b);
          score += 1;
        }
      }
    }
  }

  boolean on() {
    return active;
  }

  float x() {
    return x;
  }

  float y() {
    return y;
  }

  float s() {
    return PI*sq(size);
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
      x += cos(radians(degrees))*20;
      y += sin(radians(degrees))*20;
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
        if (asteroids[i].on() && dist(x, y, asteroids[i].x(), asteroids[i].y()) < asteroids[i].s()*2) {
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
