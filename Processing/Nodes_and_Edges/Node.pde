public class Node {
  private float radius;
  private PVector pos, vel;
  private float colour;
  private boolean selected = false;
  private boolean hsb;
  private int val;
  private Edge[] edges;
  private int edgesCount = 0, maxEdges = 1;

  private static final float GRAVITY_CONSTANT = 0.00005;
  private static final float SPEED_RANGE = 3;
  private static final float RADIUS_LOWER = 30;
  private static final float RADIUS_UPPER = 30;
  private static final float WEIGHT_LOWER = 0;
  private static final float WEIGHT_UPPER = 10;

  public Node() {
    radius = random(RADIUS_LOWER, RADIUS_UPPER);
    pos = new PVector(random(radius, width-radius), random(radius, height-radius));
    float angle = random(2*PI);
    float speed = random(SPEED_RANGE);
    vel = new PVector(cos(angle)*speed, sin(angle)*speed);
    colour = random(255);
    val = int(random(WEIGHT_LOWER, WEIGHT_UPPER+1));
  }

  public Node(float colour) {
    radius = random(RADIUS_LOWER, RADIUS_UPPER);
    pos = new PVector(random(radius, width-radius), random(radius, height-radius));
    float angle = random(2*PI);
    float speed = random(SPEED_RANGE);
    vel = new PVector(cos(angle)*speed, sin(angle)*speed);
    this.colour = colour;
    val = int(random(WEIGHT_LOWER, WEIGHT_UPPER+1));
  }

  public Node(PVector pos, int weight) {
    radius = random(RADIUS_LOWER, RADIUS_UPPER);
    this.pos = pos;
    float angle = random(2*PI);
    float speed = random(SPEED_RANGE);
    vel = new PVector(cos(angle)*speed, sin(angle)*speed);
    colour = random(255);
    val = weight;
  }

  public void display() {
    noStroke();
    strokeWeight(1);
    stroke(0);
    if (selected) {
      strokeWeight(2);
      if (hsb) {
        stroke(60, 255, 0);
      } else {
        stroke(0);
      }
    }
    if (hsb) {
      fill(colour, 255, 255);
    } else {
      fill(255);
    }
    ellipse(pos.x, pos.y, radius*2, radius*2);
    fill(0);
    strokeWeight(2);
    textSize(20);
    text(val, pos.x, pos.y);
  }

  private void update() {
    boolean verticalCollision = false, horizontalCollision = false;
    //vel.y += 0.1;
    if (pos.x + vel.x - radius < 0) {
      pos.x = -(pos.x + vel.x - 2*radius);
      vel.x *= -1;
      horizontalCollision = true;
    } else if (pos.x + vel.x + radius > width) {
      pos.x = 2*width-(pos.x + vel.x + 2*radius);
      vel.x *= -1;
      horizontalCollision = true;
    }
    if (pos.y + vel.y - radius < 0) {
      pos.y = -(pos.y + vel.y - 2*radius);
      vel.y *= -1;
      verticalCollision = true;
    } else if (pos.y + vel.y + radius > height) {
      pos.y = 2*height-(pos.y + vel.y + 2*radius);
      vel.y *= -1;
      verticalCollision = true;
    }
    if (!horizontalCollision) {
      pos.x += vel.x;
    }
    if (!verticalCollision) {
      pos.y += vel.y;
    }
    vel.mult(0.95);
  }

  public void showEdges() {
    for (int i = 0; i < edgesCount; i++) {
      edges[i].display();
    }
  }

  public boolean collidesWith(Node otherNode) {
    if (dist(pos.x+vel.x, pos.y+vel.y, otherNode.pos.x+otherNode.vel.x, otherNode.pos.y+otherNode.vel.y) < radius + otherNode.radius) {
      return true;
    }
    return false;
  }

  public boolean collidesWith(PVector otherPos, float distance) {
    if (dist(pos.x, pos.y, otherPos.x, otherPos.y) < distance) {
      return true;
    }
    return false;
  }

  public PVector[] collide(Node otherNode) {
    PVector[] newVectors;
    PVector newDirection = new PVector();
    PVector newPosition = new PVector();
    float v1 = mag(vel.x, vel.y);
    float v2 = mag(otherNode.vel.x, otherNode.vel.y);
    float m1 = mass();
    float m2 = otherNode.mass();
    float t1 = atan2(vel.y, vel.x);
    float t2 = atan2(otherNode.vel.y, otherNode.vel.x);
    float phi = angleBetween(pos, otherNode.pos);
    newDirection.x = (v1*cos(t1-phi)*(m1-m2) + 2*m2*v2*cos(t2-phi))/(m1+m2)*cos(phi) + v1*sin(t1-phi)*cos(phi + PI/2);
    newDirection.y = (v1*cos(t1-phi)*(m1-m2) + 2*m2*v2*cos(t2-phi))/(m1+m2)*sin(phi) + v1*sin(t1-phi)*sin(phi + PI/2);
    //newPosition = new PVector(-cos(phi)*mag(pos.x-otherNode.pos.x, pos.y-otherNode.pos.y)/2, -sin(phi)*mag(pos.x-otherNode.pos.x, pos.y-otherNode.pos.y)/2);
    newPosition.add(pos);  
    newDirection.mult(1);
    newVectors = new PVector[]{newDirection, newPosition};
    return newVectors;
  }

  public void gravity() {
    if (collidesWith(new PVector(mouseX, mouseY), radius)) {
      return;
    }
    float angle = angleBetween(pos, new PVector(mouseX, mouseY));
    vel.x += 0.1*cos(angle);
    vel.y += 0.1*sin(angle);
    //vel.x += 100*cos(angle)/pow(dist(mouseX, mouseY, pos.x, pos.y), 2);
    //vel.y += 100*sin(angle)/pow(dist(mouseX, mouseY, pos.x, pos.y), 2);
  }

  public void gravity(Node otherNode, boolean normalGravity) {
    if (collidesWith(otherNode)) {
      return;
    }
    float angle = angleBetween(pos, otherNode.pos);
    if (normalGravity) {
      vel.x += 1000*GRAVITY_CONSTANT*cos(angle);
      vel.y += 1000*GRAVITY_CONSTANT*sin(angle);
    } else {
      vel.x -= 1*GRAVITY_CONSTANT*mass()*otherNode.mass()/pow(dist(pos.x, pos.y, otherNode.pos.x, otherNode.pos.y), 2)*cos(angle);
      vel.y -= 1*GRAVITY_CONSTANT*mass()*otherNode.mass()/pow(dist(pos.x, pos.y, otherNode.pos.x, otherNode.pos.y), 2)*sin(angle);
    }
  }

  private float angleBetween(PVector a, PVector b) {
    return atan2(b.y - a.y, b.x - a.x);
  }

  public void slow(float factor) {
    vel.mult(factor);
  }

  public float mass() {
    return 2*PI*pow(radius, 2);
  }

  public void borderResistance() {
    vel.x += 1000/pow(pos.x, 2);
    vel.x -= 1000/pow(width-pos.x, 2);
    vel.y += 1000/pow(pos.y, 2);
    vel.y -= 1000/pow(height-pos.y, 2);
  }

  private void updateMaxEdges() {
    if (edgesCount + 1 < maxEdges) {
      return;
    }
    // Ensure that maxEdges is in an available scope
    while (maxEdges < edgesCount + 1) {
      maxEdges *= 2;
    }
    // Ensure that nodes has maxNodes number of nodes available
    Edge[] newEdges = new Edge[maxEdges];
    for (int i = 0; i < edgesCount; i++) {
      newEdges[i] = edges[i];
    }
    // Update nodes list
    edges = newEdges;
  }

  public void createEdge(Node node, int weight) {
    int edgePosition = nodeInEdges(node);
    if (edgePosition >= 0) {
      deleteEdge(edges[edgePosition]);
      return;
    }
    updateMaxEdges();
    edges[edgesCount++] = new Edge(this, node, weight);
  }

  public void createEdge(Edge edge) {
    if (edge.from.equals(this)) {
      updateMaxEdges();
      edges[edgesCount++] = edge;
    }
  }

  private int nodeInEdges(Node node) {
    for (int i = 0; i < edgesCount; i++) {
      if (edges[i].to.equals(node)) {
        return i;
      }
    }
    return -1;
  }

  private void deleteEdge(Edge edge) {
    Edge[] newEdges = new Edge[maxEdges];
    int shift = 0;
    for (int i = 0; i < edgesCount-1; i++) {
      if (edges[i] == edge) {
        shift += 1;
      }
      newEdges[i] = edges[i + shift];
    }
    edges = newEdges;
    edgesCount--;
  }

  public boolean deleteEdgesToNode(Node node) {
    for (int i = 0; i < edgesCount; i++) {
      if (edges[i].to.equals(node)) {
        deleteEdge(edges[i]);
        return true;
      }
    }
    return false;
  }

  public void pullEdges(boolean attractive) {
    for (int i = 0; i < edgesCount; i++) {
      gravity(edges[i].to, attractive);
    }
  }

  public String toString() {
    return  "Node weight = " + val + ", Connected edges = " + edgesCount + "\n";
  }

  public Node[] targetNodes() {
    Node[] toReturn = new Node[edgesCount];
    for (int i = 0; i < edgesCount; i++) {
      toReturn[i] = edges[i].to;
    }
    return toReturn;
  }

  public void deleteAllEdges() {
    while (edgesCount > 0) {
      deleteEdge(edges[0]);
    }
  }
  
  public float distToNode(Node node) {
    return dist(pos.x, pos.y, node.pos.x, node.pos.y);
  }
  
  public int totalEdgeWeight() {
    int totalEdgeCost = 0;
    for (int i = 0; i < edgesCount; i++) {
      totalEdgeCost += edges[i].weight;
    }
    return totalEdgeCost;
  }
}

