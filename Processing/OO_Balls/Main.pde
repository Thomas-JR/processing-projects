public class Main {
  private ArrayList<Ball> balls = new ArrayList<Ball>();
  private final static int MIN_DELETION_DISTANCE = 50;
  
  public Main(int ballCount) {
    for (int i = 0; i < ballCount; i++) {
      addBall();
    }
  }
  
  public void update() {
    for (Ball b : balls) {
      b.update();
    }  
  }
  
  public void addBall() {
    balls.add(new Ball());
  }
  
  public void removeBall(PVector pos) {
    ArrayList<Ball> ballsToDelete = new ArrayList<Ball>();
    for (Ball b : balls) {
      if (b.distanceTo(pos) < MIN_DELETION_DISTANCE) {
        ballsToDelete.add(b);
      }
    }
    for (Ball b : ballsToDelete) {
      balls.remove(b);
    }
  }
}
