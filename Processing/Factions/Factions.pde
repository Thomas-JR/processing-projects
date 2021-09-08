//2:48
int xLen = 90;
int yLen = 90;
int box;
int spaces = xLen*yLen;
Spot[] spots = new Spot[spaces];

void setup() {
  size(900, 900);
  int i = 0;
  for (int y = 0; y < height; y += height/yLen) {
    for (int x = 0; x < width; x += width/xLen) {
      spots[i] = new Spot(x, y, 0, i);
      i++;
    }
  }
  int target = 1;
  spots[int(random(xLen*yLen))].type = 1;
  spots[int(random(xLen*yLen))].type = 1;
  spots[int(random(xLen*yLen))].type = 1;
  spots[int(random(xLen*yLen))].type = 1;
  while (target > 0) {
    int j = int(random(spaces));
    if (spots[j].type != 1 && check(j)) {
      spots[j].type = 1;
      target--;
    }
  }
  rectMode(CENTER);
}

void draw() {
  for (int i = 0; i < spots.length; i++) {
    spots[i].update();
    spots[i].make(1);
  }
  spots[box].make(3);
}