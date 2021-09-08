class Spot {
  int x, y, xWid, yHei, ID;
  int type;
  float size;
  
  Spot(int x_, int y_, int type_, int ID_) {
    ID = ID_;
    x = width/xLen/2+x_;
    y = height/yLen/2+y_;
    xWid = width/xLen;
    yHei = height/yLen;
    type = type_;
    size = 1;
  }
  
  void update() {
    if (mouseX > x-width/xLen/2 && mouseX < x+width/xLen/2 && mouseY > y-height/yLen/2 && mouseY < y+height/yLen/2)
      box = ID;
  }
  
  void make(float size_) {
    if (type == 1)
      fill(0, 100, 255);
    else
      fill(255, 255, 255);
    rect(x, y, xWid*size_, yHei*size_);
  }
}





boolean check(int p) {
  boolean pass = false;
  if (p == 0) {
    if (spots[p+1].type == 1 || spots[p+xLen].type == 1)
      pass = true;
  }
  else if (p == xLen-1) {
    if (spots[p-1].type == 1 || spots[p+xLen].type == 1)
      pass = true;
  }
  else if (p == xLen*yLen-xLen) {
    if (spots[p+1].type == 1 || spots[p-xLen].type == 1)
      pass = true;
  }
  else if (p == xLen * yLen-1) {
    if (spots[p-1].type == 1 || spots[p-xLen].type == 1)
      pass = true;
  }
  else if (p % xLen == 0) {
    if (spots[p-xLen].type == 1 || spots[p+1].type == 1 || spots[p+xLen].type == 1)
      pass = true;
  }
  else if (p % xLen == xLen-1) {
    if (spots[p-xLen].type == 1 || spots[p-1].type == 1 || spots[p+xLen].type == 1)
      pass = true;
  }
  else if (p < xLen) {
    if (spots[p-1].type == 1 || spots[p+1].type == 1 || spots[p+xLen].type == 1)
      pass = true;
  }
  else if (p > xLen * yLen - xLen) {
    if (spots[p-1].type == 1 || spots[p+1].type == 1 || spots[p-xLen].type == 1)
      pass = true;
  }
  else {
    if (spots[p-1].type == 1 || spots[p+1].type == 1 || spots[p-xLen].type == 1 || spots[p+xLen].type == 1)
      pass = true;
  }
  return pass;
}