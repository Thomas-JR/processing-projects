float radius;
int positions = 36;
float start = 0;
float shade;

void setup() {
  fullScreen();
  radius = min(width/2, height/2)*0.7;
}

void draw() {
  background(0);
  translate(width/2, height/2);
  for (float degrees = 0; degrees < 360; degrees += 360/positions) {
    shade = degrees + start;
    if (shade > 360)
      shade -= 360;
    fill(map(shade, 0, 180, 255, 0));
    ellipse(cos(radians(degrees))*radius, sin(radians(degrees))*radius, 40, 40);
  }
  start += 6;
  if (start > 360)
    start = 0;
}