public class Colour {
  private float r, g, b;
  
  public Colour() {
    r = random(255);
    g = random(255);
    b = random(255);
  }
  
  public Colour(float r, float g, float b) {
    this.r = r;
    this.g = g;
    this.b = b;
  }
  
  public float getR() {
    return r;
  }
  
  public float getG() {
    return g;
  }
  
  public float getB() {
    return b;
  }
}
