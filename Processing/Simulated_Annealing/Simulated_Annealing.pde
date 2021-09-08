import java.util.Collections;
ArrayList<PVector> points, best, newPoints, prev;
float e, eNew, temperature, bestEnergy;
float borderSize = 0.05;
int maxIterations = 1600;
int iteration, iterationOfBest;
float acceptanceProbability, lastTemperature, initTemperature, lastEnergy, initEnergy, energy, tempOfBest;

// Control Variables
static int N = 64;
int randomisationsPerIteration = 5000;
float tempFactor = 0.997;


void setup() {
  size(800, 800);
  iterationOfBest = 0;
  iteration = 0;
  initTemperature = 100;
  tempOfBest = initTemperature;
  temperature = initTemperature;
  points = new ArrayList<PVector>();
  for (int i = 0; i < N; i++) {
    points.add(new PVector(borderSize*width+random((0.5-2*borderSize)*width), borderSize*height+random((0.5-2*borderSize)*height)));
  }
  strokeWeight(1);
  frameRate(480);
  background(255);  
  fill(255);
  rect(borderSize*width, (0.5+borderSize)*height, (0.5-2*borderSize)*width, (0.5-2*borderSize)*height);
  rect((0.5+borderSize)*width, borderSize*height, (0.5-2*borderSize)*width, (0.5-2*borderSize)*height);
  rect((0.5+borderSize)*width, (0.5+borderSize)*height, (0.5-2*borderSize)*width, (0.5-2*borderSize)*height);
  lastTemperature = temperature;
  initEnergy = totalDistance(points)*1.5;
  lastEnergy = initEnergy;
  best = (ArrayList)points.clone();
  bestEnergy = initEnergy;
  drawPath(points);
}

void draw() {
  if (iteration < maxIterations) {
    fill(255);
    stroke(255);
    rect(0, 0, 150, 45);
    stroke(0);
    fill(255);
    rect(borderSize*width, borderSize*height, (0.5-2*borderSize)*width, (0.5-2*borderSize)*height);
    // Draw path
    drawPath(points);
    // Permutate some number of times
    acceptanceProbability = random(1);
    //prev = (ArrayList)points.clone();
    for (int i = 0; i < randomisationsPerIteration; i++) {
      newPoints = (ArrayList)points.clone();
      Collections.swap(newPoints, int(random(points.size())), int(random(points.size())));
      if (probabilityFunction(points, newPoints, temperature) > acceptanceProbability) {
        points = newPoints;
      }
    }
    // Draw Nodes
    for (int i = 0; i < points.size(); i++) {
      fill(0);
      ellipse(points.get(i).x, points.get(i).y, 3, 3);
    }
    energy = totalDistance(points);
    temperature *= tempFactor;
    fill(0);
    text("Temperature: " + temperature + "\nEnergy = " + energy + "\nEnergy of best = " + bestEnergy, 0, 10);
    iteration++;
    if (energy < bestEnergy) {
      best = (ArrayList)points.clone();
      bestEnergy = energy;
      iterationOfBest = iteration;
      tempOfBest = temperature;
    }

    point(borderSize*width + 1.0*iteration/maxIterations*(0.5-2*borderSize)*width, (1-borderSize)*height-(0.5-2*borderSize)*acceptanceProbability*height);
    stroke(0);
    line((0.5+borderSize)*width + 1.0*iteration/maxIterations*(0.5-2*borderSize)*width, (1-borderSize)*height-(0.5-2*borderSize)*(temperature/initTemperature)*height, 
      (0.5+borderSize)*width + 1.0*(iteration+1)/maxIterations*(0.5-2*borderSize)*width, (1-borderSize)*height-(0.5-2*borderSize)*(lastTemperature/initTemperature)*height);
    stroke(0, 25);
    line((0.5+borderSize)*width + 1.0*iteration/maxIterations*(0.5-2*borderSize)*width, (0.5-borderSize)*height-(0.5-2*borderSize)*(energy/initEnergy)*height, 
      (0.5+borderSize)*width + 1.0*(iteration+1)/maxIterations*(0.5-2*borderSize)*width, (0.5-borderSize)*height-(0.5-2*borderSize)*(lastEnergy/initEnergy)*height);

    lastTemperature = temperature;
    lastEnergy = energy;
  } else {
    if (totalDistance(points) > bestEnergy) {
      points = (ArrayList)best.clone();
      iteration = max(0, iterationOfBest);
      temperature = tempOfBest;
      lastTemperature = temperature;
      println("Counting");
      countCrossovers(points);
    }
  }
}

float totalDistance(ArrayList<PVector> points) {
  float tot = 0;
  for (int i = 0; i < points.size()-1; i++) {
    tot += points.get(i).dist(points.get(i+1));
  }
  tot += points.get(0).dist(points.get(points.size()-1));
  return tot;
}

void drawPath(ArrayList<PVector> points) {
  for (int i = 0; i < points.size()-1; i++) {
    line(points.get(i).x, points.get(i).y, points.get(i+1).x, points.get(i+1).y);
  }
  line(points.get(0).x, points.get(0).y, points.get(points.size()-1).x, points.get(points.size()-1).y);
}

float probabilityFunction(ArrayList<PVector> p, ArrayList<PVector> np, float T) {
  float e = totalDistance(p);
  float eNew = totalDistance(np);
  if (eNew < e) {
    return 1;
  } else {
    return exp(-1.0*(eNew - e)/T);
  }
}

void mousePressed() {
  setup();
}

int countCrossovers(ArrayList<PVector> points) {
  int tot = 0;
  for (int i = 0; i < points.size()-1; i++) {
    for (int j = i+1; j < points.size(); j++) {
      tot += doIntersect(points.get(i), points.get(i+1), points.get(j), points.get((j+1)%(points.size()-1))) ? 1 : 0;
    }
  }
  println(tot);
  return tot;
}

boolean onSegment(PVector p, PVector q, PVector r) {
  if (q.x <= Math.max(p.x, r.x) && q.x >= Math.min(p.x, r.x) &&
    q.y <= Math.max(p.y, r.y) && q.y >= Math.min(p.y, r.y))
    return true;

  return false;
}


int orientation(PVector p, PVector q, PVector r) {
  int val = int((q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y));

  if (val == 0) return 0; // colinear

  return (val > 0)? 1: 2; // clock or counterclock wise
}

boolean doIntersect(PVector p1, PVector q1, PVector p2, PVector q2)
{
  // Find the four orientations needed for general and
  // special cases
  int o1 = orientation(p1, q1, p2);
  int o2 = orientation(p1, q1, q2);
  int o3 = orientation(p2, q2, p1);
  int o4 = orientation(p2, q2, q1);

  // General case
  if (o1 != o2 && o3 != o4)
    return true;

  // Special Cases
  // p1, q1 and p2 are colinear and p2 lies on segment p1q1
  if (o1 == 0 && onSegment(p1, p2, q1)) return true;

  // p1, q1 and q2 are colinear and q2 lies on segment p1q1
  if (o2 == 0 && onSegment(p1, q2, q1)) return true;

  // p2, q2 and p1 are colinear and p1 lies on segment p2q2
  if (o3 == 0 && onSegment(p2, p1, q2)) return true;

  // p2, q2 and q1 are colinear and q1 lies on segment p2q2
  if (o4 == 0 && onSegment(p2, q1, q2)) return true;

  return false; // Doesn't fall in any of the above cases
}
