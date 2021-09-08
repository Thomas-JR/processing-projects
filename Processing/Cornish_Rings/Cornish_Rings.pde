float xlen1;
float xlen2;
float xlen3;
float xlen4;
float ylen1;
float ylen2;
float ylen3;
float ylen4;
float rad;
int deg = 0;
int size = 1;
int total;

void setup () {
  size (600, 600);
  background(0);
  noStroke();
  rad = width/3;
}

void draw() {
  if (deg == 360) {
    size *= 2;
    deg = 0;
  }
  deg += 1;
  xlen1 = width/2 + cos(radians(deg-90)) * rad/3 * 2;
  ylen1 = rad - sin(radians(deg-90)) * rad/3 * 2;
  xlen2 = width/2 + cos(radians(deg+90)) * rad/3 * 2;
  ylen2 = height-rad - sin(radians(deg+90)) * rad/3 * 2;
  xlen3 = rad + cos(radians(deg)) * rad/3 * 2;
  ylen3 = height/2 - sin(radians(deg)) * rad/3 * 2;
  xlen4 = width-rad + cos(radians(deg+180)) * rad/3 * 2;
  ylen4 = height/2 - sin(radians(deg+180)) * rad/3 * 2;
  fill(0, 150, 255);
  ellipse(xlen1, ylen1, size, size);
  fill(0, 150, 0);
  ellipse(xlen2, ylen2, size, size);
  fill(255, 255, 0);
  ellipse(xlen3, ylen3, size, size);
  fill(255, 0, 0);
  ellipse(xlen4, ylen4, size, size);
  total += 1;
}
