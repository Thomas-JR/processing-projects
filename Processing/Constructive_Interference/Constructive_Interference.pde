float wave;

void setup() {
  size(500,500);
}

void draw() {
  background(255);
  translate(0, height/2);
  for (float x = -width; x < width; x++) {
    stroke(255, 0, 0);
    float amplitude = (x+wave)/(width/(2*PI));
    point(x, sin(amplitude)*height/4);
    stroke(255,0, 0);
    point(x+mouseX, sin(amplitude)*height/4);
    stroke(255,0,0);
    point(x, sin((x+mouseX)/(width/(2*PI)))*height/4+sin(amplitude)*height/4);
  }
  fill(0);
  text("Path Difference = " + (mouseX/(width/(2*PI))/(2*PI)),0,-0.9*width/2);
  wave -= 0;
}
