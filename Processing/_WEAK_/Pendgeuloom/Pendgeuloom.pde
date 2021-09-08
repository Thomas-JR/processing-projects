float ypos = 0;
int time = 0;

void setup() {
  fullScreen();
  noStroke();
}

void draw() {
  background(0);
  for (float i = 0; i < 150; i += 1) {
    time ++;
    ypos = sin(radians((i+10)*time/4000))*200+256;
    fill(random(255), random(255), random(255));
    ellipse(16*(i-1), height/4+ypos, 16, 16);
  }
}
