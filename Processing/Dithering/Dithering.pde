Point[] points = new Point[3600];
Game state = new Game();
boolean go;
int type = 1;

void setup() {
  size(1000, 1000);
  state.img = loadImage("image1.jpg");
  state.img.resize(60, 60);
  //image(state.img, 0, 0);
  for (int y = 0; y < state.img.height; y++) {
    for (int x = 0; x < state.img.width; x++) {
      int i = index(x, y, state.img.width);
      color pix = state.img.pixels[i];
      float r = round(red(pix) / 255) * 255;
      float g = round(green(pix) / 255) * 255;
      float b = round(blue(pix) / 255) * 255;
      points[i] = new Point(x, y, red(pix), green(pix), blue(pix));
    }
  }
  noStroke();
  background(255);
}

void draw() {
  background(255);
  if (mousePressed)
    go = true;
  for (Point p : points)
    p.show();
}

int index(int x_, int y_, int w_) {
  return x_ + y_ * w_;
}