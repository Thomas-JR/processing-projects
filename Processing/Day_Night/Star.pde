class Star {
  float x;
  float y;
  float degrees;
  float speed;
  float radi;
  
  Star() {
    radi = random(-radius*1.5, radius*1.5); 
    degrees = random(0, 360);
    speed = random(0.2, 0.5);
  }
  
  void update(float s) {
    degrees += speed * s;
    x = width/2+cos(radians(degrees))*radi;
    y = height+sin(radians(degrees))*radi;
    noStroke();
    fill(255, light);
    ellipse(x, y, 3, 3);
  }
}
