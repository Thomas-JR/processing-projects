Bubble[] bubbles = new Bubble[200];
PImage bubble;
PImage pop;

void setup() {
  size (1280, 720, P2D);
  for (int i = 0; i < bubbles.length; i++) {
    bubbles[i] = new Bubble();
  }
  imageMode(CENTER);
  bubble = loadImage ("Bubble.png");
  pop = loadImage ("pop.png");
}

void draw() {
  background(50, 150, 255);
  for (int i = 0; i<bubbles.length; i++) {
    bubbles[i].reset();
    bubbles[i].update();
    bubbles[i].show();
  }
}