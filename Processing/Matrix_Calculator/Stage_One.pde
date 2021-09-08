float spacingX;
float spacingY;
int matrix;
int cell = 0;

void stageOne() {
  rectMode(CORNER);
  stroke(0);
  fill(255);
  if (matrix == 0) {
    if (cell > matrixOneRows*matrixOneColumns)
      cell = matrixOneRows*matrixOneColumns-1;
  }
  if (matrix == 1) {
    if (cell > matrixTwoRows*matrixTwoColumns)
      cell = matrixTwoRows*matrixTwoColumns-1;
  }
  //subtitles
  fill(0);
  text("Matrix", width/4-buttonSize, height/4*3);
  text("Cell", width/4*2, height/4*3);
  text("Value", width/4*3+buttonSize, height/4*3);
  rectMode(CENTER);

  //squares
  fill(255);
  rect(width/4-buttonSize*2, height/4*3+titleSize, buttonSize, buttonSize);
  rect(width/4-buttonSize, height/4*3+titleSize, buttonSize, buttonSize);
  rect(width/4, height/4*3+titleSize, buttonSize, buttonSize);
  rect(width/4*2-buttonSize, height/4*3+titleSize, buttonSize, buttonSize);
  rect(width/4*2, height/4*3+titleSize, buttonSize, buttonSize);
  rect(width/4*2+buttonSize, height/4*3+titleSize, buttonSize, buttonSize);
  rect(width/4*3+buttonSize*2, height/4*3+titleSize, buttonSize, buttonSize);
  rect(width/4*3+buttonSize, height/4*3+titleSize, buttonSize, buttonSize);
  rect(width/4*3, height/4*3+titleSize, buttonSize, buttonSize);

  //buttons
  textSize(titleSize/2);
  fill(0);
  text("-", width/4-buttonSize*2, height/4*3+titleSize*1.2);
  text("+", width/4, height/4*3+titleSize*1.2);
  text("-", width/4*2-buttonSize, height/4*3+titleSize*1.2);
  text("+", width/4*2+buttonSize, height/4*3+titleSize*1.2);
  text("-", width/4*3, height/4*3+titleSize*1.2);
  text("+", width/4*3+buttonSize*2, height/4*3+titleSize*1.2);
  if (matrix == 1)
    text("B", width/4-buttonSize, height/4*3+titleSize*1.2);
  else
    text("A", width/4-buttonSize, height/4*3+titleSize*1.2);

  text(cell, width/4*2, height/4*3+titleSize*1.2);

  if (mousePressed && !lastPressed && mouseY >= height/4*3 && mouseY <= height/4*3+titleSize*2) {
    if (mouseX >= width/4-buttonSize*2.5 && mouseX <= width/4-buttonSize*1.5) {
      if (matrix > 0)
        matrix -= 1;
    } else if (mouseX >= width/4-buttonSize*0.5 && mouseX <= width/4+buttonSize*0.5) {
      if (matrix < 1)
        matrix += 1;
    } else if (mouseX >= width/4*2-buttonSize*1.5 && mouseX <= width/4*2-buttonSize*0.5) {
      if (cell > 0)
        cell -= 1;
    } else if (mouseX >= width/4*2-buttonSize*0.5 && mouseX <= width/4*2+buttonSize*1.5) {
      if (matrix == 0) {
        if (cell < matrixOneRows*matrixOneColumns-1)
          cell += 1;
      } else {
        if (cell < matrixTwoRows*matrixTwoColumns-1)
          cell += 1;
      }
    }
  }

  //draw values
  for (int i = 0; i < positionsA.length; i++) {
    positionsA[i].update();
  }
  for (int i = 0; i < positionsB.length; i++) {
    positionsB[i].update();
  }

  //update the values
  if (matrix == 0) {
    text(positionsA[cell].val(), width/4*3+buttonSize, height/4*3+titleSize*1.2);
  }
  if (matrix == 1) {
    text(positionsB[cell].val(), width/4*3+buttonSize, height/4*3+titleSize*1.2);
  }

  if (mousePressed && !lastPressed) {
    if (mouseX >= width/4*3-buttonSize*0.5 && mouseX <= width/4*3+buttonSize*0.5) {
      if (matrix == 0) {
        if (positionsA[cell].val() > 0)
          positionsA[cell].decreas();
      } else {
        if (positionsB[cell].val() > 0)
          positionsB[cell].decreas();
      }
    } else if (mouseX >= width/4*3+buttonSize*1.5 && mouseX <= width/4*3+buttonSize*2.5) {
      if (matrix == 0) {
        positionsA[cell].increas();
      } else {
        positionsB[cell].increas();
      }
    }
  }

  if (keyPressed && !lastPressed) {
    stage += 1;
    spacingX = width/(matrixTwoColumns+1);
    spacingY = height/(matrixOneRows+1);
    positionsC = new PositionC[matrixOneRows*matrixTwoColumns];
    int i = 0;
    for (int y = 0; y < matrixOneRows; y++) {
      for (int x = 0; x < matrixTwoColumns; x++) {
        positionsC[i] = new PositionC(spacingX+x*spacingX, spacingY+spacingY*y, i, 0);
        i += 1;
      }
    }
  }
}