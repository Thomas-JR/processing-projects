int x = 0;
int y = 0;
int Inc = 4;
int x2 = 0;
int y2 = 0;
int Inc2 = 8;
int x3 = 0;
int y3 = 0;
int Inc3 = 8;
boolean forward = true;
boolean reverse = false;

void setup() {
  frameRate(20);
  size(720, 720);
  background(0);
}

void draw() {
  if (x2 <= width*1.31 && forward == true) {
    //stroke(0, 255, 255, 150);
    //line(0, y3, width, y3);
    //line(x3, 0, x3, height);
    //line(0, height-y3, width, height-y3);
    //line(width-x3, 0, width-x3, height);

    stroke(255, 0, 0);
    line(x2, height/2, width/2, height/2 - y2);
    line(width/2, height-y2, width/2-x2, height/2);
    line(width - x2, height/2, width/2, height/2 + y2);
    line(width/2, 0 + y2, width/2 + x2, height/2);

    stroke(0, 255, 0);
    line(0, y, x, height);
    line(x, height, width, height-y);
    line(width, height-y, width-x, 0);
    line(width-x, 0, 0, y);
    x = x + Inc;
    y = y + Inc;
    x2 = x2 + Inc2;
    y2 = y2 + Inc2;
    x3 = x3 + Inc3;
    y3 = y3 + Inc3;
  }
  if (x2 >= width*1.31 && forward == true && reverse == false) {
    forward = false;
    reverse = true;
    x = 0;
    y = 0;
    Inc = 1;
    x2 = 0;
    y2 = 0;
    Inc2 = 2;
    x3 = 0;
    y3 = 0;
    Inc3 = 2;
  }
  if (x2 <= width*1.31 && reverse == true) {
    stroke(255);
    line(0, y3, width, y3);
    line(x3, 0, x3, height);
    line(0, height-y3, width, height-y3);
    line(width-x3, 0, width-x3, height);

    stroke(255);
    line(x2, height/2, width/2, height/2 - y2);
    line(width/2, height-y2, width/2-x2, height/2);
    line(width - x2, height/2, width/2, height/2 + y2);
    line(width/2, 0 + y2, width/2 + x2, height/2);

    stroke(255);
    line(0, y, x, height);
    line(x, height, width, height-y);
    line(width, height-y, width-x, 0);
    line(width-x, 0, 0, y);
    x = x + Inc;
    y = y + Inc;
    x2 = x2 + Inc2;
    y2 = y2 + Inc2;
    x3 = x3 + Inc3;
    y3 = y3 + Inc3;
  }
  if (x2 >= width*1.31 && forward == false) {
    forward = true;
    reverse = false;
    x = 0;
    y = 0;
    Inc = 1;
    x2 = 0;
    y2 = 0;
    Inc2 = 2;
    x3 = 0;
    y3 = 0;
    Inc3 = 2;
  }
}
