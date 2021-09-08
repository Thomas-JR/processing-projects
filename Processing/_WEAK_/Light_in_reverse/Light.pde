class Light {
  float x;
  float y;
  float degrees;
  float speed;

  Light() {
    x = width-width/10;
    y = height/2;
    degrees = random(360);
    speed = random(3);
  }

  void update() {
    x += cos(radians(degrees))*speed;
    y += sin(radians(degrees))*speed;
  }

  void show() {
    fill(255);
    noStroke();
    ellipse(x, y, 5, 5);
  }
}