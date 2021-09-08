Star[] stars = new Star[500];

float radius;
float moonSize;
float sunSize;
float degrees;
float mx;
float my;
float sx;
float sy;
float light;
float speed;

void setup() {
  frameRate(120);
  size(displayWidth, displayHeight);
  radius = min(width, height) * 0.8;
  sunSize = min(width, height) * 0.2;
  moonSize = min(width, height) * 0.1;
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
}

void draw() {
  light = map(sy, height/3*2, height+height/3, 0, 255);
  println(light);
  background(0, 200, 255);
  fill(0, light);
  rect(0, 0, width, height);
  degrees += map(speed, width-200, width-20, 0, 6);
  mx = width/2+cos(radians(degrees+180))*radius;
  my = height+sin(radians(degrees+180))*radius;
  sx = width/2+cos(radians(degrees))*radius;
  sy = height+sin(radians(degrees))*radius;
  for (int i = 0; i < stars.length; i++) {
    stars[i].update(map(speed, width-200, width-20, 0, 6));
  }
  noStroke();
  fill(200);
  ellipse(mx, my, moonSize, moonSize);
  fill(200, 250, 0);
  ellipse(sx, sy, sunSize, sunSize);

  for (int h = 0; h < 255; h++) {
    stroke(255-light, h);
    line(0, height-255+h, width, height-255+h);
  }

  noFill();
  stroke(light);
  rect(width-200, height-50, 180, 20);
  fill(150);
  rect(speed-8, height-70, 16, 60, 6); 
  if (mousePressed && mouseX > width-200 && mouseX < width-20 && mouseY > height-50 && mouseY < height-30)
    speed = mouseX;
  if (speed < width-200)
    speed = width-200;
  else if (speed > width-20)
    speed = width-20;
}
