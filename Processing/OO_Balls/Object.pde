public abstract class Object {
  private PVector pos;
  private Colour colour;
  
  public Object(float x, float y) {
    pos = new PVector(x, y);
    colour = new Colour();
  }
  
  public Object(float x, float y, Colour colour) {
    pos = new PVector(x, y);
    this.colour = colour;
  }
  
  public PVector getPos() {
    return pos;
  }
  
  public Colour getColour() {
    return colour;
  }
  
  public void setPos(PVector pos) {
    this.pos = pos;
  }
  
  public void updatePos(PVector pos) {
    this.pos = new PVector(this.pos.x + pos.x, this.pos.y + pos.y);
  }
  
  public abstract void show();
  
  public float distanceTo(PVector targetPos) {
    return dist(pos.x, pos.y, targetPos.x, targetPos.y);
  }
}
