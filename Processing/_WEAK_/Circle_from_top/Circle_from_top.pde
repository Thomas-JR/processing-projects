float angle, radius;
int i;

void setup() {
  size(displayWidth, displayHeight);
  radius = min(width, height)/2*0.9;
  background(255);
}

void draw() {
  translate(width/2, height/2);
  angle += sin(radians(i))*PI;
  ellipse(cos(radians(angle-90))*radius, sin(radians(angle-90))*radius, 20, 20);
  fill(0);
  stroke(255);
  text(i%360, 0, 0);
  i ++;
}
