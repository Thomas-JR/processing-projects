PVector[] points = new PVector[8];

float[][] projection = {
  {1, 0, 0}, 
  {0, 1, 0}
};

float angle = 0;
float size;

void setup() {
  size(600, 400);
  size = 100;
  points[0] = new PVector(-1, 1, -1);
  points[1] = new PVector(1, 1, -1);
  points[2] = new PVector(-1, -1, -1);
  points[3] = new PVector(1, -1, -1);
  points[4] = new PVector(-1, 1, 1);
  points[5] = new PVector(1, 1, 1);
  points[6] = new PVector(-1, -1, 1);
  points[7] = new PVector(1, -1, 1);
  stroke(0);
}

void draw() {
  background(255);
  translate(width/2, height/2);
  stroke(0);
  strokeWeight(10);
  noFill();

  float[][] rotationX = {
    {1, 0, 0}, 
    {0, cos(angle), -sin(angle)}, 
    {0, sin(angle), cos(angle)}, 
  };

  float[][] rotationY = {
    {cos(angle), 0, -sin(angle)}, 
    {0, 1, 0}, 
    {sin(angle), 1, cos(angle)}
  };

  float[][] rotationZ = {
    {cos(angle), -sin(angle), 0}, 
    {sin(angle), cos(angle), 0}, 
    {0, 0, 1}
  };

  for (PVector v : points) {
    PVector rotated2D = matmul(rotationZ, v);
    rotated2D = matmul(rotationX, rotated2D);
    rotated2D = matmul(rotationZ, rotated2D);
    PVector projected2D = matmul(projection, rotated2D);
    point(rotated2D.x*size, rotated2D.y*size);
  }
  

  angle += 0.02;
}

float[][] vecToMatrix(PVector v) {
  float[][] m = new float[3][1];
  m[0][0] = v.x;
  m[1][0] = v.y;
  m[2][0] = v.z;
  return m;
}

PVector matrixToVec(float[][] m) {
  PVector v = new PVector();
  v.x = m[0][0];
  v.y = m[1][0];
  if (m.length > 2) {
    v.z = m[2][0];
  }
  return v;
}

void logMatrix(float[][] m) {
  int cols = m[0].length;
  int rows = m.length;
  println(rows + "x" + cols);
  println("----------------");
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      print(m[i][j] + " ");
    }
    println();
  }
  println();
}


PVector matmul(float[][] a, PVector b) {
  float[][] m = vecToMatrix(b);
  return matrixToVec(matmul(a, m));
}

float[][] matmul(float[][] a, float[][] b) {
  int colsA = a[0].length;
  int rowsA = a.length;
  int colsB = b[0].length;
  int rowsB = b.length;

  if (colsA != rowsB) {
    println("Columns of A must match rows of B");
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

void connect(PVector a, PVector b, float multiplier) {
  line(a.x*multiplier, a.y*multiplier, b.x*multiplier, b.y*multiplier);
}
