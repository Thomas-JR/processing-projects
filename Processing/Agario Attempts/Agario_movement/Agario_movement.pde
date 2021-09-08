Dot[] dots = new Dot[200];

float x;
float y;
float size = 1000;
float radius;
float degrees;
float xInc;
float yInc;
float c;
float s;
float r = 0;
float g = 125;
float b = 250;
float rInc = 0.5;
float gInc = 0.5;
float bInc = 0.5;

void setup() {
  size(1000, 600);
  x = width/2;
  y = height/2;
  noStroke();
  for (int i = 0; i < dots.length; i++) {
    dots[i] = new Dot();
  }
}

void draw() {
  background(255);
  for (int i = 0; i < dots.length; i++) {
    dots[i].loop();
  }

  r += rInc;
  g += gInc;
  b += bInc;
  if (r <= 0 || r >= 255)
    rInc =- rInc;
  if (g <= 0 || g >= 255)
    gInc =- gInc;
  if (b <= 0 || b >= 255)
    bInc =- bInc;
  fill(r, g, b);

  degrees = degrees(atan((y-mouseY)/(x-mouseX)));
    if (x < mouseX && y > mouseY) {
      degrees =- degrees;
    }
    if (x > mouseX && y > mouseY) {
      degrees = 180 - degrees;
    }
    if (x > mouseX && y < mouseY) {
      degrees = 180 - degrees;
    }
    if (x < mouseX && y < mouseY) {
      degrees = 360 - degrees;
  }

  c = cos(radians(degrees));
  s = sin(radians(degrees));

  x += c*2;
  y -= s*2;
  
  radius = sqrt(size);

  ellipse(x, y, radius, radius);
}