int HEXAGON_RADIUS;
// cos(PI/12)*radius
float count = 0;

void setup() {
  size(300, 300);
  HEXAGON_RADIUS = (int)(min(width, height)*0.05);
  println(HEXAGON_RADIUS);
  textAlign(CENTER);
}

void draw() {
  translate(width/2, height/2);
  background(100);
  rotate(count*PI/360);
  float centreToEdgeDistance = HEXAGON_RADIUS*cos(PI/6)*2;
  float halfEdge = HEXAGON_RADIUS*sin(PI/6)*2;
  int i = 0;
  for (int y = -5; y < 6; y++) {
    int shift = 0;
    if (y > 0) {
      shift = 1;
    }
    for (int x = constrain(-abs(2*abs(y)-11+shift), -5, 5); x <= constrain(abs(2*abs(y)-11+shift), -5, 5); x++) {
      float cx = halfEdge*3*x/2.;
      float cy = centreToEdgeDistance*(y+abs((x)%2/2.));
      fill(255);
      hexagon(cx, cy, HEXAGON_RADIUS);
      //fill(0);
      //text(i, cx, cy);
      i++;
    }
  }
  count+=map(mouseX, 0, width, 0, 50);
}

void hexagon(float x, float y, float radius) {
  beginShape();
  for (float a = 0; a < TWO_PI; a += TWO_PI/6) {
    vertex(x+cos(a)*radius, y+sin(a)*radius);
  }
  endShape(CLOSE);
}
