public class Screen {
  PVector dim;
  Flight[] flights;
  int nFlights, squareSize;
  int[][] trailMap;
  private final static float FLIGHT_RADIUS = 5;
  private final static float EVAPORATE_SPEED = 0;
  private final static float DIFFUSE_SPEED = 0.05;
  private final static float SENSOR_ANGLE = PI/12;
  

  Screen() {
    dim = new PVector(width, height);
  }

  Screen(int nFlights, int squareSize) {
    trailMap = new int[height/squareSize][width/squareSize];
    this.squareSize = squareSize;
    dim = new PVector(width, height);
    flights = new Flight[nFlights];
    for (int i = 0; i < nFlights; i++) {
      createFlight(width/2, height/2, squareSize);
    }
  }

  void update() {
    for (Flight f : flights) {
      steer(f);
      f.update();
    }
    updateTrailMap();
    show();
  }

  void show() {
    for (int y = 0; y < height/squareSize; y++) {
      for (int x = 0; x < width/squareSize; x++) {
        if (trailMap[y][x] > 0) {
          fill(trailMap[y][x]);
          rect(x*squareSize, y*squareSize, squareSize, squareSize);
        }
      }
    }
  }

  private void createFlight(int x, int y, float speed) {
    Flight[] newFlights = new Flight[nFlights+1];
    for (int i = 0; i < nFlights; i++) {
      newFlights[i] = flights[i];
    }
    newFlights[nFlights++] = new Flight(x, y, speed);
    flights = newFlights;
  }

  private void updateTrailMap() {
    int[][] newTrailMap = trailMap;
    for (int y = 0; y < height/squareSize; y++) {
      for (int x = 0; x < width/squareSize; x++) {
        float originalValue = trailMap[y][x];
        
        float sum = 0;
        for (int oy = -1; oy <= 1; oy++) {
          for (int ox = -1; ox <= 1; ox++) {
            if (x+ox >= 0 && x+ox < width/squareSize && y+oy >= 0 && y+oy < height/squareSize) {
              sum += trailMap[y+oy][x+ox];
            }
          }
        }
        float blurResult = sum/9;
        float diffusedValue = lerp(originalValue, blurResult, DIFFUSE_SPEED);
        int diffuseAndEvaporateValue = int(max(0, diffusedValue - EVAPORATE_SPEED));
        
        newTrailMap[y][x] = diffuseAndEvaporateValue;
      }
    }
    trailMap = newTrailMap;
    for (Flight f : flights) {
      PVector coordinates = new PVector(int(constrain(f.pos.x/squareSize, 0, width/squareSize-1)), int(constrain(f.pos.y/squareSize, 0, height/squareSize-1)));
      trailMap[int(coordinates.y)][int(coordinates.x)] = 255;
    }
  }
  
  public void steer(Flight f) {
    // Weighted from 0 to 1
      float leftWeight = sense(f, -SENSOR_ANGLE);
      float forwardWeight = sense(f, 0);
      float rightWeight = sense(f, SENSOR_ANGLE);
      
      if (forwardWeight > leftWeight && forwardWeight > rightWeight) {
        return;
      } else if (forwardWeight < leftWeight && forwardWeight < rightWeight) {
        f.vel.rotate(random(-SENSOR_ANGLE, SENSOR_ANGLE));
      } else if (leftWeight < rightWeight) {
        f.vel.rotate(SENSOR_ANGLE);
      } else if (leftWeight < rightWeight) {
        f.vel.rotate(-SENSOR_ANGLE);
      }
  }
  
  public float sense(Flight f, float angle) {
    PVector currentPos = new PVector(f.pos.x, f.pos.y);
    PVector pos = currentPos.add(new PVector(squareSize*2*cos(angle+f.vel.heading()), squareSize*2*sin(angle+f.vel.heading())));
    PVector coordinates = new PVector(int(constrain(pos.x/squareSize, 0, width/squareSize-1)), int(constrain(pos.y/squareSize, 0, height/squareSize-1)));
    if (coordinates.x >= 0 && coordinates.x < width/squareSize && coordinates.y >= 0 && coordinates.y < height/squareSize) {
      return trailMap[int(coordinates.y)][int(coordinates.x)];
    }
    return 0;
  }
}
