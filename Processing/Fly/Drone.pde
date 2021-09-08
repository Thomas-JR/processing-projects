class Drone {
  PVector pos, vel;
  float angle, tilt, rotation, targetRotation, size, colour;
  boolean thrust;

  Drone() {
  }

  void reset() {
    pos = new PVector(width/2, height/2);
    vel = new PVector(0, 0);
    size = 50;
    tilt = 10;
  }

  void show() {
    colour ++;
    rotation = lerp(rotation, targetRotation, 0.3);
    noStroke();
    colorMode(HSB);
    fill(colour, 255, 255);
    if (colour > 255)
      colour -= 255;
    quad(
      pos.x+cos(radians(angle-tilt+rotation))*size, pos.y-sin(radians(angle-tilt+rotation))*size, 
      pos.x+cos(radians(angle+tilt+rotation))*size, pos.y-sin(radians(angle+tilt+rotation))*size, 
      pos.x+cos(radians(angle+180-tilt+rotation))*size, pos.y-sin(radians(angle+180-tilt+rotation))*size, 
      pos.x+cos(radians(angle-180+tilt+rotation))*size, pos.y-sin(radians(angle-180+tilt+rotation))*size);
    if (thrust) {
      //image(thrustImage, pos.x+cos(radians(angle+180-tilt+rotation))*size, pos.y-sin(radians(angle-180+tilt+rotation))*size, size*2, size);
    }
  }

  void update() {
    if (pos.x < 0)
      pos.x += width;
    if (pos.x > width)
      pos.x -= width;
    if (pos.y > height) {
      pos.y = height;
      vel.y =- vel.y * 0.5;
      vel.x *= 0.9;
    }
    if (pos.y < 0) {
      pos.y = abs(pos.y);
      vel.y =- vel.y * 0.5;
      vel.x *= 0.9;
    }
    if (thrust) {
      vel.x -= sin(radians(rotation));
      vel.y -= cos(radians(rotation));
    }
    vel.y += 0.6;
    pos.add(vel);
  }
}
