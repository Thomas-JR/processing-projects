int grid = 9;
Spot[] spots = new Spot[grid * grid];
float gridSize;
boolean turn = true;
boolean lastPressed, check;
int dark;
PImage black, white;
int whites, blacks;
int lastKilled;

void setup() {
  size(1000, 1000);
  gridSize = min(width, height)/grid;
  black = loadImage("black.png");
  white = loadImage("white.png");
  black.resize(int(gridSize), int(gridSize));
  white.resize(int(gridSize), int(gridSize));
  imageMode(CENTER);
  for (int i = 0; i < spots.length; i++) spots[i] = new Spot(i);
}

void draw() {
  background(255);
  noStroke();
  fill(200);
  if (turn) fill(50);
  rectMode(LEFT);
  rect(0, 0, width, gridSize/10);
  rect(0, 0, gridSize/10, height);
  rect(0, height-gridSize/10, width, height);
  rect(width-gridSize/10, 0, width, height);
  rectMode(CENTER);
  stroke(0);
  for (int div = 0; div < grid+1; div++) {
    line(gridSize/2 + gridSize*div, gridSize/2, gridSize/2 + gridSize*div, height-gridSize/2);
    line(gridSize/2, gridSize/2 + gridSize*div, width-gridSize/2, gridSize/2 + gridSize*div);
  }

  int temp = 0;
  if (mousePressed &! lastPressed) {
    for (Spot spot : spots) {
      if (dist(mouseX, mouseY, gridSize/2 + spot.x*gridSize, gridSize/2 + spot.y*gridSize) < gridSize/2) {
        if (!spot.active) {
          spot.active = true;
          temp = spot.ID;
          if (turn == false) {
            spot.dark = false;
            turn = true;
          } else {
            spot.dark = true;
            turn = false;
          }
        } else {
          stroke(200, 0, 0);
          strokeWeight(5);
          line(spot.x*gridSize, spot.y*gridSize, gridSize+spot.x*gridSize, gridSize+spot.y*gridSize);
          line(gridSize+spot.x*gridSize, spot.y*gridSize, spot.x*gridSize, gridSize+spot.y*gridSize);
          strokeWeight(1);
          stroke(0);
        }
      }
    }
    for (Spot spot : spots) {
      IntList checked = new IntList(0);
      if (spot.active) {
        spot.toKill = true;
        spot.alive(spot, checked, spot.dark);
      }
    }

    int i = 0;
    int j = 0;
    for (Spot spot : spots) {
      if (spot.toKill) {
        if (spot.dark == turn) i++;
        else j++;
      }
    }
    if (i == 0 && j > 0) {
      for (Spot spot : spots) {
        if (spot.dark != turn) spot.toKill = false;
      }
      if (turn == false) turn = true;
      else turn = false;
      spots[temp].toKill = false;
      spots[temp].active = false;
      stroke(200, 0, 0);
      strokeWeight(5);
      line(spots[temp].x*gridSize, spots[temp].y*gridSize, gridSize+spots[temp].x*gridSize, gridSize+spots[temp].y*gridSize);
      line(gridSize+spots[temp].x*gridSize, spots[temp].y*gridSize, spots[temp].x*gridSize, gridSize+spots[temp].y*gridSize);
      strokeWeight(1);
      stroke(0);
    }
    if (i > 0 && j > 0) {
      for (Spot spot : spots) {
        if (spot.dark != turn)
          spot.toKill = false;
      }
      spots[temp].toKill = false;
      spots[temp].active = true;
    }
    int t = 0;
    for (Spot spot : spots) {
      if (spot.toKill) {
        t++;
        lastKilled = spot.ID;
      }
    }
    if (turn == true) whites += t;
    else blacks += t;
    println(whites, blacks);
  }
  for (Spot spot : spots) {
    spot.show();
    if (spot.toKill) spot.active = false;
  }
  lastPressed = mousePressed;
}

class Spot {
  int ID, x, y;
  boolean active, dark, toKill;
  IntList connectedNodes;

  Spot(int ID_) {
    ID = ID_;
    x = ID%grid;
    y = ID/grid;
    connectedNodes = new IntList(0);
    if (x > 0) connectedNodes.append(ID-1);
    if (x < grid-1) connectedNodes.append(ID+1);
    if (y > 0) connectedNodes.append(ID-grid);
    if (y < grid - 1) connectedNodes.append(ID+grid);
  }

  void show() {
    if (active) {
      if (dark) image(black, gridSize/2 + x*gridSize, gridSize/2 + y*gridSize);
      else image(white, gridSize/2 + x*gridSize, gridSize/2 + y*gridSize);
    }
    if (toKill) active = false;
    toKill = false;
  }

  void alive(Spot toCheck, IntList checked, boolean type) {
    for (int newSpot : toCheck.connectedNodes) {
      if (!toCheck.active) toKill = false;
      else if (toCheck.dark == type &! checked.hasValue(newSpot)) {
        checked.append(newSpot);
        alive(spots[newSpot], checked, type);
      }
    }
  }
}

void keyPressed() {
  switch(keyCode) {
  case DELETE:
    for (Spot spot : spots) {
      spot.active = false;
    }
  }
}
