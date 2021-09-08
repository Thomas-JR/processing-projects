float offset = 0;
int size = 1;

void setup() {
  fullScreen();
  noStroke();
}

void draw() {
  translate(width/2, height/2);
  for (int y = -height/2; y < height/2; y+=size) {
    for (int x = -width/2; x < width/2; x+=size) {
      fill((((cos(dist(x, y, 0, 0)/16+offset))+1))*255);
      rect(x, y, size, size);
    }
  }
  offset-=0.5;
}
