Ball[] balls = new Ball[50];
float gravity;
boolean lastPressed;
float t = 0;

void setup() {
  size(1000, 500);
  for (int b = 0; b < balls.length; b++) {
    balls[b] = new Ball();
  }
  fill(100);
  colorMode(HSB);
}

void draw() {
  t ++;
  gravity = -(height/2-mouseY)/100;
  background(255);
  strokeWeight(2);
  line(0, height/2-(height/2-mouseY), width, height/2-(height/2-mouseY));
  strokeWeight(1);
  line(0, height/2, width, height/2);
  lastPressed = mousePressed;
  for (int b = 0; b < balls.length; b++) {
    balls[b].update();
  }
  println(gravity);
}

class Ball {
  PVector pos, vel;
  int size = 50;
  float col;

  Ball() {
    col = random(255);
    pos = new PVector(random(size/2, width-size/2), random(size/2, height-size/2));
    vel = new PVector(random(-5, 5), random(-5, 5));
    vel.y = 0;
  }

  void update() {
    vel.y += gravity;
    pos.add(vel);
    if (pos.x < size/2) {
      pos.x = size/2;
      vel.x =- vel.x;
    }
    if (pos.x > width-size/2) {
      pos.x = width-size/2;
      vel.x =- vel.x;
    }
    if (pos.y < size/2) {
      pos.y = size/2;
      vel.y =- vel.y*0.8;
    }
    if (pos.y > height-size/2) {
      pos.y = height-size/2;
      vel.y =- vel.y*0.8;
      vel.x *= 0.9;
    }
    if (mousePressed) {
      vel.x += (mouseX - pos.x)/1000;
      vel.y += (mouseY - pos.y)/1000;
    }
    fill(col, 255, 255);
    ellipse(pos.x, pos.y, size, size);
  }
  
  
  
  void checkCollision(Ball other) {
  }
}