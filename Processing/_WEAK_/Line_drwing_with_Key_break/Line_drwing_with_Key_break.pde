Spark[] sparks = new Spark[500];
boolean lastPressed, lastKey;
float lastX, lastY;
boolean destroy;

void setup() {
  fullScreen();
  for (int i = 0; i < sparks.length; i++) {
    sparks[i] = new Spark(false, 0, 0, 0, 0);
  }
  strokeWeight(3);
}

void draw() {
  background(255);
  for (int i = 0; i < sparks.length; i++) {
    if (sparks[i].on() == true)
      sparks[i].update();
  }
  if (!lastPressed && mousePressed) {
    lastX = mouseX;
    lastY = mouseY;
  }
  if (keyPressed &! lastKey) {
    for (int i = 0; i < sparks.length; i++) {
      if (sparks[i].on() == true) {
        sparks[i].kill();
      }
    }
  }
  if (mousePressed) {
    int j = 1;
    for (int i = 0; i < sparks.length; i++) {
      if (j <= 0)
        break;
      if (sparks[i].on() == false) {
        sparks[i] = new Spark(true, mouseX, mouseY, lastX, lastY);
        lastX = mouseX;
        lastY = mouseY;
        j -= 1;
      } else
        continue;
    }
  }
  lastKey = keyPressed;
  lastPressed = mousePressed;
}




class Spark {
  float x1, y1, x2, y2, degrees, speed;
  float gravity, fall;
  int total;
  boolean active, kill;

  Spark(boolean a, float x_, float y_, float lx, float ly) {
    active = a;
    x1 = x_;
    y1 = y_;
    x2 = lx;
    y2 = ly;
    speed = 0.01;
    gravity = 0.2;
    degrees = random(360);
  }

  void update() {
    if (total >= 100) {
      total = 0;
      active = false;
      speed = 0;
    }

    if (kill) {
      x1 += cos(radians(degrees))*speed;
      y1 += sin(radians(degrees))*speed+fall;
      x2 += cos(radians(degrees))*speed;
      y2 += sin(radians(degrees))*speed+fall;
      speed += 0.04;
      fall += gravity;
      total += 1;
    }

    stroke(map(total, 0, 100, 0, 255));
    if (!active)
      noStroke();
    line(x1, y1, x2, y2);
  }

  boolean on() {
    return active;
  }
  
  void kill() {
    kill = true;
  }
}