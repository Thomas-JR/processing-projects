public class Piece {
  PVector pos;
  PImage img;
  
  public Piece(PVector pos) {
    this.pos = pos;
  }
  
  public void move(PVector to) {
    pos = to;
  }
  
  public boolean isValidMove(PVector to) {
    return true;
  }
}
