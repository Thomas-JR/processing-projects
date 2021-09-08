public abstract class Piece {
  boolean white;
  float squareSize;
  PVector boardPos;
  boolean hasMoved;
  
  public Piece(float squareSize, PVector boardPos) {
    this.squareSize = squareSize;
    this.boardPos = boardPos;
    hasMoved = false;
  }
  
  public abstract void showImage(PVector pos);
  
  public void showPiece() {
    showImage(getBoardPos());
  }
  
  public void showPiece(PVector pos) {
    showImage(pos);
  }
  
  public PVector getBoardPos() {
    return new PVector((boardPos.x-0.5)*squareSize, (0.5-boardPos.y)*squareSize);
  }
  
  public void setBoardPos(PVector pos) {
    boardPos = pos;
  }
}
