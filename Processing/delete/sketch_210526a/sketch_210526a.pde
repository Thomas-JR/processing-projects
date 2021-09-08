void setup() {
  size(500, 500);
}

void draw() {
  background(255);
  translate(0, height/2);
  PVector prev = new PVector(0, 0);
  for (int i = 0; i < width; i+= 20) {
    if (i % 40 == 0) {
      line(prev.x, prev.y, i,-(i/2));
      prev.y=-i/2;
    } else {
      line(prev.x, prev.y, i,(i/2));
    prev.y = i/2;
    }
    prev.x = i;
  }
}
