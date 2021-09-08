public class Knight extends Piece implements Moveable {
  PImage image;
  boolean white;
  
  public Knight(float squareSize, boolean white, PVector boardPos) {
    super(squareSize, boardPos);
    this.white = white;
    int imageName = 2;
    if (white) {
      imageName += 6;
    }
    image = loadImage("images\\" + imageName + ".png");
    image.resize(int(squareSize), int(squareSize));
  }
  
  public boolean legalMove() {
    return false;
  }
  
  public void showImage(PVector pos) {
    image(image, pos.x, pos.y);
  }
}
