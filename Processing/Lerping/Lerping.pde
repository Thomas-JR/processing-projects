Circle[] circles = new Circle[2000];
boolean lastPressed;

void setup() {
  fullScreen();
  for (int i = 0; i < circles.length; i++) circles[i] = new Circle(i);
  noStroke();
  colorMode(HSB);
}

void draw() {
  translate(width/2, height/2);
  background(255);
  for (int i = 0; i < circles.length; i++) circles[i].update();
  if (keyPressed) {
    for (int i = 0; i < circles.length; i++) circles[i].radius2 = random(min(width/2, height/2)*0.9/2, min(width/2, height/2)*0.9);
  }
  lastPressed = mousePressed;
}

class Circle {
  float degrees, x, y, radius1, radius2, c;

  Circle(float a) {
    degrees = a*2;
    radius2 = random(min(width/2, height/2)*0.9/2, min(width/2, height/2)*0.9);
    c = random(255);
  }

  void update() {
    fill(c, 255, 255, 150);
    radius1 += (radius2-radius1)*0.05;
    //lerp(radius1, radius2, 0.05);
    ellipse(cos(radians(degrees))*radius1, sin(radians(degrees))*radius1, 20, 20);
  }

  void change() {
    radius2 = random(min(width/2, height/2)*0.9);
  }
}
