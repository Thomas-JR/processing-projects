boolean up;
int deg;
int spacing = 5;
float xlen, ylen;
float y;

void setup() {
  size(500, 500);
  background(255);
}

void draw() {
  if (up == true) {
    deg += spacing;
    ylen =+ y;
  } else {
    deg -= spacing;
    ylen =- y;
  }

  if (deg >= 180) {
    up = false;
  }
  if (deg >= 360) {
    up = true;
    deg = 0;
  }

  xlen = cos(deg * (PI/180));
  y = sin(deg * (PI/180));
  xlen *= width/2;
  y *= height/2;
  
  ellipse(width/2+xlen, height/2-ylen, 10, 10);
}