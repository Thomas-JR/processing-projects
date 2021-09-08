public class Screen {
  private int screenSize;
  private ArrayList<PVector> positions;

  Screen() {
    screenSize = min(width, height)/40;
    for (int y = 0; y < height/screenSize; y++) {
      for (int x = 0; x < width/screenSize; x++) {
        positions.add(new PVector(x, y));
      }
    }
  }
  
  public void update(PVector mousePos) {
    for (PVector p : positions) {
      if (dist(mousePos.x, mousePos.y, positions.x, positions.y) < scrrenSize/2) {
        p.resetLife;
      }
      p.update;
    }
  }
}
