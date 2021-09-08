int xLen = 10;
int yLen = 10;
Node[] nodes = new Node[100];

void setup() {
  size(600, 600);
  int i = 0;
  for (int y = 0; y < yLen; y++) {
    for (int x = 0; x < xLen; x++) {
      IntList connectedNodes = new IntList(0);
      if (x > 0)
        connectedNodes.append(i-1);
      if (x < xLen-1)
        connectedNodes.append(i+1);
      if (y > 0)
        connectedNodes.append(i-xLen);
      if (y < yLen-1)
        connectedNodes.append(i+xLen);
      nodes[i] = new Node(x, y, connectedNodes);
      i++;
    }
  }
}

void draw() {
  for (Node n : nodes) {
    n.show();
  }
}

class Node {
  int x, y;
  float xPos, yPos;
  float distance;
  IntList connectedNodes;

  Node(int x_, int y_, IntList connectedNodes_) {
    x = x_;
    y = y_;
    xPos = width/xLen*x;
    yPos = width/yLen*y;
    connectedNodes = connectedNodes_;
  }

  void show() {
    fill(255);
    rect(xPos, yPos, width/xLen, width/yLen);
    for (int i : connectedNodes) {
      line(xPos, yPos, nodes[i].xPos, nodes[i].yPos);
    }
  }
}