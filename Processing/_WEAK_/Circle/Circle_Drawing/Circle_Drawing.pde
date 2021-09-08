boolean up = true;
float speed;
float xlen = 1;
float ylen;
float y;

void setup() {
  size(500, 500);
  background(255);
}

void draw() {
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);

  speed = map (mouseY, 0, height, 0.05, 0.0001); 
  
  if (up == true) {
    xlen -= speed;
    y = height/2-ylen*height/2;
  } else {
    xlen += speed;
    y = height/2+ylen*height/2;
  }

  if (xlen <= -1 || xlen >= 1) {
    if (up == true)
      up = false;
    else
      up = true;
  }
  
  ylen = sqrt(1-sq(xlen));
  ellipse(width/2+xlen*width/2, y, 20, 20);
}