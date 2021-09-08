int errorOpacity;

void stageZero() {
  //Title
  textSize(titleSize);
  fill(0);
  text("Matrix Calculator", width/2, titleSize);
  textSize(titleSize/2);
  text("Matrix One", width/2, titleSize*2);
  text("Rows", width/4, titleSize*3);
  text("Columns", width/4*3, titleSize*3);

  //Matrix one Rows and Columns
  fill(255);
  rect(width/4-buttonSize, titleSize*4, buttonSize, buttonSize);
  rect(width/4, titleSize*4, buttonSize, buttonSize);
  rect(width/4+buttonSize, titleSize*4, buttonSize, buttonSize);
  rect(width/4*3-buttonSize, titleSize*4, buttonSize, buttonSize);
  rect(width/4*3, titleSize*4, buttonSize, buttonSize);
  rect(width/4*3+buttonSize, titleSize*4, buttonSize, buttonSize);
  fill(0);
  text(matrixOneRows, width/4, titleSize*4+titleSize/6);
  text(matrixOneColumns, width/4*3, titleSize*4+titleSize/6);
  text("-", width/4-buttonSize, titleSize*4+titleSize/6);
  text("+", width/4+buttonSize, titleSize*4+titleSize/6);
  text("-", width/4*3-buttonSize, titleSize*4+titleSize/6);
  text("+", width/4*3+buttonSize, titleSize*4+titleSize/6);

  //Buttons
  if (mousePressed && !lastPressed) {
    if (matrixOneRows > 0 && mouseX >= width/4-buttonSize*1.5 && mouseX <= width/4-buttonSize*0.5 && mouseY >= titleSize*4-buttonSize/2 && mouseY <= titleSize*4+buttonSize/2) {
      matrixOneRows -= 1;
    } else if (mouseX >= width/4+buttonSize*0.5 && mouseX <= width/4+buttonSize*1.5 && mouseY >= titleSize*4-buttonSize/2 && mouseY <= titleSize*4+buttonSize/2) {
      matrixOneRows += 1;
    } else if (matrixOneColumns > 0 && mouseX >= width/4*3-buttonSize*1.5 && mouseX <= width/4*3-buttonSize*0.5 && mouseY >= titleSize*4-buttonSize/2 && mouseY <= titleSize*4+buttonSize/2) {
      matrixOneColumns -= 1;
    } else if (mouseX >= width/4*3+buttonSize*0.5 && mouseX <= width/4*3+buttonSize*1.5 && mouseY >= titleSize*4-buttonSize/2 && mouseY <= titleSize*4+buttonSize/2) {
      matrixOneColumns += 1;
    }
  }

  text("Matrix Two", width/2, titleSize*5);
  text("Rows", width/4, titleSize*6);
  text("Columns", width/4*3, titleSize*6);

  //Matrix Two Rows and Columns
  fill(255);
  rect(width/4-buttonSize, titleSize*7, buttonSize, buttonSize);
  rect(width/4, titleSize*7, buttonSize, buttonSize);
  rect(width/4+buttonSize, titleSize*7, buttonSize, buttonSize);
  rect(width/4*3-buttonSize, titleSize*7, buttonSize, buttonSize);
  rect(width/4*3, titleSize*7, buttonSize, buttonSize);
  rect(width/4*3+buttonSize, titleSize*7, buttonSize, buttonSize);
  fill(0);
  text(matrixTwoRows, width/4, titleSize*7+titleSize/6);
  text(matrixTwoColumns, width/4*3, titleSize*7+titleSize/6);
  text("-", width/4-buttonSize, titleSize*7+titleSize/6);
  text("+", width/4+buttonSize, titleSize*7+titleSize/6);
  text("-", width/4*3-buttonSize, titleSize*7+titleSize/6);
  text("+", width/4*3+buttonSize, titleSize*7+titleSize/6);

  //Buttons
  if (mousePressed && !lastPressed) {
    if (matrixTwoRows > 0 && mouseX >= width/4-buttonSize*1.5 && mouseX <= width/4-buttonSize*0.5 && mouseY >= titleSize*7-buttonSize/2 && mouseY <= titleSize*7+buttonSize/2) {
      matrixTwoRows -= 1;
    } else if (mouseX >= width/4+buttonSize*0.5 && mouseX <= width/4+buttonSize*1.5 && mouseY >= titleSize*7-buttonSize/2 && mouseY <= titleSize*7+buttonSize/2) {
      matrixTwoRows += 1;
    } else if (matrixTwoColumns > 0 && mouseX >= width/4*3-buttonSize*1.5 && mouseX <= width/4*3-buttonSize*0.5 && mouseY >= titleSize*7-buttonSize/2 && mouseY <= titleSize*7+buttonSize/2) {
      matrixTwoColumns -= 1;
    } else if (mouseX >= width/4*3+buttonSize*0.5 && mouseX <= width/4*3+buttonSize*1.5 && mouseY >= titleSize*7-buttonSize/2 && mouseY <= titleSize*7+buttonSize/2) {
      matrixTwoColumns += 1;
    } else if (mouseY >= height-titleSize) {
      if (matrixTwoRows == matrixOneColumns && matrixOneRows > 0 && matrixOneColumns > 0 && matrixTwoRows > 0 && matrixTwoColumns > 0) {
        stage += 1;
        //creater the cell objects
        spacingX = width/(matrixOneColumns + matrixTwoColumns + 2);
        spacingY = (height/4*3)/(max(matrixOneRows, matrixTwoRows)+2);
        positionsA = new PositionA[matrixOneRows*matrixOneColumns];
        positionsB = new PositionB[matrixTwoRows*matrixTwoColumns];
        int i = 0;
        for (int y = 0; y < matrixOneRows; y++) {
          for (int x = 0; x < matrixOneColumns; x++) {
            positionsA[i] = new PositionA(spacingX+x*spacingX, spacingY+spacingY*y, i);
            i += 1;
          }
        }
        i = 0;
        for (int y = 0; y < matrixTwoRows; y++) {
          for (int x = 0; x < matrixTwoColumns; x++) {
            positionsB[i] = new PositionB((matrixOneColumns+2)*spacingX+spacingX*x, spacingY+spacingY*y, i);
            i += 1;
          }
        }
      } else
        errorOpacity = 250;
    }
  }
  textSize(titleSize*2);
  fill(255, 0, 0, errorOpacity);
  text("ERROR", width/2, height/2);
  if (errorOpacity > 0)
    errorOpacity -= 10;

  textSize(titleSize/2);
  fill(0, 255, 0);
  rect(width/2, height-titleSize/2, width, titleSize);
  fill(0);
  text("Check to Proceed", width/2, height-titleSize/3);
}