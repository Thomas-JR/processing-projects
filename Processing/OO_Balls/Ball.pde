public class Ball extends Object implements Movable {
  private PVector direction;
  private float radius;
  private final static int MIN_RADIUS = 10;
  private final static int MAX_RADIUS = 20;
  private final static int MAX_SPEED = 5;
  
  public Ball() {
    super(random(width), random(height));
    radius = random(MIN_RADIUS, MAX_RADIUS);
    randomDirection();
  }
  
  public Ball(float x, float y) {
    super(x, y);
    radius = random(MIN_RADIUS, MAX_RADIUS);
    randomDirection();
  }
  
  public Ball(float x, float y, float radius) {
    super(x, y);
    this.radius = radius;
    randomDirection();
  }
  
  public Ball(float x, float y, float radius, Colour colour) {
    super(x, y, colour);
    this.radius = radius;
    randomDirection();
  }
  
  public void move() { 
    updatePos(direction);
    checkWallCollision();
  }
  
  public void update() {
    move();
    show();
  }
  
  public void show() {
    fill(getColour().r, getColour().g, getColour().b);
    ellipse(getPos().x, getPos().y, radius*2, radius*2);
  }
  
  private void randomDirection() {
    float angle = random(2*PI);
    float speed = random(MAX_SPEED);
    direction = new PVector(cos(angle)*speed, sin(angle)*speed);
  }
  
  public void checkWallCollision() {
    if (getPos().x < radius) {
      direction = new PVector(-direction.x, direction.y);
      setPos(new PVector(2*radius-getPos().x, getPos().y));
    }
    if (getPos().x > width-radius) {
      direction = new PVector(-direction.x, direction.y);
      setPos(new PVector(2*height-2*radius-getPos().x, getPos().y));
    }
    if (getPos().y < radius) {
      direction = new PVector(direction.x, -direction.y);
      setPos(new PVector(getPos().x, 2*radius-getPos().y));
    }
    if (getPos().y > height-radius) {
      direction = new PVector(direction.x, -direction.y);
      setPos(new PVector(getPos().x, 2*width-2*radius-getPos().y));
    }
  }
}
