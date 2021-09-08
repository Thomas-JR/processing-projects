Spark[] sparks = new Spark[200];
boolean lastPressed;
float lastX, lastY;

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
  lastPressed = mousePressed;
}




class Spark {
  float x1, y1, x2, y2, degrees, speed;
  float gravity, fall;
  int total;
  boolean active;

  Spark(boolean a, float x_, float y_, float lx, float ly) {
    active = a;
    x1 = x_;
    y1 = y_;
    x2 = lx;
    y2 = ly;
    speed = 0.01;
    gravity = 0.1;
    degrees = random(360);
  }

  void update() {
    if (total >= 200) {
      total = 0;
      active = false;
      speed = 0;
    }

    if (total > 100) {
      x1 += cos(radians(degrees))*speed;
      y1 += sin(radians(degrees))*speed+fall;
      x2 += cos(radians(degrees))*speed;
      y2 += sin(radians(degrees))*speed+fall;
      speed += 0.04;
      fall += gravity;
    }

    stroke(map(total, 0, 200, 0, 255));
    if (!active)
      noStroke();
    line(x1, y1, x2, y2);
    total += 1;
  }

  boolean on() {
    return active;
  }
}