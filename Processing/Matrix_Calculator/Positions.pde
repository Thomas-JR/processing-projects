class PositionA {
  float x, y, xLen, yLen;
  int val, pos;
  
  PositionA(float xPos, float yPos, int a) {
    x = xPos;
    y = yPos;
    pos = a;
  }
  
  void update() {
    if (matrix == 0)
      fill(220);
    else
      fill(255);
    if (cell == pos)
      fill(255);
    rect(x, y, spacingX, spacingY);
    fill(0);
    textSize(titleSize/2);
    textAlign(CENTER);
    text(val, x, y+15);
  }
  
  void decreas() {
    val -= 1;
  }
  
  void increas() {
    val += 1;
  }
  
  int val() {
    return val;
  }
}

class PositionB {
  float x, y, xLen, yLen;
  int val, pos;
  
  PositionB(float xPos, float yPos, int a) {
    x = xPos;
    y = yPos;
    pos = a;
  }
  
  void update() {
    if (matrix == 1)
      fill(220);
    else
      fill(255);
    if (cell == pos)
      fill(255);
    rect(x, y, spacingX, spacingY);
    fill(0);
    textSize(titleSize/2);
    textAlign(CENTER);
    text(val, x, y+15);
  }
  
  void decreas() {
    val -= 1;
  }
  
  void increas() {
    val += 1;
  }
  
  int val() {
    return val;
  }
}

class PositionC {
  float x, y, xLen, yLen;
  int val, pos;
  
  PositionC(float xPos, float yPos, int a, int value) {
    x = xPos;
    y = yPos;
    pos = a;
    val = value;
  }
  
  void update() {
    fill(255);
    rect(x, y, spacingX, spacingY);
    fill(0);
    textSize(titleSize/2);
    textAlign(CENTER);
    text(val, x, y+15);
  }
  
  int val() {
    return val;
  }
}