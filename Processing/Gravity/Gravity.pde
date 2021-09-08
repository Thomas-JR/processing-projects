Object[] objects = new Object[400];
boolean lastPressed, aim, lastAim, up, down;
float gravity = 1;
float sx, sy;

void setup() {
  fullScreen();
  background(255);
  for (int i = 0; i < objects.length; i++) {
    objects[i] = new Object(false, 0, 0, 0, 0, 0, i);
  }
}

void draw() {
  translate(width/2, height/2);
  background(255);
  if (keyPressed && keyCode != UP && keyCode != DOWN && keyCode != ENTER && keyCode != TAB) {
    for (int i = 0; i < objects.length; i++) {
      if (objects[i].active == false) {
        objects[i] = new Object(true, mouseX, mouseY, 0, 0, 20, i);
        break;
      }
    }
  }
  if (up)
    gravity += 0.1;
  if (down)
    gravity -= 0.1;
  if (!mousePressed && lastPressed) {
    for (int i = 0; i < objects.length; i++) {
      if (objects[i].active == false) {
        objects[i] = new Object(true, sx, sy, mouseX-sx, mouseY-sy, random(900, 1000), i);
        break;
      }
    }
  } else if (mousePressed) {
    if (!lastPressed) {
      sx = mouseX;
      sy = mouseY;
    }
    strokeWeight(1);
    stroke(0);
    line(sx-width/2, sy-height/2, mouseX-width/2, mouseY-height/2);
  }
  for (int i = 0; i < objects.length; i++) {
    if (objects[i].active)
      objects[i].update();
  }
  lastPressed = mousePressed;
  textAlign(LEFT);
  textSize(20);
  fill(0);
  text(gravity, -width/2+20, -height/2+20);
  int num = 0;
  for (int i = 0; i < objects.length; i++) {
    if (objects[i].active)
      num ++;
  }
  println(num);
}

void keyPressed() {
  switch (keyCode) {
  case ENTER:
    for (int i = 0; i < objects.length; i++) {
      objects[i] = new Object(false, 0, 0, 0, 0, 0, i);
    }
    break;
  case TAB:
    for (int i = 0; i < 100; i++) {
      for (int j = 0; j < objects.length; j++) {
        if (!objects[j].active) {
          objects[j] = new Object(true, random(width), random(height), 0, 0, 1000, j);
          break;
        }
      }
    }
    break;
  case UP:
    up = true;
    break;
  case DOWN:
    down = true;
    break;
  }
}
void keyReleased() {
  switch (keyCode) {
  case UP:
    up = false;
    break;
  case DOWN:
    down = false;
    break;
  }
}