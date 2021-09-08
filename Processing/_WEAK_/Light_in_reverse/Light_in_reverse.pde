float shipX;
float shipY;
Light[] lights = new Light[100];
boolean inc = true;

void setup() {
  size(displayWidth, displayHeight);
  shipX = width-width/10;
  shipY = height/2;
  for (int i = 0; i < lights.length; i++) {
    lights[i] = new Light();
  }
  background(0);
}

void draw() {
  stroke(200);
  strokeWeight(5);
  line(shipX, shipY-20, shipX, shipY+20);
  for (int i = 0; i < lights.length; i++) {
    lights[i].show();
  }
  if (inc) {
    for (int i = 0; i < lights.length; i++) {
      lights[i].update();
    }
  }
  if (mousePressed)
    shipX -= 3;
  if (keyPressed)
    inc = false;
  fill(0, 150, 255);
  ellipse(width-width/10, height/2, 100, 100);
}