float xlen;
float ylen;
float xlen2;
float ylen2;
float total;
float degrees;
float radius;
float multiplier = 0;
boolean lastPressed;
float r;
float g;
float b;
float inc = 0;

void setup() {
  textSize(100);
  frameRate(200);
  text("Hello", width/2, height/2);
  size(displayWidth, 600);
  background(255);
  radius = min(width/2, height/2) * 0.9;
  for (int i = 0; i < 360; i++) {
    degrees += 1;
    xlen = cos(radians(degrees)) * radius;
    ylen = sin(radians(degrees)) * radius;
  }
  ellipse(width/2, height/2, radius*2, radius*2);
  xlen = 0;
  ylen = 0;
  degrees = 0;
  strokeWeight(10);
}

void draw() {
  strokeWeight(1);
  stroke(r, g, b);
  degrees += 360/360;
  xlen = cos(radians(degrees)) * radius;
  ylen = sin(radians(degrees)) * radius;
  xlen2 = cos(radians(degrees*multiplier)) * radius;
  ylen2 = sin(radians(degrees*multiplier)) * radius;

  if (mousePressed && !lastPressed) {
    background(255);
    stroke(0);
    strokeWeight(1);
    for (int i = 0; i < 360; i++) {
      degrees += 1;
      xlen = cos(radians(degrees)) * radius;
      ylen = sin(radians(degrees)) * radius;
    }
    stroke(255);
    xlen = 0;
    ylen = 0;
    degrees = 0;
    r = random(0, 255);
    g = random(0, 255);
    b = random(0, 255);
    ellipse(width/2, height/2, radius*2, radius*2);
    if (mouseButton == LEFT)
      multiplier += 1;
    else
      multiplier -= 1;
    inc += 0;
  }
  textSize(32);
  text("WORD", 10, 30); 
  line(width/2+xlen, height/2+ylen, width/2+xlen2, height/2+ylen2);
  lastPressed = mousePressed;
}
