Sparkle[] sparkles = new Sparkle [1000]; 

void setup() {
  size (1000, 1000);
  for (int i = 0; i < sparkles.length; i++) {
    sparkles[i] = new Sparkle();
  }
}

void draw() {
  translate(width/2, height/2);
  background(20);
  for (int i = 0; i < sparkles.length; i++) {
    sparkles[i].rebound();
    sparkles[i].update();
  }
}