class Node {
  String name;
  float x, y, size, originalSize, targetSize, people, zombies, dDistance;
  int ID;
  IntList connectedNodes;
  boolean dAlive;

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
    //Selecting and visual aspects of the nodes being updated
    targetSize = originalSize;
    if (dist(mouseX, mouseY, x, y) < size/2) {
      targetSize = originalSize * 1.5;
      if (mousePressed &! state.lastPressed) {
        if (mouseButton == LEFT)
          state.selected = ID;
        else
          makeZombie(ID, state.clickPower);
      }
    }
    size = lerp(size, targetSize, 0.2);
  }

  void show(float peops_, float zombs_) {
    people = peops_;
    zombies = zombs_;
    stroke(100);
    float r = 0;
    float g = 0;
    float b = 0;
    // Colour blending for ratio of people to zombies
    if (people > 0 || zombies > 0) {
      if (people > 0) {
        for (int p = 0; p < people; p++) {
          if (g < 255)
            g += 255/(people+zombies);
        }
      }
      if (zombies > 0) {
        for (int z = 0; z < zombies; z++) {
          if (r < 255)
            r += 255/(people+zombies);
        }
      } 
      fill(r, g, b, 150);
    } else
      fill(255, 255, 255, 150);
    // Displaying nodes
    ellipse(x, y, size, size);
    fill(0);
    textSize(size/8);
    textAlign(CENTER);
    //Labelling nodes
    text(name + "\nPEOPLE = " + int(peops_) + "\nZOMBIES = " + int(zombs_), x, y-8);
    for (int n : connectedNodes) {
      float angle = atan2(nodes[n].y-y, nodes[n].x-x);
      line(x+cos(angle)*size/2, y+sin(angle)*size/2, nodes[n].x-cos(angle)*nodes[n].size/2, nodes[n].y-sin(angle)*nodes[n].size/2);
    }
  }
}