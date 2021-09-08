boolean lastPressed;
int lastState;
int state = 0;
int total;
float r = 0;
float g = 250;
float b = 125;
float rinc = 0.2;
float ginc = 0.2;
float binc = 0.2;

void setup() {
  fullScreen();
  background(255);
  frameRate(1000);
  //Main
  bx1 = width/5;
  by1 = height/20;
  diameter =  height*0.8;
  sliderMin = width-310;
  sliderMax = width-30;
}

void draw() {
  shade = map(switch1, 0, 255, 255, 0);

  if (state == 0) {
    background(switch1);
    state0();
  } else if (state == 1) {
    state1();
  } else if (state == 2) {
    background(switch1);
    state2();
  }

  lastPressed = mousePressed;
  lastState = state;
  total += 1;
}
