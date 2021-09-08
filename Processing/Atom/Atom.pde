float x;
float y;
float size;
float speed;
float degrees;
float xInc;
float yInc;
float c;
float s;
float radius;
boolean lastPressed;
float r = 0;
float g = 125;
float b = 250;
float rInc = 0.2;
float gInc = 0.2;
float bInc = 0.2;

void setup() {
fullScreen();  size = 20;
  speed = size*2;
  radius = width/2*0.8;
  x = width/2;
  y = height/2;
  background(255);
  noStroke();
}

void draw() {
  fill(255);
  rect(0, 0, width, 60);
  fill(r, g, b);
  textSize(32);
  text(degrees, -10, 30);

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

  xInc += c/5;
  yInc += s/5;
  if (!keyPressed) {
    x += xInc;
    y -= yInc;
  }


  ellipse(x, y, size, size);
  if (lastPressed == false && mousePressed == true)
    background(255);

  lastPressed = mousePressed;
}
