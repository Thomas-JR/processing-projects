int total = 16;
Ball[] balls = new Ball[total];
float colour = 0;

void setup() {
  frameRate(120);
  size(800, 800);
  for (int i = 0; i < balls.length; i++)
    balls[i] = new Ball(i);
  background(0);
  colorMode(HSB);
  stroke(colour, 255, 255);
  strokeWeight(3);
}

void draw() {
  fill(0, 10);
  rect(0, 0, width, height);
  stroke(colour, 255, 255);
  for (Ball ball : balls) {
    ball.update();
    ball.borders();
    ball.show();
  }
  colour += 0.1;
  if (colour >= 240)
    colour = 0;
}
