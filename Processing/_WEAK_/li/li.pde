float degrees, radius, lastDegrees;

void setup() {
  fullScreen();
  rectMode(CENTER);
  background(0);
  strokeWeight(6);
  radius = min(width/2, height/2)*0.9;
}

void draw() {
  translate(width/2, height/2);
  fill(0, 12);
  rect(0, 0, width, height);
  stroke(255);
  degrees += 2;
  for (float i = lastDegrees; i < degrees; i+=0.1)
    line(cos(radians(i))*radius/10*9, sin(radians(i))*radius/10*9, cos(radians(i))*radius, sin(radians(i))*radius);
  lastDegrees = degrees;
}