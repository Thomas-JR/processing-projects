int cx;
int cy;
int px;
int py;
boolean previousMouse;
float size;
boolean eraser;
float col1;
float col2;
float col3;
boolean rainbow = false;
float r;
float g;
float b;
int sizeMultiplier = 1;
boolean reset = true;

void setup() {
  frameRate(240);
  size(displayWidth, displayHeight);
  background(255);
}

void draw() {
  if (keyPressed == true) {
    reset = true;
  }

  //update and draw
  cx = mouseX;
  cy = mouseY;
  if (mousePressed == true) {
    if (rainbow == false) {
      stroke(col1, col2, col3);
    } else {
      stroke(r, g, b);
    }
    size = dist(cx, cy, px, py);
    size = constrain (size, 1, 100);
    size = map (size, 20, 100, 5*sizeMultiplier, 2*sizeMultiplier);
    if (eraser == true) {
      strokeWeight(5*sizeMultiplier);
    } else {
      strokeWeight(size);
    }
    line(px, py, cx, cy);
  }

  //change colours
  if (mousePressed == true && previousMouse == false) {
    if (dist(cx, cy, 25, 25) <= 25) {
      eraser = false;
      rainbow = false;
      col1 = 0;
      col2 = 0;
      col3 = 0;
    } else if (dist(cx, cy, 25, 75) <= 25) {
      eraser = true;
      rainbow = false;
      col1 = 255;
      col2 = 255;
      col3 = 255;
    } else if (dist(cx, cy, 25, 125) <= 25) {
      eraser = false;
      rainbow = false;
      col1 = 255;
      col2 = 0;
      col3 = 0;
    } else if (dist(cx, cy, 25, 175) <= 25) {
      eraser = false;
      rainbow = false;
      col1 = 255;
      col2 = 150;
      col3 = 0;
    } else if (dist(cx, cy, 25, 225) <= 25) {
      eraser = false;
      rainbow = false;
      col1 = 255;
      col2 = 255;
      col3 = 0;
    } else if (dist(cx, cy, 25, 275) <= 25) {
      eraser = false;
      rainbow = false;
      col1 = 0;
      col2 = 255;
      col3 = 0;
    } else if (dist(cx, cy, 25, 325) <= 25) {
      eraser = false;
      rainbow = false;
      col1 = 0;
      col2 = 255;
      col3 = 255;
    } else if (dist(cx, cy, 25, 375) <= 25) {
      eraser = false;
      rainbow = false;
      col1 = 0;
      col2 = 150;
      col3 = 255;
    } else if (dist(cx, cy, 25, 425) <= 25) {
      eraser = false;
      rainbow = false;
      col1 = 0;
      col2 = 0;
      col3 = 255;
    } else if (dist(cx, cy, 25, 475) <= 25) {
      eraser = false;
      rainbow = false;
      col1 = 150;
      col2 = 0;
      col3 = 225;
    } else if (dist(cx, cy, 25, 525) <= 25) {
      eraser = false;
      rainbow = false;
      col1 = 225;
      col2 = 0;
      col3 = 255;
    } else if (dist(cx, cy, 25, 575) <= 25) {
      eraser = false;
      rainbow = true;
    } 
    //size
    if (dist(cx, cy, 25, 635) <= 25) {
      sizeMultiplier = 1;
    }
    if (dist(cx, cy, 25, 685) <= 25) {
      sizeMultiplier = 2;
    }
    if (dist(cx, cy, 25, 735) <= 25) {
      sizeMultiplier = 3;
    }
  }

  //reset
  if (reset == true) {
    background(255);
    reset = false;
  }
  strokeWeight(2);
  stroke(0);
  fill(200);
  rect(0, 0, 50, height);
  fill(0);
  ellipse(25, 25, 50, 50);
  fill(255);
  ellipse(25, 75, 50, 50);
  fill(255, 0, 0);
  ellipse(25, 125, 50, 50);
  fill(255, 150, 0);
  ellipse(25, 175, 50, 50);
  fill(255, 255, 0);
  ellipse(25, 225, 50, 50);
  fill(0, 255, 0);
  ellipse(25, 275, 50, 50);
  fill(0, 255, 255);
  ellipse(25, 325, 50, 50);
  fill(0, 150, 255);
  ellipse(25, 375, 50, 50);
  fill(0, 0, 255);
  ellipse(25, 425, 50, 50);
  fill(150, 0, 255);
  ellipse(25, 475, 50, 50);
  fill(255, 0, 255);
  ellipse(25, 525, 50, 50);
  //sizes
  fill(255);
  rect(0, 610, 50, 50);
  rect(0, 660, 50, 50);
  rect(0, 710, 50, 50);
  fill(0);
  ellipse(25, 635, 10, 10);
  ellipse(25, 685, 20, 20);
  ellipse(25, 735, 30, 30);
  //Crazy colour
  r = random(0, 255);
  g = random(0, 255);
  b = random(0, 255);
  strokeWeight(2);
  fill(r, g, b);
  ellipse(25, 575, 50, 50);

  if (mousePressed == true) {
    previousMouse = true;
  } else { 
    previousMouse = false;
  }
  px = cx;
  py = cy;
}
