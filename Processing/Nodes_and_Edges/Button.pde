public class Button {
  private PVector pos;
  private float radius;
  private String name;
  private int type;

  public Button(PVector pos, float radius, String name, int type) {
    this.pos = pos;
    this.radius = radius;
    this.name = name;
    this.type = type;
  }

  public void display() {
    stroke(0);
    strokeWeight(1);
    fill(200);
    ellipse(pos.x, pos.y, radius*2, radius*2);
    fill(0);
    textSize(10);
    text(name, pos.x, pos.y);
  }
  
  public boolean collides(PVector otherPos) {
    return dist(pos.x, pos.y, otherPos.x, otherPos.y) < radius;
  }
}
