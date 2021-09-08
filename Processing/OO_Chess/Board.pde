public class Board {
  Piece pieces;

  public Board() {
  }

  public void show() {
    int squareSize = min(width, height)/8;
    boolean colour = false;
    for (int i = 0; i < squareSize*8; i += squareSize) {
      for (int j = 0; j < squareSize*8; j += squareSize) {
        if (colour) {
          fill(0);
          colour = false;
        } else {
          fill(255);
          colour = true;
        }
        rect(i, j, squareSize, squareSize);
      }
      if (colour) {
        colour = false;
        continue;
      }
      colour = true;
    }
  }
}
