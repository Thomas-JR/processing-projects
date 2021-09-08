class Particle {
  PVector coordinates;
  int type;

  Particle(int x, int y, int type) {
    coordinates = new PVector(x, y);
    this.type = type;
  }

  void update() {
    PVector pos;
    pos = new PVector(screen.squareSize/2 + coordinates.x*screen.squareSize, screen.squareSize/2 + coordinates.y*screen.squareSize);
    fill(screen.colours[type][0], screen.colours[type][1], screen.colours[type][2]);
    rect(pos.x, pos.y, screen.squareSize, screen.squareSize);
    
    if (type == 0 && !gravity()) {
      moveHorizontal(int(random(2)));
    } else if (type == 2) {
      moveHorizontal(int(random(2)));
      moveVertical(int(random(2)));
    }
  }

  boolean gravity() {
    boolean move = false;
    if (coordinates.y < screen.screenSize.y-1) {
      move = true;
      for (Particle p : screen.particles) {
        if (p != this) {
          if (p.coordinates.x == coordinates.x && p.coordinates.y == coordinates.y+1) {
            move = false;
          }
        }
      }
    }
    if (move) {
      coordinates.y += 1;
      return true;
    }
    return false;
  }

  void moveHorizontal(int direction) {
    boolean move = false;
    if (direction == 0) {
      direction --;
      if (coordinates.x > 0) {
        move = true;
      }
    } else {
      if (coordinates.x < screen.screenSize.x-screen.spacerSize/screen.squareSize-1) {
        move = true;
      }
    }
    for (Particle p : screen.particles) {
      if (p != this) {
        if (p.coordinates.x == coordinates.x+direction && p.coordinates.y == coordinates.y) {
          move = false;
        }
      }
    }
    if (move) {
      coordinates.x += direction;
    }
  }
  
  void moveVertical(int direction) {
    boolean move = false;
    if (direction == 0) {
      direction --;
      if (coordinates.y > 0) {
        move = true;
      }
    } else {
      if (coordinates.y < screen.screenSize.y) {
        move = true;
      }
    }
    for (Particle p : screen.particles) {
      if (p != this) {
        if (p.coordinates.x == coordinates.x && p.coordinates.y == coordinates.y+direction) {
          move = false;
        }
      }
    }
    if (move) {
      coordinates.y += direction;
    }
  }
}
