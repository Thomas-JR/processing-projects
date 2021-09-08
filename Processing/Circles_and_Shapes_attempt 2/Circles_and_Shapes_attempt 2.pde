int max = 13;
float deg;
long prev;
Shape[] shapes = new Shape[max];
Ball[] balls = new Ball[max];

void setup() {
  frameRate(120);
  size(800, 800, P2D);
  for (int i = 0; i < max; i++) {
    shapes[i] = new Shape(i+2, (255/float(max))*i, min(width, height)*0.9/(max*2)*i);
    balls[i] = new Ball(i);
  }
  colorMode(HSB);
  strokeWeight(1);
}

void draw() {
  translate(width/2, height/2);
  fill(255);
  rect(-width/2, -height/2, width, height);
  noFill();
  for (int i = int(constrain(map(dist(mouseX, mouseY, width/2, height/2), 0, min(width, height)*0.9/2, max, 0), 0, max)); i < max; i++) {
    if (i == max-1) continue;
    shapes[max-1-i].show();
    balls[max-1-i].show();
  }
  for (Ball ball : balls) ball.update();
}

class Shape {
  int sides;
  float colour, scale, degrees;
  FloatList points = new FloatList();


  Shape (int sides_, float colour_, float scale_) {
    sides = sides_;
    colour = colour_;
    scale = scale_;
    degrees =- 90;
    for (int i = 0; i < sides+1; i++) {
      points.append(i*(360/float(sides)));
    }
  }

  void show() {
    stroke(colour, 255, 255);
    beginShape();
    for (int i = 0; i < sides+1; i++) {
      vertex(cos(radians(points.get(i)+degrees))*scale, sin(radians(points.get(i)+degrees))*scale);
    }
    endShape(CLOSE);
    degrees += 1*float(max)/float(sides)/4*0;
  }
}

class Ball {
  Shape shape;
  int reference1, reference2;
  float degrees, distance, sdistance, x1, y1, t;
  PVector pos;

  Ball(int shape_) {
    pos = new PVector();
    shape = shapes[shape_];
    reference1 = 0;
    reference2 = 1;
    sdistance = dist(cos(radians(360f/(shape.sides)))*shape.scale,sin(radians(360f/(shape.sides)))*shape.scale,cos(radians(2f*(360f/(shape.sides))))*shape.scale, sin(radians(2f*(360f/(shape.sides))))*shape.scale);
    println(sdistance);
  }

  void update() {
    if (t > sdistance) {
      t -= sdistance;
      reference1 += 1;
      reference2 += 1;
      if (reference1 > shape.sides - 1)
        reference1 = 0;
      if (reference2 > shape.sides - 1)
        reference2 = 0;
    }
    x1 = cos(radians(shape.points.get(reference1)+shape.degrees))*shape.scale;
    float x2 = cos(radians(shape.points.get(reference2)+shape.degrees))*shape.scale;
    y1 = sin(radians(shape.points.get(reference1)+shape.degrees))*shape.scale;
    float y2 = sin(radians(shape.points.get(reference2)+shape.degrees))*shape.scale;
    distance = dist(x1, y1, x2, y2);
    degrees = atan2(y1-y2, x1-x2)+(PI);
    t += 2;
  }

  void show() {
    noStroke();
    fill(shape.colour, 255, 255);
    ellipse(x1+cos(degrees)*t, y1+sin(degrees)*t, 12, 12);
    noFill();
  }
}
