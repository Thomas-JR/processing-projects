float x;
float y;
float xinc;
float yinc;
float lastx;
float lasty;
float degrees;
float speed = 100;
int total;

void setup() {
  size(600, 600);
  background(255);
  x = width/2;
  y = height;
  stroke(255);
}

void draw() {
  if (total >= 5) {
    degrees = random(0, 180);
    x = width/2;
    y = height;
    stroke(255, 0);
    total -= 5;
  }
  xinc = cos(radians(degrees)) * speed;
  yinc =- sin(radians(degrees)) * speed;
  x += xinc;
  y += yinc;
  line(x, y, lastx, lasty);
  lastx = x;
  lasty = y;
  stroke(0);
  println(total);
  total += 1;
}