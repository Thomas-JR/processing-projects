int size = 10;
int inc = 1;

void setup() {
  size(500, 500);
  noStroke();
}

void draw() {
  //background
  background(255);
  
  //update size
  size = size + inc;
  if (size >= 60 || size <= 10) {
    inc = -inc;
  }
  
  //display the circle
  fill(random(0, 255), random(0, 255), random(0, 255));
  ellipse(mouseX, mouseY, size, size);
  fill(255);
  ellipse(mouseX, mouseY, size-10, size-10);
}