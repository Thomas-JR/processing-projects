Segment[] segments = new Segment[81]; 
boolean lastPressed;
int turn = 0;

void setup() {
  size(600, 600);
  int i = 0;
  for (int x = 0; x < 9; x++) {
    for (int y = 0; y < 9; y++) {
      segments[i] = new Segment(width/10+(x*width/10), height/10+(y*height/10), i);
      i += 1;
    }
  }
}

void draw() {
  //Background
  background(255, 248, 220);
  strokeWeight(1);
  noFill();
  for (int x = 0; x < 8; x++) {
    for (int y = 0; y < 8; y++) {
      rect(width/10+(x*width/10), height/10+(y*height/10), width/10, height/10);
    }
  }

  //Change state of position pressed
  for (int i = 0; i < 81; i++) {
    segments[i].update();
  }

  //Check life of all positions
  for (int i = 0; i < 81; i++) {
    segments[i].Check();
  }
}