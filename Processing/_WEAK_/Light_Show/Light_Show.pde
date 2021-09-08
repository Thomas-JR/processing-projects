int inc1 = 1;
int inc2 = 2;
int inc3 = 3;

int r = 0;
int g = 70;
int b = 189;

int fad = 255;
int bop = 5;

void setup() {
  size(1000, 1000);
}

void draw() {
  fad = fad - bop;
  r = r + inc1;
  g = g + inc2;
  b = b + inc3;
  if (fad <= 50 || fad >= 255) {
    bop = -bop;
  }
  if (r >=255 || r <= 0) {
    inc1 = -inc1;
  }
  if (g >=255 || g <= 0) {
    inc2 = -inc2;
  }
  if (b >=255 || b <= 0) {
    inc3 = -inc3;
  }
  background(r, g, b);
  fill(0);
  rect(50, 50, 900, 900);

  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(100, 50, 950, 100);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(200, 50, 950, 200);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(300, 50, 950, 300);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(400, 50, 950, 400);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(500, 50, 950, 500);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(600, 50, 950, 600);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(700, 50, 950, 700);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(800, 50, 950, 800);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(900, 50, 950, 900);

  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(950, 100, 900, 950);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(950, 200, 800, 950);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(950, 300, 700, 950);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(950, 400, 600, 950);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(950, 500, 500, 950);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(950, 600, 400, 950);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(950, 700, 300, 950);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(950, 800, 200, 950);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(950, 900, 100, 950);

  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(50, 100, 100, 950);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(50, 200, 200, 950);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(50, 300, 300, 950);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(50, 400, 400, 950);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(50, 500, 500, 950);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(50, 600, 600, 950);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(50, 700, 700, 950);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(50, 800, 800, 950);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(50, 900, 900, 950);

  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(100, 50, 50, 900);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(200, 50, 50, 800);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(300, 50, 50, 700);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(400, 50, 50, 600);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(500, 50, 50, 500);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(600, 50, 50, 400);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(700, 50, 50, 300);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(800, 50, 50, 200);
  stroke(random(0, 255), random(0, 255), random(0, 255));
  line(900, 50, 50, 100);
  delay(100);
}