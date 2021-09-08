Shape s = new Shape();
float radius = 200.0;
float AREA = 69282.04;

void setup() {
  size(500, 500);
}

void draw() {
  translate(width/2, height/2);
  background(255);
  noFill();
  ellipse(0, 0, radius*2, radius*2);
  s.show();
  s.filling();
}


class Shape {
  PVector[] points = new PVector[4];
  float rotation, ratio;
  float filling, targetRotation, lastTargetRotation;
  FloatList angles = new FloatList();
  float base = 0;

  Shape() {
    angles.append(60);
    angles.append(120);
    angles.append(240);
    angles.append(300);
  }

  void show() {
    targetRotation = atan2(mouseY-height/2, mouseX-width/2)*180/PI;
    if (abs(lastTargetRotation-targetRotation) > 180) {
      if (targetRotation < rotation) targetRotation += 360;
      else targetRotation -= 360;
    }
    if (rotation > 360 && targetRotation > 360) {
      targetRotation -= 360;
      rotation -= 360;
    }
    if (rotation < -360 && targetRotation < -360) {
      targetRotation += 360;
      rotation += 360;
    }
    lastTargetRotation = targetRotation;
    rotation = lerp(rotation, targetRotation, 0.05);
    for (int i = 0; i < 4; i++) {
      points[i] = new PVector(cos(radians(rotation + angles.get(i)))*200, sin(radians(rotation + angles.get(i)))*200);
    }
    for (int i = 0; i < 3; i++) {
      line(points[i].x, points[i].y, points[i+1].x, points[i+1].y);
      text(i, points[i].x + 5, points[i].y + 5);
    }
    line(points[3].x, points[3].y, points[0].x, points[0].y);
      text(3, points[3].x, points[3].y);
  }
  
  void filling() {
    fill(0);
    text(-rotation, -width/2*0.9, -height/2*0.9);
    text(filling, -width/2*0.9, -height/2*0.8);
    int id1 = 0;
    for (int i = 0; i < 4; i++) {
      if (points[i].y > points[id1].y) id1 = i;
    }
    int id2 = 0;
    if (id1 == 0) id2 = 1;
    for (int i = 0; i < 4; i++) {
      if (points[i].y > points[id2].y && i != id1) id2 = i;
    }
    
    filling = (-(mouseY)+500)/5.0;
    
    float gradient = atan2(points[id2].y - points[id1].y, points[id2].x - points[id1].x);
    float xCoor = dist(points[id1].x, points[id1].y, points[id2].x, points[id2].y)/(cos(gradient));
    line(points[id2].x, points[id2].y, points[id2].x-xCoor, points[id2].y);
    float bottomPercentage = abs((points[id1].y-points[id2].y)*xCoor/2)/AREA;
    
    println(abs(gradient)*180/PI);
    if (bottomPercentage > filling) {
      //println(abs(xCoor));
    }
    
    //println(abs((points[id1].y-points[id2].y)*xCoor/2)/69282.04);
  }
}
