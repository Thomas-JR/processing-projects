float N = 1;
float fx, fy, tx, ty;
float radius;

void setup() {
  size(800, 800);
  radius = min(width, height)*0.4;
  stroke(255);
  strokeWeight(1);
}

void draw() {
  background(0);
  translate(width/2, height/2);
  for (float angle = 0; angle <= N; angle++) {
    fx = radius*cos((2*PI)/N*angle);
    fy = radius*sin((2.*PI)/N*angle);
    for (float target = 0; target <= N; target++) {
      tx = radius*cos((2*PI)/N*target);
      ty = radius*sin((2.*PI)/N*target);
      line(fx, fy, tx, ty);
    }
  }
  N+=0.1;
}

void mousePressed() {
  N++;
}
