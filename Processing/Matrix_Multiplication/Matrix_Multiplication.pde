float[][] projection = {
  {1, 0, 0}, 
  {0, 1, 0}
};

float[][] point = {
  {100}, 
  {75}, 
  {50}
};

PVector v = new PVector(100, 75, 50);

void setup() {
  float[][] result = matrixMultiply(projection, point);
  matrixPrint(projection);
  float[][] point = vectorToMatrix(v);
  matrixPrint(point);
  matrixPrint(result);
}

void matrixPrint(float[][] m) {
  int cols = m[0].length;
  int rows = m.length;
  println(rows + "x" + cols);
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      print(int(m[i][j]) + " ");
    }
    println();
  }
  println("---------------");
  println();
}

float[][] vectorToMatrix(PVector v) {
  float[][] m = new float[3][1];
  m[0][0] = v.x;
  m[1][0] = v.y;
  m[2][0] = v.z;
  return m;
}

PVector matrixToVector(float[][] m) {
  PVector v = new PVector();
  v.x = m[0][0];
  v.y = m[1][0];
  v.z = m[2][0];
  if (m.length > 2) {
    return v;
  }
  else {
    return null;
  }
}

float[][] matrixMultiply(float[][] a, float[][] b) {
  int colsA = a[0].length;
  int rowsA = a.length;
  int colsB = b[0].length;
  int rowsB = b.length;
  if (colsA != rowsB) {
    println("Incapable of multiplying these dimentioned matrices together.");
    return null;
  }
  float result[][] = new float[rowsA][colsB];

  for (int i = 0; i < rowsA; i++) {
    for (int j = 0; j < colsB; j++) {
      float sum = 0;
      for (int k = 0; k < colsA; k++) {
        sum += a[i][k] * b[k][j];
      }
      result[i][j] = sum;
    }
  }

  return result;
}
