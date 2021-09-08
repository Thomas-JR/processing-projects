PImage straya;
boolean lastPressed, trueMap;
int layer;
int v, h;
float scaleH, scaleV;

void setup() {
  size(629, 558);
  straya = loadImage("Straya2.png");
  scaleH = 1887/3;
  scaleV = 1674/3;
  straya.resize(int(scaleH), int(scaleV));
}

void draw() {
  translate(-h*scaleH/65.38, -v*scaleV/58);
  image(straya, 0, 0);
  for (float y = 0; y < 58; y += 2) {
    for (float x = 0; x < 65.38; x ++) {
      noFill();
      if (y > 58-layer) {
        fill(0, 50);
        if (trueMap) {
          fill(straya.get(int(x*scaleH/65.38), int(y*scaleV/58)));
        }
      }
      ellipse(x*scaleH/65.38, y*scaleV/58, scaleV/58, scaleV/58);
      if (y > (58-1)-layer) {
        fill(0, 50);
        if (trueMap) {
          fill(straya.get(int(x*scaleH/65.38+(scaleV/58)/2), int((y+1)*scaleV/58)));
        }
      }
      ellipse((x)*scaleH/65.38+scaleH/65.38/2, (y+1)*scaleV/58, scaleV/58, scaleV/58);
    }
  }
  if (mousePressed &! lastPressed) {
    layer ++;
    if (mouseButton == RIGHT) {
      layer -= 2;
    }
  }
  lastPressed = mousePressed;
}

void keyPressed() {
  switch (keyCode) {
  case UP:
    v-=1;
    break;
  case DOWN:
    v+=1;
    break;
  case LEFT:
    h-=1;
    break;
  case RIGHT:
    h+=1;
    break;
  case SHIFT:
    if (trueMap) trueMap = false;
    else trueMap = true;
    break;
  }
  if (v < 0) v = 0;
  if (v > scaleV) v = int(scaleV);
  if (h < 0) h = 0;
  if (h > scaleH) h = int(scaleH);
}