/* old code
 
 
 public Node(float radius, PVector pos) {
 this.radius = radius;
 this.pos = pos;
 float angle = random(2*PI);
 float speed = random(SPEED_RANGE);
 vel = new PVector(cos(angle)*speed, sin(angle)*speed);
 colour = random(255);
 val = int(random(WEIGHT_LOWER, WEIGHT_UPPER+1));
 }
 
 public Node(PVector pos) {
 radius = random(RADIUS_LOWER, RADIUS_UPPER);
 this.pos = pos;
 float angle = random(2*PI);
 float speed = random(SPEED_RANGE);
 vel = new PVector(cos(angle)*speed, sin(angle)*speed);
 colour = random(255);
 val = int(random(WEIGHT_LOWER, WEIGHT_UPPER+1));
 }
 
 public Node(PVector pos, boolean hsb) {
 radius = random(RADIUS_LOWER, RADIUS_UPPER);
 this.pos = pos;
 float angle = random(2*PI);
 float speed = random(SPEED_RANGE);
 vel = new PVector(cos(angle)*speed, sin(angle)*speed);
 colour = random(255);
 this.hsb = hsb;
 val = int(random(WEIGHT_LOWER, WEIGHT_UPPER+1));
 }
 
 
 public void deleteEdge(Node node) {
 Edge[] newEdges = new Edge[maxEdges];
 int shift = 0;
 for (int i = 0; i < edgesCount-1; i++) {
 if (edges[i].to.equals(node)) {
 shift += 1;
 }
 newEdges[i] = edges[i + shift];
 }
 edges = newEdges;
 edgesCount--;
 }
 */
