int size = 50;
float maxRange;

void setup() {
  size(700, 700);
  maxRange = sqrt(sq(width/2^2)+sq(height/2^2));
  println(maxRange);
  background(0);
  stroke(0);
}

void draw() {
  for (int x = 0; x < width; x+=size) {
    for (int y = 0; y < height; y+=size) {
      float shade = dist(width/2, height/2, mouseX, mouseY);
      shade = map(shade, 0, maxRange, 0, 255);
      fill(250,shade,0);
      rect(x, y, size, size);
    }
  }
}