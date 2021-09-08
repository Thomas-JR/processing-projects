Node[] nodes = new Node[16200];
Person[] people = new Person[10];
Game state = new Game();
int xLen = 180;
int yLen = 90;

void setup() {
  size(1800, 900);
  int i = 0;
  for (int y = 0; y < yLen; y++) {
    for (int x = 0; x < xLen; x++) {
      IntList connected = new IntList(0);
      boolean wall = false;
      if (y > 0)
        connected.append(i-xLen);
      else
        connected.append(-1);
      if (y < yLen-1)
        connected.append(i+xLen);
      else
        connected.append(-1);
      if (x < xLen-1)
        connected.append(i+1);
      else
        connected.append(-1);
      if (x > 0)
        connected.append(i-1);
      else
        connected.append(-1);

      //walls
      for (int shift = 3; shift < width; shift += 30) {
        if (x >= shift && x <= shift+23) {
          if (y == 3)
            wall = true;
          if (y == 23) {
            if (x <= shift + 10 || x >= shift + 14)
              wall = true;
          }
        }
        if (x == shift || x == shift+23) {
          if (y >= 3 && y <= 23)
            wall = true;
        }
      }
      for (int shift = 3; shift < width; shift += 30) {
        if (x >= shift && x <= shift+23) {
          if (y == yLen-3)
            wall = true;
          if (y == yLen-23) {
            if (x <= shift + 10 || x >= shift + 14)
              wall = true;
          }
        }
        if (x == shift || x == shift+23) {
          if (y >= yLen-23 && y <= yLen-3)
            wall = true;
        }
      }

      nodes[i] = new Node(i, x, y, connected, wall);
      i++;
    }
  }
  for (int p = 0; p < people.length; p++)
    people[p] = new Person(p);
  rectMode(CENTER);
  noStroke();
}

void draw() {
  if (mousePressed)
    for (Person p : people)
      p.move();
  for (Node n : nodes) {
    int peops = 0;
    int zombs = 0;
    for (Person p : people) {
      if (p.nodePos == n.ID && p.alive) {
        if (p.infection > 0)
          zombs ++;
        if (p.infection == 0)
          peops ++;
      }
    }
    n.show(peops, zombs, 0);
  }
  for (Person p : people) {
    if (p.alive && p.infection == 0)
      p.personScan();
    else if (p.alive && p.infection > 0)
      p.zombieScan();
    if (mousePressed)
      p.move();
  }
  state.update();
}