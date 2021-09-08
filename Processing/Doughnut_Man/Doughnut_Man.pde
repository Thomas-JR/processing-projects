Star[] stars = new Star[200];
int total;
float diameter;

void setup() {
  fullScreen();
  strokeWeight(1);
  diameter = height * 0.8;
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
}

void draw() {
  background(0);
  total += 1;
  for (int i = 0; i < stars.length; i++) {
    stars[i].loop();
  }
  ellipse(width/2, height/2, diameter, diameter);
  ellipse(width/2, height/2, diameter/2, diameter/2);
  ellipse(width/2-100, height/2, 40, 40);
  ellipse(width/2+100, height/2, 40, 40);
  rect(width/2-60, height/2 +20, 120, 20);
}