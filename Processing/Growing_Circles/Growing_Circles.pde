Enemy[] enemies = new Enemy[2000];
Camera camera = new Camera();
boolean started;

void setup() {
  fullScreen();
  frameRate(100);
  for (int i = 0; i < enemies.length; i++) 
    enemies[i] = new Enemy(i);
  colorMode(HSB);
  noStroke();
  rectMode(CENTER);
  background(255);
}

void draw() {
  background(255);
  for (Enemy enemy : enemies) {
    if (enemy.alive) {
      if (started) {
        enemy.walk();
        enemy.attack();
      }
      enemy.show();
      enemy.showBorders();
    }
  }
  if (keyPressed) started = true;
  fill(0);
  text(frameRate, 20, 40);
}

class Enemy {
  int ID, currentHp, hp, attack, defence, colour;
  float direction, turn, radius;
  PVector pos;
  boolean alive;

  Enemy(int ID_) {
    ID = ID_;
    hp = int(random(500, 1000));
    attack = int(random(100));
    defence = int(random(100));
    direction = random(2*PI);
    colour = int(random(255));
    alive = true;
    pos = new PVector(random(width), random(height));
  }

  void show() {
    fill(colour, 255, 255, 200);
    currentHp = int(lerp(currentHp, hp, 0.1));
    radius = (PI * sq(currentHp))/1000;
    radius = sqrt(currentHp/PI);
    ellipse(pos.x, pos.y, radius, radius);
  }

  void showBorders() {
    if (pos.x > width-radius/2) {
      ellipse(-(width-pos.x), pos.y, radius, radius);
    }
    if (pos.x < radius/2) {
      ellipse(width+pos.x, pos.y, radius, radius);
    }
    if (pos.y < radius/2) {
      ellipse(pos.x, height+pos.y, radius, radius);
    }
    if (pos.y > height-radius/2) {
      ellipse(pos.x, pos.y-height, radius, radius);
    }
  }

  void walk() {
    turn += random(-0.05, 0.05);
    direction += random(-0.1, 0.1);
    if (turn < -2) turn = -2;
    if (turn > 2) turn = 2;
    pos.x += cos(direction)*map(mouseX, 0, width, 1, 5);
    pos.y += sin(direction)*map(mouseX, 0, width, 1, 5);
    if (pos.x < 0) pos.x += width;
    if (pos.x > width) pos.x -= width;
    if (pos.y < 0) pos.y += height;
    if (pos.y > height) pos.y -= height;
  }

  void attack() {
    for (Enemy enemy : enemies) {
      if (enemy.ID != ID && enemy.alive && hp > enemy.hp && dist(pos.x, pos.y, enemy.pos.x, enemy.pos.y) < (radius/2 + enemy.radius/2)*10/10) {
        hp += enemy.hp;
        enemy.alive = false;
      }
    }
  }
}

class Camera {
  PVector pos, targetPos;

  Camera() {
    pos = new PVector();
    targetPos = new PVector();
  }

  void upatePosition() {
  }
}
