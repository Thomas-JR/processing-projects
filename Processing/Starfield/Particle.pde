class Particle {
  float x, y, lastX, lastY, size, xInc, yInc, degrees, thruster;

  Particle() {
    x = random(-width/2, width*1.5);
    y = random(-height/2, height*1.5);
    size = random(2);
    degrees = atan2(y-height/2, x-width/2);
    lastX = x;
    lastY = y;
    thruster = 0.5;
  }

  void update() {
    xInc = map(mouseX, 0, width, 10, -10);
    yInc = map(mouseY, 0, height, 10, -10);
    x += cos((degrees))*size*5 + xInc;
    y += sin((degrees))*size*5 + yInc;
    thruster += thrust;
    if (thruster < 0.02)
      thruster = 0.02;
    if (thruster >10)
      thruster = 10;
    size += thruster;
    strokeWeight(size/2);
    stroke(255);
    if (x < -width/2 || x > width*1.5 || y < -height/2 || y > height*1.5) {
      boolean go = false;
      while (!go) {
        x = random(-width/2, width*1.5);
        y = random(-height/2, height*1.5);
        if (dist(x, y, width/2, height/2) > 0)
          go = true;
      }
      go = false;
      size = random(0);
      degrees = atan2(y-height/2, x-width/2);
      noStroke();
    }
    line(x, y, lastX, lastY);
    lastX = x;
    lastY = y;
  }
}