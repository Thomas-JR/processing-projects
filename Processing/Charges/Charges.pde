Point[] points = new Point[8];

void setup() {
  size(400, 400);  
  for (int i = 0; i < points.length; i++) {
    points[i] = new Point();
  }
  strokeWeight(2);
  surface.setResizable(true);
  frameRate(30);
}

void draw() {
  background(150);
  for (int i = 0; i < points.length; i++) {
    points[i].update();
    points[i].walls();
    //for (int j = i+1; j < points.length; j++) {
    //  if (points[i].pos.dist(points[j].pos) < points[i].radius/2 + points[j].radius/2) {
    //    points[i].collision(points[j]);
    //  }
    //}
  }

  fieldLines();
}

void fieldLines() {
  float s = int(width*height/50000);
  s=10;
  for (float y = s/2; y < height; y += s) {
    for (float x = s/2; x < width; x += s) {
      PVector m = new PVector(0, 0);
      for (Point p : points) {
        if (x == s/2 && y == s/2)
          p.show();
        float g = (400) / dist(x, y, p.pos.x, p.pos.y);
        float angle = atan2(p.pos.y - y, p.pos.x - x);
        if (p.positive) {
          m.x -= 2*cos(angle) * g;
          m.y -= 2*sin(angle) * g;
        } else {
          m.x += 2*cos(angle) * g;
          m.y += 2*sin(angle) * g;
        }
      }
      stroke(250);
      float fAngle = atan2(m.y, m.x);
      float size = sqrt(sq(m.x)+sq(m.y));
      float lx = size/4*cos(fAngle+7*PI/8) + x + m.x;
      float ly = size/4*sin(fAngle+7*PI/8) + y + m.y;
      float rx = size/4*cos(fAngle-7*PI/8) + x + m.x;
      float ry = size/4*sin(fAngle-7*PI/8) + y + m.y;
      float max = s*2;
      strokeWeight(1);
      if (m.x > -max && m.x < max && m.y > -max && m.y < max) {
        line(x, y, x + m.x, y + m.y);
        line(lx, ly, x + m.x, y + m.y);
        line(rx, ry, x + m.x, y + m.y);
      }
    }
  }
}

class Point {
  PVector pos, mom;
  float radius, mass;
  boolean positive;
  int ID;

  Point() {
    positive = true;
    if (int(random(0, 2)) == 1) {
      positive = false;
    }
    radius = 30;
    pos = new PVector(random(radius, width - radius), random(radius, height-radius));
    mom = new PVector(random(-3, 3), random(-3, 3));
    mass = 1;
  }

  void update() {
    float GC = 2000;
    float g;
    for (Point p : points) {
      if (p != this) {
        g = GC/sq(pos.dist(p.pos));
        if (pos.dist(p.pos) > radius) {
          float angle = atan2(p.pos.y - pos.y, p.pos.x - pos.x);
          mom.x += 1*cos(angle) * g;
          mom.y += 1*sin(angle) * g;
          if (positive == p.positive) {
            mom.x -= 1*2f*cos(angle) * g;
            mom.y -= 1*2f*sin(angle) * g;
          }
        }
      }
    }
  }

  void show() {
    pos.x += mom.x;
    pos.y += mom.y;
    noStroke();
    fill(0);
    if (positive) {
      fill(255);
    }
    ellipse(pos.x, pos.y, radius, radius);
    if (positive) {
      stroke(0);
      line(pos.x, pos.y + radius/3, pos.x, pos.y - radius/3);
      line(pos.x+radius/3, pos.y, pos.x-radius/3, pos.y);
    } else { 
      stroke(255); 
      line(pos.x-radius/3, pos.y, pos.x+radius/3, pos.y);
    }
  }

  void walls() {
    float buffer = .75;
    float r = radius/2;
    if (pos.x < r) {
      mom.x =- mom.x * buffer;
      mom.y *= buffer;
      pos.x = r + (r - pos.x);
    }
    if (pos.x > width-r) {
      mom.x =- mom.x * buffer;
      mom.y *= buffer;
      pos.x = width-r + (width-r - pos.x);
    }
    if (pos.y < r) {
      mom.y =- mom.y * buffer;
      mom.x *= buffer;
      pos.y = r + (r - pos.y);
    }
    if (pos.y > height-r) {
      mom.y =- mom.y * buffer;
      mom.x *= buffer;
      pos.y = height-r + (height-r - pos.y);
    }
  }

  void collision(Point p) {
    float v1 = mom.mag();
    float v2 = p.mom.mag();
    float m1 = mass;
    float m2 = p.mass;
    float t1 = atan2(-mom.y, mom.x);
    float t2 = atan2(-p.mom.y, p.mom.x);
    float phi = atan2(pos.y - p.pos.y, p.pos.x - pos.x); //!!
    float v1x = (v1*cos(t1-phi)*(m1-m2)+2*m2*v2*cos(t2-phi)/(m1+m2))*cos(phi) + v1*sin(t1-phi)*sin(phi);
    float v1y = (v1*cos(t1-phi)*(m1-m2)+2*m2*v2*cos(t2-phi)/(m1+m2))*sin(phi) + v1*sin(t1-phi)*cos(phi);
    float v2x = (v2*cos(t2-phi)*(m2-m1)+2*m1*v1*cos(t1-phi)/(m2+m1))*cos(phi) + v2*sin(t2-phi)*sin(phi);
    float v2y = (v2*cos(t2-phi)*(m2-m1)+2*m1*v1*cos(t1-phi)/(m2+m1))*sin(phi) + v2*sin(t2-phi)*cos(phi);

    mom = new PVector(v1x, v1y);
    p.mom = new PVector(v2x, v2y);

    pos.add(mom.normalize().mult(abs(radius/2+p.radius/2-abs(p.pos.dist(pos)))));
  }
}
