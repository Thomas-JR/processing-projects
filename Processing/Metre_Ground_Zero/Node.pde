class Node {
  float r, g, b;
  int x, y, xPos, yPos, ID;
  IntList connectedNodes;
  boolean wall;

  Node(int ID_, int x_, int y_, IntList connectedNodes_, boolean wall_) {
    ID = ID_;
    x = x_;
    y = y_;
    xPos = width/(xLen*2)+width/xLen*x_;
    yPos = height/(yLen*2)+height/yLen*y_;
    connectedNodes = connectedNodes_;
    wall = wall_;
  }

  void show(int peops_, int zombs_, int sight_) {
    float r = 0;
    float g = 0;
    float b = 0;
    if (peops_ > 0 || zombs_ > 0 || sight_ > 0) {
      if (peops_ > 0) {
        for (int p = 0; p < peops_; p++) {
          if (g < 255)
            g += 255/(peops_+zombs_);
        }
      }
      if (zombs_ > 0) {
        for (int z = 0; z < zombs_; z++) {
          if (r < 255)
            r += 255/(peops_+zombs_);
        }
      } 
      if (sight_ > 0) {
        g = 100;
        b = 255;
      }
      fill(r, g, b, 150);
    } else
      fill(255, 255, 255, 150);
    //stroke(0);
    if (wall)
      fill(0);
    noStroke();
    rect(xPos, yPos, width/xLen, height/yLen);
    for (int i = 0; i < connectedNodes.size(); i++) {
      strokeWeight(2);
      //line(xPos, yPos, nodes[connectedNodes.get(i)].xPos, nodes[connectedNodes.get(i)].yPos);
    }
  }
}