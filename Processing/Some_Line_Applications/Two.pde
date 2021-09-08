Drop[] drops = new Drop[200];
float dropState = 0;

void state2() {
  //Make the rain drops
  if (total <= 1) {
    for (int i = 0; i < drops.length; i++) {
      drops[i] = new Drop();
    }
  }

  //update the rain drops
  fill(0, 0, 255, 50);
  rect(0, 0, width-1, height-1);
  for (int i = 0; i < drops.length; i++) {
    if (dropState == 0)
      drops[i].updateRain();
    else if (dropState == 1)
      drops[i].updateSnow();
  }

  //Back button
  if (mouseX >= width-180 && mouseX <= width-20 && mouseY >= 20 && mouseY <= 60)
    fill(200);
  else fill(150);
  stroke(shade);
  rect(width-180, 20, 160, 40);
  fill(255);
  textAlign(CENTER);
  textSize(36);
  text("Home", width-100, 52);
  if (!lastPressed && mousePressed) {
    if (mouseX >= width-180 && mouseX <= width-20 && mouseY >= 20 && mouseY <= 60) {
      state = 0;
    }
  }

  //Weather Buttons
  strokeWeight(2);
  stroke(shade);
  textSize(24);
  textAlign(CENTER);
  
  //Rain
  if (dist(mouseX, mouseY, 50, 60) <= 35) {
    if (mousePressed && !lastPressed)
      dropState = 0;
    fill(200);
  } else fill(150);
  ellipse(50, 60, 70, 70);
  fill(switch1);
  text("Rain", 50, 70);
  
  //Snow
  if (dist(mouseX, mouseY, 50, 150) <= 35) {
    if (mousePressed && !lastPressed)
      dropState = 1;
    fill(200);
  } else fill(150);
  ellipse(50, 150, 70, 70);
  fill(switch1);
  text("Snow", 50, 160);
}

class Drop {
  float x;
  float y;
  float fall;
  float size;
  float xInc;
  float dy;

  Drop() {
    size = random(1, 5);
    fall = size*6;
    x = random(0, width);
    y = random(-height*2, -height);
    xInc = random(-2, 2);
  }

  void updateRain() {
    dy = y;
    y += fall*map(mouseY, 0, height, 0, 2);
    if (y >= height) {
      x = random(0, width);
      y = 0;
      dy = y;
    }
    fill(255);
    stroke(255);
    strokeWeight(size / 2);
    line(x+size/2, dy, x+size/2, y);
  }

  void updateSnow() {
    dy = y;
    y += fall/8;
    x += xInc;
    if (x <= 0) 
      x = width;
    if (x >= width) 
      x = 0;
    if (y >= height) {
      x = random(0, width);
      y = 0;
      dy = y;
    }
    fill(255);
    stroke(255);
    strokeWeight(size / 2);
    ellipse(x, dy, size, size);
  }
}