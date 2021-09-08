class Star {
  float shade;
  float xlen;
  float ylen;
  float degrees;
  float spacing;
  float lastx;
  float lasty;
  float size;
  float radius;
  boolean up;
  float y;
  float r;
  float g;
  float b;

  Star() {
    degrees = random(0, 360);
    spacing = random(-0.1, 0.1);
    shade = 220;
    size = random(4, 6);
    radius = random(diameter/4+2, diameter/2-2);
    r = 255;
    g = 255;
    b = 255;
  }

  void loop() {
    if (up == true) {
      degrees += spacing;
      ylen =+ y;
    } else {
      degrees -= spacing;
      ylen =- y;
    }

    if (degrees >= 180) {
      up = false;
    }

    xlen = cos(degrees * (PI/180));
    y = sin(degrees * (PI/180));
    xlen *= radius;
    y *= radius;

    noStroke();
    fill(r,g,b);
    ellipse(width/2+xlen, height/2-ylen, size, size);

    lastx = xlen;
    lasty = ylen;

    if (degrees >= 360)
      degrees = 0;
    else if (degrees <= 0)
      degrees = 360;
    
    noFill();
    stroke(255);
  }
}