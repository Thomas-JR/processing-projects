import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Asteroid_Shooter extends PApplet {

Shooter shooter;
Shot[] shots = new Shot[100];
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
Fragment[] fragments = new Fragment [1];

public void setup() {
  
  shooter = new Shooter();
  for (int i = 0; i < shots.length; i++)
    shots[i] = new Shot();
  for (int i = 0; i < 6; i++)
    asteroids.add(new Asteroid(2));
  for (int i = 0; i < fragments.length; i++)
    fragments[i] = new Fragment();
  background(0);
}

public void draw() {
  fill(0, 30);
  rect(0, 0, width, height);
  background(0);
  if (shooter.alive) {
    shooter.update();
    shooter.show();
  }
  for (Shot s : shots) {
    if (s.active) {
      s.show();
    }
  }
  for (int i = 0; i < asteroids.size(); i++) {
    asteroids.get(i).show();
  }
  if (fragments[0].active) {
    for (Fragment fragment : fragments)
      fragment.update();
  }
}
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
        r.append(PApplet.parseInt(random(-50, -40)));
      else
        r.append(PApplet.parseInt(random(-10, 10)));
    }
  }

  public void show() {
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

  public void update() {
    if (left) rotation -= 4;
    if (right) rotation += 4;
    if (thrust) {
      mom.x += cos(radians(rotation))/4;
      mom.y += sin(radians(rotation))/4;
    } else {
      mom.x *= 0.98f;
      mom.y *= 0.98f;
    }
    if (pos.x < 0) pos.x += width;
    if (pos.x > width) pos.x -= width;
    if (pos.y < 0) pos.y += height;
    if (pos.y > height) pos.y -= height;
    pos.add(mom);
  }

  public void show() {
    PVector pos2, pos3, pos4, pos5;
    pos1 = new PVector(pos.x+cos(radians(rotation))*size, pos.y+sin(radians(rotation))*size);
    pos2 = new PVector(pos.x+cos(radians(rotation + girth))*size, pos.y+sin(radians(rotation + girth))*size);
    pos3 = new PVector(pos.x+cos(radians(rotation - girth))*size, pos.y+sin(radians(rotation - girth))*size);
    pos4 = new PVector(pos.x+cos(radians(rotation + 180))*size*0.55f, pos.y+sin(radians(rotation + 180))*size*0.55f);
    pos5 = new PVector(pos.x+cos(radians(rotation + 180))*size*1.3f, pos.y+sin(radians(rotation + 180))*size*1.3f);
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
class Shot {
  PVector pos, dir;
  boolean active;
  float speed;
  int life;

  Shot() {
    speed = 20;
    dir = new PVector();
  }

  public void show() {
    for (int i = 0; i < asteroids.size(); i++) {
      if (dist(asteroids.get(i).pos.x, asteroids.get(i).pos.y, pos.x, pos.y) < asteroids.get(i).radius + 30) {
        active = false;
        asteroids.remove(i);
        for (int j = 0; j < 2; j++) {
          asteroids.add(new Asteroid(asteroids.get(j).type-1));
          asteroids.get(j).pos = asteroids.get(i).pos;
        }
      }
    }

    fill(255);
    ellipse(pos.x, pos.y, 5, 5);

    pos.x += dir.x*speed;
    pos.y += dir.y*speed;
    if (pos.x < 0) pos.x += width;
    if (pos.x > width) pos.x -= width;
    if (pos.y < 0) pos.y += height;
    if (pos.y > height) pos.y -= height;
    life --;
    if (life <= 0)
      active = false;
  }

  public void startShot(PVector pos_) {
    pos = pos_;
    life = 100;
    active = true;
  }
}
public void shootThingo() {
  for (Shot s : shots) {
    if (!s.active) {
      s.startShot(shooter.pos1);
      s.dir = new PVector(cos(radians(shooter.rotation)), sin(radians(shooter.rotation)));
      return;
    }
  }
}

public void keyPressed() {
  switch (keyCode) {
  case UP:
    shooter.thrust = true;
    break;
  case LEFT:
    shooter.left = true;
    break;
  case RIGHT:
    shooter.right = true;
    break;
  }
  if (key == ' ') {
    shootThingo();
  }
}

public void keyReleased() {
  switch (keyCode) {
  case UP:
    shooter.thrust = false;
    break;
  case LEFT:
    shooter.left = false;
    break;
  case RIGHT:
    shooter.right = false;
    break;
  }
}
class Fragment {
  PVector pos, mom;
  float size, rotation;
  boolean active;

  Fragment() {
    size = 3;
  }

  public void startup(PVector pos_, PVector mom_, float rotation_) {
    rotation = rotation_;
    pos = pos_;
    mom = mom_;
    mom.x += random(-1, 1);
    mom.y += random(-1, 1);
    active = true;
  }

  public void update() {
    ellipse(pos.x, pos.y, size, size);
    pos.x += cos(radians(rotation));
    pos.y += sin(radians(rotation));
  }
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#030000", "--stop-color=#cccccc", "Asteroid_Shooter" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
