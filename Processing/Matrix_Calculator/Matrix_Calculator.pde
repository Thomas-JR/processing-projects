PositionA[] positionsA;
PositionB[] positionsB;
PositionC[] positionsC;

boolean lastPressed;
int stage, lastStage, matrixOneRows, matrixOneColumns, matrixTwoRows, matrixTwoColumns;
float titleSize, buttonSize;


void setup() {
  size (displayWidth, 700);
  titleSize = height/10;
  buttonSize = 100;
  rectMode(CENTER);
  textAlign(CENTER);
}

void draw() {
  background(255);
  
  if (stage == 0)
    stageZero();
  else if (stage == 1)
    stageOne();
  else if (stage == 2)
    stageTwo();
    
  lastPressed = mousePressed;
  lastStage = stage;
}