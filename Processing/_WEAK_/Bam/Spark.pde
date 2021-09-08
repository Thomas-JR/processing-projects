class Spark {
  float x;
  float y;
  float gravity;
  float fall;
  float momentumH;
  float momentumV;

  Spark () {
    x = 0;
    y = 0;
    momentumH = random(-10, 10);
    momentumV = 5 - momentumH;
    gravity = 1;
  }

  void update() {
    if (y < 300) {
      x = x + momentumH;
      y = y + momentumV;
      momentumV = momentumV + gravity;
    }
    if (reset == true) {
      for (int i = 0; i < sparks.length; i++) {
        x = 0;
        y = 0;
        momentumV = random (-30, 0);
        momentumH = random(-5, 5);
      }
    }
  }

  void show() {
    fill(255);
    noStroke();
    ellipse(x, y, 2, 2);
  }
}