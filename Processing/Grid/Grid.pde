int size = 95;
int inc = -1;
float col = 0;
float cInc = 0.01;

void setup() {
  frameRate(60);
  size (500, 500);
  stroke(255);
}
void draw() {
  translate(width/2, height/2);
  for (int x = 0; x < width/2 + size; x = x + size) {
    for (int y = 0; y < height/2 + size; y = y + size) {
      fill(col);
      rect(x, y, size, size);
      rect(x, -y, size, size);
      rect(-x, y, size, size);
      rect(-x, -y, size, size);
      col = col + cInc;
      if (col <= 0 || col >= 255) {
        cInc = -cInc;
      }
    }
  }
  if (size <= 5 || size >= 100) {
    inc = -inc;
  }
  size = size + inc;
}