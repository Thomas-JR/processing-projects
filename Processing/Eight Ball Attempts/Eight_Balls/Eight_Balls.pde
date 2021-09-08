Ball[] balls = new Ball[3];
float power, radius, tHor, tVer;
boolean lastPressed;
IntList checked;

void setup() {
  fullScreen();
  tHor = width/3*2;
  tVer = height/3*2;
  balls[0] = new Ball(true, 0, -tHor/3, 0);
  for (int i = 1; i < balls.length; i++) {
    balls[i] = new Ball(false, 1, random(-tHor/2, tHor/2), random(-tVer/2, tVer/2));
  }
  radius = 30;
}

void draw() {
  checked = new IntList();
  translate(width/2, height/2);
  background(0);
  fill(100, 200, 150);
  rectMode(CENTER);
  noStroke();
  rect(0, 0, tHor, tVer);
  power = constrain(dist(balls[0].x, balls[0].y, (mouseX-width/2), (mouseY-height/2)), radius/4, 200)+radius/2;

  if (balls[0].speed <= 0.1) {
    balls[0].degrees = degrees(atan2(balls[0].y-(mouseY-height/2), balls[0].x-(mouseX-width/2)))-180;
    if (mousePressed &! lastPressed) {
      balls[0].speed = power/10;
    }
  }
  for (int i = 0; i < balls.length; i++) 
    balls[i].update();
  println(checked);
}