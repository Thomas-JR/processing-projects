Square[] squares = new Square[16];
State state = new State();

float rectSize;
float rectSpacer;

void setup() {
  size(800, 800);
  rectMode(CENTER);
  textSize(60);
  textAlign(CENTER);
  colorMode(HSB);


  rectSize = min(width, height)/4.5;
  rectSpacer = (width-4*rectSize)/5;
  for (int i = 0; i < 16; i++)
    squares[i] = new Square(i);
  makeNumber(2);
}

void draw() {
  background(200);
  for (int y = 0; y < 4; y++) {
    for (int x = 0; x < 4; x++) {
      fill(220);
      rect((x+1)*rectSpacer + x*rectSize + rectSize/2, (y+1)*rectSpacer + y*rectSize + rectSize/2, rectSize, rectSize, 10);
    }
  }
  for (Square square : squares) {
    square.show();
  }
  state.update();
  if (keyPressed &! state.lastPressed && state.changed) {
    makeNumber(1);
  }
  state.lastPressed = keyPressed;
}
