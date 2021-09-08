public class Graph {
  private Node[] nodes;
  private int nodesCount = 0, maxNodes = 1;
  private boolean lastPressed = false;
  private Node selected;
  private SoundFile[] files;
  private boolean hsb;
  private Button[] buttons;
  private int buttonsCount;
  private Slider edgeWeightSlider;
  private Slider nodeWeightSlider;
  private PImage img;

  private static final float FRICTION_FACTOR = 0.9f;
  private static final float WEIGHT_LOWER = 0;
  private static final float WEIGHT_UPPER = 80;
  private static final int VERTICAL_RATIO_E = 78;
  private static final int VERTICAL_RATIO_N = 75;

  public Graph(SoundFile[] files, boolean hsb) {
    addNodes(0);
    this.files = files;
    this.hsb = hsb;
    buttonsCount = 2;
    buttons = new Button[buttonsCount];
    buttons[0] = new Button(new PVector(width/20, height/20), min(width, height)/25, "Prim's", 0);
    buttons[1] = new Button(new PVector(3*width/20, height/20), min(width, height)/25, "Dijkstra's", 0);
    edgeWeightSlider = new Slider("Edge", height/80, VERTICAL_RATIO_E);
    nodeWeightSlider = new Slider("Node", height/80, VERTICAL_RATIO_N);
    img = loadImage("img.png");
  }

  public void update() {
    // Use mouse as gravity and friction
    //mouseFunctionOne();
    // Use mouse to create nodes and connect nodes
    mouseFunctionTwo();
    // Inter node gravity
    interNodeGravity();
    // Node Collision
    nodeCollision();
    // Check key pressed
    checkKeyPressed();

    // General update
    int totalCost = 0;
    for (int i = 0; i < nodesCount; i++) {
      nodes[i].showEdges();
      totalCost += nodes[i].totalEdgeWeight();
    }
    println(totalCost/2);
    for (int i = 0; i < nodesCount; i++) {
      nodes[i].borderResistance();
      nodes[i].update();
      nodes[i].display();
    }
    //Update Buttons
    updateButtons();
    edgeWeightSlider.update();
    nodeWeightSlider.update();
    displayImg();

    lastPressed = mousePressed;
  }

  private void updateMaxNodes(int nodesToMake) {
    if (nodesCount + nodesToMake < maxNodes) {
      return;
    }
    // Ensure that maxNodes is in an available scope
    while (maxNodes < nodesCount + nodesToMake) {
      maxNodes *= 2;
    }
    // Ensure that nodes has maxNodes number of nodes available
    Node[] newNodes = new Node[maxNodes];
    for (int i = 0; i < nodesCount; i++) {
      newNodes[i] = nodes[i];
    }
    // Update nodes list
    nodes = newNodes;
  }

  public void addNodes(int nodesToAdd) {
    // Ensure nodes can fit in the new nodes
    updateMaxNodes(nodesToAdd);
    // Instantiate the new nodes
    for (int i = 0; i < nodesToAdd; i++) {
      createNode();
    }
    if (nodesCount <= 1) {
      return;
    }
    for (int i = 0; i < int(random(nodesCount-1)); i++) {
      int randomNode = int(random(nodesCount-2));
      if (nodes[nodesCount-1].distToNode(nodes[randomNode]) < 300) {
        int randomWeight = int(random(WEIGHT_LOWER, WEIGHT_UPPER));
        nodes[nodesCount-1].createEdge(nodes[randomNode], randomWeight);
        nodes[randomNode].createEdge(nodes[nodesCount-1], randomWeight);
      }
    }
  }

  public void addNodes(int nodesToAdd, float colour) {
    // Ensure nodes can fit in the new nodes
    updateMaxNodes(nodesToAdd);
    // Instantiate the new nodes
    for (int i = 0; i < nodesToAdd; i++) {
      createNode(colour);
    }
  }

  public void addNodes(PVector pos) {
    // Ensure nodes can fit in the new nodes
    updateMaxNodes(1);
    // Instantiate the new nodes
    createNode(pos);
  }

  public void createNode() {
    // Random node creation
    int attempts = 0;
    while (attempts++ < 1000) {
      Node newNode = new Node();
      boolean collides = false;
      for (int j = 0; j < nodesCount; j++) {
        if (newNode.collidesWith(nodes[j])) {
          collides = true;
          break;
        }
      }
      if (!collides) {
        nodes[nodesCount++] = newNode;
        playSound("createNode");
        break;
      }
    }
    if (attempts == 100) {
      println("FAILED TO MAKE NODE");
      exit();
    }
  }

  public void createNode(float colour) {
    // Random node creation
    int attempts = 0;
    while (attempts++ < 1000) {
      Node newNode = new Node(colour);
      boolean collides = false;
      for (int j = 0; j < nodesCount; j++) {
        if (newNode.collidesWith(nodes[j])) {
          collides = true;
          break;
        }
      }
      if (!collides) {
        nodes[nodesCount++] = newNode;
        playSound("createNode");
        break;
      }
    }
    if (attempts == 100) {
      println("FAILED TO MAKE NODE");
      exit();
    }
  }


  public void createNode(PVector pos) {
    // Random node creation
    Node newNode = new Node(pos, nodeWeightSlider.weight);
    boolean collides = false;
    for (int i = 0; i < nodesCount; i++) {
      if (newNode.collidesWith(nodes[i])) {
        collides = true;
        break;
      }
    }
    if (!collides) {
      nodes[nodesCount++] = newNode;
      playSound("createNode");
    }
  }

  private void mouseFunctionOne() {
    if (mousePressed) {
      for (int i = 0; i < nodesCount; i++) {
        if (mouseButton == LEFT) {
          nodes[i].gravity();
        } else {
          nodes[i].slow(FRICTION_FACTOR);
        }
      }
    }
  }

  private void mouseFunctionTwo() {
    if (mousePressed &! lastPressed) {
      if (edgeWeightSlider.collide() || nodeWeightSlider.collide()) {
        return;
      }
      for (int i = 0; i < buttonsCount; i++) {
        if (buttons[i].collides(new PVector(mouseX, mouseY))) {
          performOperation(buttons[i].type);
          //println("YEET");
          return;
        }
        // Check bin button
        if (dist(mouseX, mouseY, width-min(width, height)*0.05, height-min(width, height)*0.05) < min(width, height)*0.05) {
          deleteAllNodes();
          return;
        }
      }
      if (mouseButton == LEFT) {
        addNodes(new PVector(mouseX, mouseY));
      } else {
        if (selected != null) {
          for (int i = 0; i < nodesCount; i++) {
            if (nodes[i].collidesWith(new PVector(mouseX, mouseY), nodes[i].radius) &! nodes[i].equals(selected)) {
              // make edge between nodes
              selected.createEdge(nodes[i], edgeWeightSlider.weight);
              nodes[i].createEdge(selected, edgeWeightSlider.weight);
              playSound("createEdge");
              break;
            }
          }
          selected.selected = false;
          selected = null;
        } else {
          for (int i = 0; i < nodesCount; i++) {
            if (nodes[i].collidesWith(new PVector(mouseX, mouseY), nodes[i].radius)) {
              // highlight selected node
              selected = nodes[i];
              selected.selected = true;
              break;
            }
          }
        }
      }
    }
  }

  public String toString() {
    float totalEnergy = 0;
    for (int i = 0; i < nodesCount; i++) {
      totalEnergy += 0.5f*(PI*pow(nodes[i].radius, 2))*mag(nodes[i].vel.x, nodes[i].vel.y);
    }
    return "There are " + nodesCount + " total nodes\n" + "Max nodes = " + maxNodes + "\n" + "Total kinetic energy = " + String.valueOf(totalEnergy);
  }

  private void removeNodes() {
    boolean deletedAny = false;
    for (int i = 0; i < nodesCount; i++) {
      if (nodes[i].collidesWith(new PVector(mouseX, mouseY), 50)) {
        deleteNode(i);
        deletedAny = true;
      }
    }
    if (deletedAny) {
      playSound("deleteNode");
    }
  }

  private void deleteNode(int pos) {
    Node[] newNodes = new Node[maxNodes];
    for (int i = 0; i < nodesCount; i++) {
      nodes[i].deleteEdgesToNode(nodes[pos]);
    }
    int shift = 0;
    // Shift all nodes to newNodes
    for (int i = 0; i < nodesCount-1; i++) {
      if (i == pos) {
        shift += 1;
        if (nodes[i] == selected) {
          selected = null;
        }
      }
      newNodes[i] = nodes[i + shift];
    }
    nodes = newNodes;
    nodesCount--;
  }

  private void interNodeGravity() {
    for (int i = 0; i < nodesCount; i++) {
      nodes[i].pullEdges(true);
    }
    for (int i = 0; i < nodesCount-1; i++) {
      for (int j = i + 1; j < nodesCount; j++) {
        nodes[i].gravity(nodes[j], false);
        nodes[j].gravity(nodes[i], false);
      }
    }
  }

  private void nodeCollision() {
    for (int i = 0; i < nodesCount-1; i++) {
      for (int j = i + 1; j < nodesCount; j++) {
        if (nodes[i].collidesWith(nodes[j])) {
          PVector[] v1 = nodes[i].collide(nodes[j]);
          PVector[] v2 = nodes[j].collide(nodes[i]);
          nodes[i].vel = v1[0];
          nodes[i].pos = v1[1];
          nodes[j].vel = v2[0];
          nodes[j].pos = v2[1];
        }
      }
    }
  }

  private void checkKeyPressed() {
    if (keyPressed) {
      if (keyCode == SHIFT) {
        removeNodes();
      } else {
        addNodes(1);
      }
    }
  }

  public void playSound(String soundType) {
    if (soundType.equals("createNode")) {
      files[0].play();
    } else if (soundType.equals("createEdge")) {
      files[1].play();
    } else {
      files[2].play();
    }
  }

  private void updateButtons() {
    for (int i = 0; i < buttonsCount; i++) {
      buttons[i].display();
    }
  }

  private void performOperation(int type) {
    switch(type) {
    case 0:
      primsAlgorithm();
      break;
    }
  }

  private void displayImg() {
    int size = int(min(width, height)*0.1);
    image(img, width-size, height-size*1.25, size, size*1.25);
  }

  private void deleteAllNodes() {
    saveGraph();
    while (nodes[0] != null) {
      deleteNode(0);
    }
  }

  ////////////////////////////////// PRIM'S ////////////////////////////////////

  private void primsAlgorithm() {
    if (nodesCount <= 1) {
      return;
    }
    Node[] visited = new Node[nodesCount];
    int visitedCount = 0;
    Edge[] toKeep = new Edge[nodesCount-1];
    int toKeepCount = 0;
    for (int i = 0; i < nodesCount; i++) {
      if (i != 0 && nodeInNodes(nodes[i], visited, visitedCount)) {
        continue;
      }
      visited[visitedCount++] = nodes[i];
      while (true) {
        Edge minEdge = minWeightEdge(visited, visitedCount);
        if (minEdge == null) {
          break;
        }
        visited[visitedCount++] = minEdge.to;
        toKeep[toKeepCount++] = minEdge;
      }
    }
    for (int i = 0; i < nodesCount; i++) {
      nodes[i].deleteAllEdges();
      for (int j = 0; j < toKeepCount; j++) {
        if (toKeep[j].from == nodes[i]) {
          nodes[i].createEdge(toKeep[j]);
        }
      }
    }
  }

  private boolean nodeInNodes(Node node, Node[] list, int lengthOfList) {
    for (int i = 0; i < lengthOfList; i++) {
      if (list[i].equals(node)) {
        return true;
      }
    }
    return false;
  }

  private Edge minWeightEdge(Node[] list, int n) {
    Edge min = null;
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < list[i].edgesCount; j++) {
        if (!nodeInNodes(list[i].edges[j].to, list, n)) {
          if (min == null || (list[i].edges[j].weight < min.weight)) {
            min = list[i].edges[j];
          }
        }
      }
    }
    return min;
  }

  private void saveGraph() {
    //int i = 0;
    //String text;
    //while (true) {
    //  text = "graph" + (i+1) + ".txt";
    //  try {
    //    loadImage(text);
    //  }
    //  catch (Exception e) {
    //    break;
    //  }
    //  if (i > 10) {
    //    break;
    //  }
    //}
    //PrintWriter output = createWriter(text);
    //output.println(graphToText());
    //output.flush();
    //output.close();
    //exit();
  }

  private String graphToText() {
    return "Yeet";
  }

  //private int nodeToInt(Node node) {
  //  for (int i = 0; i < nodesCount; i++) {
  //    if (nodes[i].equals(node)) {
  //      return i;
  //    }
  //  }
  //  return -1;
  //}

  //private boolean checkAdded(int target, int[] list, int n) {
  //  for (int i = 0; i < n; i++) {
  //    if (list[i] == target) {
  //      return true;
  //    }
  //  }
  //  return false;
  //}

  //private void createMSP(int[][] edges, int edgesCount) {
  //  for (int i = 0; i < edgesCount; i++) {
  //    nodes[edges[i][0]].onlyEdge(edges[i][1]);
  //  }
  //}
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/* old code
 
 
 public Graph() {
 nodes = new Node[maxNodes];
 edgeWeightSlider = new Slider("Edge", height/80, VERTICAL_RATIO_E);
 nodeWeightSlider = new Slider("Node", height/80, VERTICAL_RATIO_N);
 }
 
 public Graph(int nodesToMake) {
 addNodes(nodesToMake);
 edgeWeightSlider = new Slider("Edge", height/80, VERTICAL_RATIO_E);
 nodeWeightSlider = new Slider("Node", height/80, VERTICAL_RATIO_N);
 }
 
 public Graph(int nodesToMake, SoundFile[] files) {
 addNodes(nodesToMake);
 this.files = files;
 edgeWeightSlider = new Slider("Edge", height/80, VERTICAL_RATIO_E);
 nodeWeightSlider = new Slider("Node", height/80, VERTICAL_RATIO_N);
 }
 
 public Graph(int nodesToMake, SoundFile[] files, boolean hsb) {
 addNodes(nodesToMake);
 this.files = files;
 this.hsb = hsb;
 edgeWeightSlider = new Slider("Edge", height/80, VERTICAL_RATIO_E);
 nodeWeightSlider = new Slider("Node", height/80, VERTICAL_RATIO_N);
 }
 
 
 public Graph(int nodesToMake, float colour) {
 addNodes(nodesToMake, colour);
 edgeWeightSlider = new Slider("Edge", height/80, VERTICAL_RATIO_E);
 nodeWeightSlider = new Slider("Node", height/80, VERTICAL_RATIO_N);
 }
 
 
 private Node[] removeNode(Node[] Q, int length, int pos) {
 Node[] newNodes = new Node[length-1];
 for (int i = 0; i < pos; i++) {
 newNodes[i] = Q[i];
 }
 for (int i = pos; i < length-1; i++) {
 newNodes[i] = Q[i+1];
 }
 return newNodes;
 }
 
 */
