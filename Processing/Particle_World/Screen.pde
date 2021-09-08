class Screen {
  PVector screenSize;
  int squareSize;
  int spacerSize;

  Particle[] particles;
  int nParticles;

  int nTypes;
  int type;
  int[][] colours;

  int size;
  boolean lastPressed;

  Screen(int squareSize, int nTypes, int spacerSize) {
    this.squareSize = squareSize;
    this.spacerSize = spacerSize;
    screenSize = new PVector(int(width/squareSize), int(height/squareSize));
    lastPressed = false;
    size = 1;

    type = 0;
    this.nTypes = nTypes;
    colours = new int[nTypes][3];
    colours[0] = new int[]{128, 197, 222};
    colours[1] = new int[]{126, 200, 80};
    colours[2] = new int[]{220, 220, 220};
  }

  void update() {
    for (int i = 0; i < nParticles; i++) {
      particles[i].update();
    }
    if (mousePressed) {
      if (mouseButton == LEFT) {
        if (mouseX < width-spacerSize) {
          if (size == 1) {
            newParticle(mouseX, mouseY);
          } else if (size >= 2) {
            newParticle(mouseX, mouseY);
            newParticle(mouseX-squareSize, mouseY);
            newParticle(mouseX+squareSize, mouseY);
            newParticle(mouseX, mouseY-squareSize);
            newParticle(mouseX, mouseY+squareSize);
            if (size == 3) {
              newParticle(mouseX, mouseY-2*squareSize);
              newParticle(mouseX, mouseY+2*squareSize);
              newParticle(mouseX-2*squareSize, mouseY);
              newParticle(mouseX+2*squareSize, mouseY);
              newParticle(mouseX-squareSize, mouseY-squareSize);
              newParticle(mouseX+squareSize, mouseY+squareSize);
              newParticle(mouseX-squareSize, mouseY+squareSize);
              newParticle(mouseX+squareSize, mouseY-squareSize);
            }
          }
        } else if (!lastPressed) {
          for (int i = 0; i < nTypes; i++) {
            if (mouseY < int(height/nTypes/2)*(i+1)) {
              type = i;
              break;
            }
          }
          for (int i = 0; i < 3; i++) {
            if (mouseY < int(height/2+height/3/2*(i+1))) {
              size = i+1;
              break;
            }
          }
        }
      } else {
        destroyParticle();
      }
    }

    sideSelector();
  }

  void newParticle(float X, float Y) {
    // Find x,y coordinates for new particle
    boolean foundCoordinates = true;
    PVector coordinates = new PVector(-1, -1);
    coordinates = findCoordinates(X, Y);
    if (int(coordinates.x) == -1) {
      foundCoordinates = false;
    }
    if (foundCoordinates && nParticles > 0) {
      for (Particle p : particles) {
        if (p.coordinates.x == coordinates.x && p.coordinates.y == coordinates.y) {
          foundCoordinates = false;
          break;
        }
      }
    }
    if (foundCoordinates) {
      Particle[] newParticles = new Particle[nParticles+1];
      for (int i = 0; i < nParticles; i++) {
        newParticles[i] = particles[i];
      }
      newParticles[nParticles++] = new Particle(int(coordinates.x), int(coordinates.y), type);
      particles = newParticles;
    }
  }

  void sideSelector() {
    for (int i = 0; i < nTypes; i++) {
      PVector pos = new PVector(int(width-spacerSize/2), int(height/nTypes/4 + height/nTypes*i/2));
      fill(screen.colours[i][0], screen.colours[i][1], screen.colours[i][2]);
      rect(pos.x, pos.y, spacerSize, int(height/nTypes/2));
    }
    for (int i = 0; i < 3; i++) {
      PVector pos = new PVector(int(width-spacerSize/2), int(height/2 + height/3/4 + height/3/2*i));
      fill(255);
      ellipse(pos.x, pos.y, spacerSize*(i+0.5)*1/3, spacerSize*(i+0.5)*1/3);
    }
    lastPressed = mousePressed;
  }

  void destroyParticle() {
    PVector coordinates = new PVector(0, 0);
    coordinates = findCoordinates(X, Y);

    int index = -1;
    if (nParticles > 0) {
      for (int i = 0; i < nParticles; i++) {
        if (particles[i].coordinates.x == coordinates.x && particles[i].coordinates.y == coordinates.y) {
          index = i;
          break;
        }
      }
    }
    if (index >= 0) {
      Particle[] newParticles = new Particle[nParticles-1];
      int j = 0;
      for (int i = 0; i < nParticles; i++) {
        if (i == index) {
          continue;
        }
        newParticles[j] = particles[i];
        j++;
      }
      particles = newParticles;
      nParticles -= 1;
    }
  }

  PVector findCoordinates(float X, float Y) {
    PVector coordinates = new PVector(-1, -1);
    for (int y = 0; y < screenSize.y; y++) {
      for (int x = 0; x < screenSize.x; x++) {
        PVector pos = new PVector(squareSize/2 + x*squareSize, squareSize/2 + y*squareSize);
        if (X > pos.x - squareSize/2 && X < pos.x + squareSize/2) {
          if (Y > pos.y - squareSize/2 && Y < pos.y + squareSize/2) {
            coordinates = new PVector(x, y);
            return coordinates;
          }
        }
      }
    }
    return coordinates;
  }
}
