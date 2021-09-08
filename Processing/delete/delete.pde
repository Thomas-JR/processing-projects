float mult = 178;
float totalSteps = 360;

float start = 0;
float radius = 400;

void setup() {
  size(900, 900);
}

void draw() {
  translate(width/2, height/2);
  update();
  start+=0.1;
}

void update() {
  background(255);
  for (int i = 0; i < totalSteps; i++) {
    line(cos(i/totalSteps*mult*(2.0*PI))*radius, sin(i/totalSteps*mult*(2.0*PI)+start)*radius, cos(i/totalSteps*(2.0*PI)+start)*radius, sin(i/totalSteps*(2.0*PI))*radius);
  }
  println(start);
}

void mousePressed() {
  if (mouseButton == LEFT) {
    mult++;
    println(mult);
  } else {
    totalSteps++;
  }
}
