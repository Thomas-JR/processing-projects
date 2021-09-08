float a = 1;

void setup() {
  size(800, 800);
  background(255);
  strokeWeight(1);
}

void draw() {
  background(255);
  translate(width/2, height/2);
  for (int i = 0; i < 360; i+=a) {
    tri(200, i, i, 200);
  }
  a += 0.2;
}

void tri(float size, float deg, float rotation, float distance) {
  float startX = cos(radians(rotation))*distance;
  float startY = sin(radians(rotation))*distance;
  deg-=90;
  line(cos(radians(deg))*size, sin(radians(deg))*size, cos(radians(deg+120))*size, sin(radians(deg+120))*size);
  line(cos(radians(deg+240))*size, sin(radians(deg+240))*size, cos(radians(deg+120))*size, sin(radians(deg+120))*size);
  line(cos(radians(deg+240))*size, sin(radians(deg+240))*size, cos(radians(deg))*size, sin(radians(deg))*size);
}
