//Main
float bx1;
float by1;

//Slider
boolean move;
int switch1 = 255;
float shade;

void state0 () {
  //Background switch
  fill(shade);
  textAlign(LEFT);
  textSize(20);
  text("Background", 20, 20 );
  noStroke();
  if (dist(mouseX, mouseY, 40, 50) <= 20)
    fill(200);
  else fill(150);
  ellipse(40, 50, 40, 40);
  if (!lastPressed && mousePressed) {
    if (dist(mouseX, mouseY, 40, 50) <= 20) {
      if (switch1 == 0)
        switch1 = 255;
      else
        switch1 = 0;
    }
  }

  //Text Boxes
  stroke(shade);
  if (mouseX > width/2-bx1 && mouseX < width/2+bx1 && mouseY > height/2-by1*3 && mouseY < height/2-by1*2)
    fill(200);
  else 
  fill(150);
  rect(width/2-bx1, height/2-by1*3, bx1*2, by1);
  if (mouseX > width/2-bx1 && mouseX < width/2+bx1 && mouseY > height/2-by1 && mouseY < height/2)
    fill(200);
  else 
  fill(150);
  rect(width/2-bx1, height/2-by1, bx1*2, by1); 
  if (mouseX > width/2-bx1 && mouseX < width/2+bx1 && mouseY > height/2+by1*1 && mouseY < height/2+by1*2)
    fill(200);
  else 
  fill(150);
  rect(width/2-bx1, height/2+by1, bx1*2, by1);
  textSize(36);
  textAlign(CENTER);
  fill(switch1);
  text("Multiplier", width/2, height/2-by1*3+30);
  text("Natural Effects", width/2, height/2-by1+30);
  text("?", width/2, height/2+by1+30);

  if (!lastPressed && mousePressed) {
    if (mouseX > width/2-bx1 && mouseX < width/2+bx1 && mouseY > height/2-by1*3 && mouseY < height/2-by1*2) {
      state = 1;
      background(switch1);
      total = 0;
    }
    else if (mouseX > width/2-bx1 && mouseX < width/2+bx1 && mouseY > height/2-by1 && mouseY < height/2) {
      state = 2;
      background(switch1);
      total = 0;
    }
  }

  //Deco
  stroke(r, g, b);
  r += rinc;
  g += ginc;
  b += binc;
  if (r <= 0 || r >= 255)
    rinc =- rinc;
  if (g <= 0 || g >= 255)
    ginc =- ginc;
  if (b <= 0 || b >= 255)
    binc =- binc;
  float y = 0;
  for (float x = 0; x < width/2; x += width/100) {
    y += height/100;
    line(width/2+x, height, width, height-y);
    line(width/2-x, height, 0, height-y);
  }
}