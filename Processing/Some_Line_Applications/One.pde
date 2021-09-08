float diameter;
float degrees = 0;
float inc = 1;
float multiplier = 0;
float x1;
float y1;
float x2;
float y2;
int slider;
int sliderMin;
int sliderMax;
boolean change= true;

void state1 () {
  if (total <= 1) {
    background(switch1);
    r = 0;
    g = 125;
    b = 250;

    stroke(100);
    noFill();
    ellipse(width/2, height/2, diameter, diameter);
    fill(shade);
    textAlign(LEFT);
    textSize(20);
    text("Multiplier = " + multiplier, 20, 20 );
  }
  //Increase Buttons
  strokeWeight(2);
  stroke(shade);
  textSize(30);
  textAlign(CENTER);
  //+1
  if (dist(mouseX, mouseY, 50, 70) <= 35)
    fill(200);
  else fill(150);
  ellipse(50, 70, 70, 70);
  fill(switch1);
  text("+1", 50, 80);

  //+10
  if (dist(mouseX, mouseY, 50, 150) <= 35)
    fill(200);
  else fill(150);
  ellipse(50, 150, 70, 70);
  if (!lastPressed && mousePressed && dist(mouseX, mouseY, 50, 150) <= 35)
    multiplier -= 2;
  fill(switch1);
  text("-1", 50, 160);

  //-1
  if (dist(mouseX, mouseY, 50, 240) <= 35)
    fill(200);
  else fill(150);
  ellipse(50, 240, 70, 70);
  if (!lastPressed && mousePressed && dist(mouseX, mouseY, 50, 240) <= 35)
    multiplier += 9;
  fill(switch1);
  text("+10", 50, 250);

  //-10
  if (dist(mouseX, mouseY, 50, 320) <= 35)
    fill(200);
  else fill(150);
  ellipse(50, 320, 70, 70);
  if (!lastPressed && mousePressed && dist(mouseX, mouseY, 50, 320) <= 35)
    multiplier -= 11;
  fill(switch1);
  text("-10", 50, 330);

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

  //Clear
  if (mouseX >= 20 && mouseX <= 220 && mouseY >= height-60 && mouseY <= height-20) {
    fill(200);
  }
  else fill(150);
  stroke(shade);
  rect(20, height-60, 160, 40);
  fill(255);
  textAlign(CENTER);
  textSize(36);
  text("Clear", 100, height-28);

  //set points
  stroke(shade);
  noFill();
  x1 = width/2 + cos(radians(degrees)) * diameter/2;
  y1 = height/2 + sin(radians(degrees)) * diameter/2;
  x2 = width/2 + cos(radians(degrees*multiplier)) * diameter/2;
  y2 = height/2 + sin(radians(degrees*multiplier)) * diameter/2;

  //colours
  r += rinc;
  g += ginc;
  b += binc;
  if (r <= 0 || r >= 255)
    rinc =- rinc;
  if (g <= 0 || g >= 255)
    ginc =- ginc;
  if (b <= 0 || b >= 255)
    binc =- binc;
  stroke(r, g, b);
  line(x1, y1, x2, y2);


  //slider
  fill(switch1);
  noStroke();
  rect(width-330, height-110, 330, 110);
  stroke(shade);
  if (mousePressed && mouseX >= slider-8 && mouseX <= slider+8 && mouseY <= height-20 && mouseY >= height-70) {
    move = true;
    change = false;
  }
  if (move)
    slider = mouseX;
  if (slider < sliderMin)
    slider = sliderMin;
  if (slider > sliderMax)
    slider = sliderMax;
  fill(switch1);
  rect(width-310, height-60, 280, 30);
  if (mouseX >= slider-8 && mouseX <= slider+8 && mouseY <= height-20 && mouseY >= height-70)
    fill(200);
  else
    fill(150);
  rect(slider-8, height-70, 16, 50, 6);
  if (lastPressed && !mousePressed)
    move = false;
  inc = map(slider, width-310, width-30, 1, 10);
  inc = Math.round(inc);
  textAlign(RIGHT);
  textSize(30);
  fill(shade);
  text("speed = " + inc, width-30, height-80);

  //add one to multiplier
  if (!lastPressed && mousePressed && change) {    
    background(switch1);
    degrees = 0;
    multiplier += 1;
    fill(shade);
    textAlign(LEFT);
    textSize(20);
    text("Multiplier = " + multiplier, 20, 20 );
    stroke(100);
    noFill();
    ellipse(width/2, height/2, diameter, diameter);
    if (mouseX >= width-180 && mouseX <= width-20 && mouseY >= 20 && mouseY <= 60) {
      state = 0;
      multiplier -= 1;
    }
    if (mouseX >= 20 && mouseX <= 160 && mouseY >= height-60 && mouseY <= height-20) {
      stroke(100);
      fill(switch1);
      ellipse(width/2, height/2, diameter, diameter);
      multiplier -= 1;
    }
  }

  degrees += inc;
  change = true;
}