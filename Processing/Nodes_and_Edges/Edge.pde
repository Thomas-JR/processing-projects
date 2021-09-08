public class Edge {
  private Node from, to;
  private int weight;
  private boolean hsb;

  private static final float WEIGHT_LOWER = 0;
  private static final float WEIGHT_UPPER = 80;
  
  public Edge(Node from, Node to, int weight) {
    this.from = from;
    this.to = to;
    this.weight = weight;
  }

  public void display() {
    if (hsb) {
      stroke(255, 255, 0);
    } else {
      stroke(0);
    }
    strokeWeight(2);
    line(from.pos.x, from.pos.y, to.pos.x, to.pos.y);
    
    // Display weight
    fill(0);
    textSize(16);
    PVector a1 = new PVector(), b1 = new PVector(), a2 = new PVector(), b2 = new PVector();
    a1.set(from.pos);
    b1.set(to.pos);
    a2.set(from.pos);
    b2.set(to.pos);
    PVector textPos = a1.add(b1.sub(a1).mult(0.5));
    textPos.add(b2.sub(a2).normalize().rotate(PI/2).mult(10));
    text(weight, textPos.x, textPos.y);
  }
  
  public boolean hasNode(Node node) {
    return to.equals(node) || from.equals(node);
  }
  
  public int returnWeight() {
    return weight;
  }
  
  public String toString() {
    return "Edge  (" + from.val + ", " + to.val + ") with weight " + weight + "\n";
  }
}

/* old code


  public Edge(Node to) {
    this.to = to;
    weight = int(random(1, WEIGHT_RANDOMWEIGHT_RANDOM));
    this.hsb = hsb;
  }
  */
