Point[] points = new Point[0];
int scale = 10;
float xSpace;
float ySpace;

void setup() {
  fullScreen();
  xSpace = scale/width;
  ySpace = scale/height;
  points = new Point[10000];
  int i = 0;
  for (int y = 0; y < height; y+=ySpace) {
    for (int x = 0; x < width; x+=xSpace) {
      points[i] = new Point(x, y);
      i++;
    }
  }
}

void draw() {
  for (int i = 0; i < points.length; i++) {
    points[i].update();
  }
}

class Point {
  int x, y;
  float distance;
  float shade;
  
  Point(int x_, int y_) {
    x = x_;
    y = y_;
    distance = sqrt(sq(width-x)+sq(height-y));
    shade = map(distance, 0, sqrt(sq(width)+sq(height)), 0, 255);
  }
  
  void update() {
    fill(shade);
    noStroke();
    rect(x, y, xSpace, ySpace);
  }
}