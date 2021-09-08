//Change the amount of planets to change difficulty
Planet[] planets = new Planet[20];//<--- change the one 
float degrees = 0;
float x, y;
float xStart;
float yStart;
boolean Break;
float lightDensity = 1;
float raySize = 1;
int end = 0;
boolean restart;
boolean win;
float lastX, lastY;

void setup() {
  frameRate(40);
  size(displayWidth, 660, P2D);
  xStart = width/2;
  yStart = height/2;
  for (int i = 0; i < planets.length; i++)
    planets[i] = new Planet();
  restart = true;
}

void draw() {
  if (win == true) {
    fill(0, 255, 0);
    text("YOU WIN", width/2, height/2+40);
  } else {
    if (!restart) {
      xStart = mouseX;
      yStart = mouseY;
    }
    if (xStart <= 0 || xStart >= width-1) {
      win = true;
    }
    background(end, 0, 0);
    if (dist(lastX, lastY, mouseX, mouseY) > 200) {
      restart = true;
      win = false;
    }
    end -= 5;
    if (restart) {
      xStart = width/2;
      yStart = height/2;
    }
    if (dist(mouseX, mouseY, width/2, height/2) <= 50)
      restart = false;
    for (int i = 0; i < planets.length; i++) {
      float px = planets[i].checkX();
      float py = planets[i].checkY();
      float psize = planets[i].checkSize();
      if (dist(xStart, yStart, px, py) <= psize/2) {
        end = 255;
        restart = true;
      }
    }
    for (int i = 0; i < planets.length; i++)
      planets[i].update();
    for (float degrees = 0; degrees < 360; degrees += lightDensity) {
      for (int radius = 0; radius < max(width, height)*1.2; radius ++) {
        x = xStart+cos(radians(degrees))*radius;
        y = yStart+sin(radians(degrees))*radius;
        if (x <= 0 || x >= width || y <= 0 || y >= height)
          break;
        for (int i = 0; i < planets.length; i++) {
          float px = planets[i].checkX();
          float py = planets[i].checkY();
          float psize = planets[i].checkSize();
          if (dist(x, y, px, py) <= psize/2) {
            Break = true;
            break;
          }
        }
        if (Break) { break; }
      }
      Break = false;
      stroke(255, 255, 255);
      strokeWeight(raySize);
      line(xStart, yStart, x, y);
    }
    textSize(100);
    textAlign(CENTER);
    fill(255, 0, 0, end);
    text("WASTED", width/2, height/2+40);
    lastX = mouseX;
    lastY = mouseY;
  }
}

class Planet {
  //variables
  float x, y;
  float degrees;
  float radius;
  float size;
  float speed;
  float r, g, b;
  
  Planet() {
    //Values for variables
    degrees = random(0, 359);
    r = random(0, 255);
    g = random(0, 255);
    b = random(0, 255);
    radius = random(100, max(width, height)/2);
    size = random(30, 100);
    speed = random(-1, 1);
  }
  
  void update() {
    //Orbit of planet
    degrees += speed;
    if (degrees >= 360)
      degrees -= 360;
    //Position of planet
    x = width/2+cos(radians(degrees))*radius;
    y = height/2+sin(radians(degrees))*radius;
    //Draw planet
    noStroke();
    fill(r, g, b);
    ellipse(x, y, size, size);
  }
  
  //Give out a float variable of planet's poition and size
  float checkX() { return x; }
  float checkY() { return y; }
  float checkSize() { return size; }
}