public class Board {
  private ArrayList<Piece> pieces = new ArrayList<Piece>();
  private float squareSize;
  private Piece heldPiece;
  private boolean lastPressed;
  
  public Board() {
    squareSize = min(width, height)/8;
    resetBoard();
  }
  
  public void update() {
    if (heldPiece != null &! mousePressed) {
      heldPiece.setBoardPos(new PVector(int(mouseX/(squareSize))+1, int(8-mouseY/(squareSize))+1));
      heldPiece = null;
    } else if (mousePressed &! lastPressed) {
      PVector pos;
      for (Piece p : pieces) {
        pos = p.getBoardPos();
        if (dist(mouseX, mouseY-height, pos.x, pos.y) < squareSize/2) {
          heldPiece = p;
          break;
        }
      }
    }
    showBoard();
    lastPressed = mousePressed;
  }
  
  public void resetBoard() {
      pieces = new ArrayList<Piece>();
      for (int i = 1; i <= 8; i++) {
        pieces.add(new Pawn(squareSize, true, new PVector(i,2)));
        pieces.add(new Pawn(squareSize, false, new PVector(i,7)));
      }
      for (int i = 0; i < 2; i++) {
        pieces.add(new Knight(squareSize, i!=0, new PVector(2, 1+i%2*7)));
        pieces.add(new Knight(squareSize, i!=0, new PVector(7, 1+i%2*7)));
        pieces.add(new Bishop(squareSize, i!=0, new PVector(3, 1+i%2*7)));
        pieces.add(new Bishop(squareSize, i!=0, new PVector(6, 1+i%2*7)));
        pieces.add(new Rook(squareSize, i!=0, new PVector(1, 1+i%2*7)));
        pieces.add(new Rook(squareSize, i!=0, new PVector(8, 1+i%2*7)));
        pieces.add(new Queen(squareSize, i!=0, new PVector(4, 1+i%2*7)));
        pieces.add(new King(squareSize, i!=0, new PVector(5, 1+i%2*7)));
      }
  }
  
  public void showBoard() {
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        fill((x%2 + y%2 + 1)%2*150+75);
        rect(x*width/8, -y*height/8, width/8, height/8); 
      }
    }
    for (Piece p : pieces) {
      if (p.equals(heldPiece)) {
        p.showPiece(new PVector(mouseX, mouseY-height));
        continue;
      }
      p.showPiece();
    }
  }
}
