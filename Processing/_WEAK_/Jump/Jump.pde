float position = 280;
float momentum = 0;
float gravity = 2;

void setup() {
  size(300, 300);
}

void draw() {
  background(255);
  if (position >= 280) {
    momentum = 0;
    position = 280;
  }
  if (keyPressed == true && position >= 280) {
    momentum = 30;
  }
  if (position < 280) { 
    momentum = momentum - gravity;
  }
  position = position - momentum;
  rect(width/2-10, position, 20, 20);
}