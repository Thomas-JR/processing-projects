class Game {
  int minutes;
  boolean lastPressed;
  int selected;
  PImage back;
  
  void update() {
    minutes += 1;
  }
}

class Person {
  float nodePos;
  float targetNodePos;
  float x, y;
  int type;

  Person() {
    nodePos = int(random(0, nodes.length));
    type = int(random(2));
  }

  void update() {
  }
}

class Node {
  String name;
  float x, y, size, originalSize, targetSize;
  int ID;
  IntList connectedNodes, people, zombies;

  Node(int ID_, float x_, float y_, float originalSize_, String name_, IntList connectedNodes_) {
    ID = ID_;
    x = x_;
    y = y_;
    size = 100;
    originalSize = originalSize_;
    name = name_;
    connectedNodes = connectedNodes_;
  }

  void update() {
    targetSize = originalSize;
    if (dist(mouseX, mouseY, x, y) < size/2) {
      targetSize = originalSize * 1.5;
      if (mousePressed &! state.lastPressed) {
        state.selected = ID;
      }
    }
    size = lerp(size, targetSize, 0.2);
  }

  void show(int peops_, int zombs_) {
    stroke(100);
    int r = 0;
    int g = 0;
    int b = 0;
    if (peops_ > 0) {
      for (int p = 0; p < peops_; p++) {
        if (g < 255)
          g += 255/(peops_+zombs_);
      }
      fill(r, g, b, 150);
    } else if (zombs_ > 0) {
      for (int z = 0; z < zombs_; z++) {
        if (r < 255)
          r += 255/(peops_+zombs_);
      }
      fill(r, g, b, 150);
    } else
      fill(255, 255, 255, 150);
    ellipse(x, y, size, size);
    fill(0);
    textSize(size/8);
    textAlign(CENTER);
    text(name + "\nPEOPLE = " + int(peops_) + "\nZOMBIE = " + int(zombs_), x, y-8);
    if (ID != 0) {
      for (int node = 0; node < connectedNodes.size(); node++) {
        float angle = atan2(nodes[node].y-y, nodes[node].x-x);
        line(x+cos(angle)*size/2, y+sin(angle)*size/2, nodes[node].x-cos(angle)*nodes[node].size/2, nodes[node].y-sin(angle)*nodes[node].size/2);
      }
    }
  }
}