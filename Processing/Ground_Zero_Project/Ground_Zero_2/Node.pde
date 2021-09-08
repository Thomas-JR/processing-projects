class Node {
  String name;
  float x, y, size, originalSize, targetSize, people, zombies;
  int ID;
  IntList connectedNodes;

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
    //Selecting and visual aspects of the nodes being displayed
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
    //Colouring of nodes and actual displaying of the nodes
    people = peops_;
    zombies = zombs_;
    stroke(100);
    float r = 0;
    float g = 0;
    float b = 0;
    //colour blending for people to zombies
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
    ellipse(x, y, size, size);
    fill(0);
    textSize(size/8);
    textAlign(CENTER);
    //Labelling nodes
    text(name + "\nPEOPLE = " + int(peops_) + "\nZOMBIES` = " + int(zombs_), x, y-8);
    for (int n = 0; n < connectedNodes.size(); n++) {
      int node = connectedNodes.get(n);
      float angle = atan2(nodes[node].y-y, nodes[node].x-x);
      line(x+cos(angle)*size/2, y+sin(angle)*size/2, nodes[node].x-cos(angle)*nodes[node].size/2, nodes[node].y-sin(angle)*nodes[node].size/2);
    }
  }
}