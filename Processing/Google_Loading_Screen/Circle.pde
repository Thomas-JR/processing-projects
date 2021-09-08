class Circle {
  float x, y, spacer, shade;

  Circle(int p, float d) {
    spacer = d;
    y = height/8;
    x = -width/2-spacer*p;
  }

  void update() {
    if (x < width/2)
      fill(map(x, 0, width/2, 255, 0));
    if (x >= width/2)
      fill(map(x, width/2, width, 0, 255));
    noStroke();
    ellipse(x, y, 20, 20);
    if (x < width/2+spacer) {
      x += ((width/2+spacer)-x)/20+0.2;
    } else {
      x += (x-(width/2+spacer))/20+0.2;
    }
    if (x > width*1.5)
      x = -width*1.5;
  }
}