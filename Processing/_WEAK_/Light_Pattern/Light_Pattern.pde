float speed = 1;
float multiplier = 0;
float inc = 1;

float degrees = 0;
float radius;
float x, lastx, x2;
float y, lasty, y2;
boolean lastPressed;

void setup() {
  frameRate(500);
  size(800, 600);
  background(0);
  radius = min(width, height)/2*0.9;
  strokeWeight(1);
  stroke(0);
  fill(0);
}

void draw() {
  x = width/2+cos(radians(degrees)) * radius;
  y = height/2+sin(radians(degrees)) * radius;
  x2 = width/2+cos(radians(degrees * multiplier)) * radius;
  y2 = height/2+sin(radians(degrees * multiplier)) * radius;
  line(x, y, x2, y2);
  degrees += speed;
  stroke(255);
  if (mousePressed && !lastPressed) {
    background(0);
    degrees = 0;
    multiplier += inc;
  }
  println(multiplier);
  lastPressed = mousePressed;
}