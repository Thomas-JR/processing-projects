float mirror;
float angle;
float newAngle;
float radius1;
float radius2;
float power;

void setup() {
  fullScreen();
  radius1 = min(width/2, height/2)*0.9;
  radius2 = sqrt(sq(width/2 + height/2));
}

void draw() {
  //setup the canvas
  background(255);
  translate(width/2, height/2);
  noFill();
  strokeWeight(1);
  stroke(0);
  ellipse(0, 0, radius1*2, radius1*2);
  line(-width/2, 0, width/2, 0);
  line(0, -height/2, 0, height/2);
  
  
  mirror = degrees(atan2(mouseY-height/2, mouseX-width/2))+180;
  float reflection = collision(mirror, angle);
  if (mousePressed) {
    angle = mirror;
  }
  if (power < 0)
    power += 1;
  
  //Draw the 3 lines
  strokeWeight(5);
  stroke(0, 0, 255);
  line(-cos(radians(mirror))*radius2, -sin(radians(mirror))*radius2, cos(radians(mirror))*radius2, sin(radians(mirror))*radius2);
  strokeWeight(5);
  stroke(255, 255, 0);
  line(-cos(radians(angle))*radius2, -sin(radians(angle))*radius2, 0, 0);
  stroke(255, 0, 0);
  line(cos(radians(reflection+180))*radius2, sin(radians(reflection+180))*radius2, 0, 0);
  stroke(255, 0, 255);
  line(cos(radians(newAngle))*radius2, sin(radians(newAngle))*radius2, 0, 0);
  
  //add text of elements of visuals
  fill(0);
  textAlign(LEFT);
  text("power = " + power,-width/2+width/100, -height/2+height/20);
  text("angle = " + angle,-width/2+width/100, -height/2+height/20*2);
  text("mirror = " + mirror,-width/2+width/100, -height/2+height/20*3);
  text("reflection = " + reflection,-width/2+width/100, -height/2+height/20*4);
}

float collision(float a, float b) {
  b -= a;
  power = sin(radians(180-b));
  float c = a + (180-b);
  return c;
}