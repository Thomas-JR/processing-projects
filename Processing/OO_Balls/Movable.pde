public interface Movable {
  PVector direction = new PVector();
  void move();
  void checkWallCollision();
}
