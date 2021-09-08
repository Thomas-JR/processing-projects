Node[] nodes = new Node[9];
Person[] people = new Person[100];
Game state = new Game();
StringList places;


void setup() {
  fullScreen();
  places = new StringList ("POLICE STATION", "FIRE DEPARTMENT", "BANK", "SUPERMARKET", "HOUSE", "NEWS STATION", "TRAIN STATION", "SCHOOL", "HOSPITAL");
  state.back = loadImage("GZ background 1.jpg");
  print(places.size());
  for (int n = 0; n < 9; n++) {
    IntList added = new IntList(0);
    for (int i = 0; i < int(random(1, n)); i++) {
      added.append(int(random(1)));
    }
    int item = int(random(places.size()));
    nodes[n] = new Node(n, random(50, width-50), random(50, height-50), 100, places.get(item), added);
    places.remove(item);
    print(n);
  }
  for (int p = 0; p < people.length; p++) {
    people[p] = new Person();
  }
  strokeWeight(2);
}

void draw() {
  state.update();
  image(state.back, 0, 0);
  fill(255, 100);
  rect(0, 0, width, height);

  if (mousePressed) {
    if (state.selected >= 0) {
      nodes[state.selected].x = mouseX;
      nodes[state.selected].y = mouseY;
    }
  } else
    state.selected = -1;
  for (int i = 0; i < nodes.length; i++) {
    int peops = 0;
    int zombs = 0;
    for (int p = 0; p < people.length; p++) {
      if (people[p].nodePos == nodes[i].ID) {
        if (people[p].type == 0)
          peops ++;
        else if (people[p].type == 1)
          zombs ++;
      }
    }
    nodes[i].show(peops, zombs);
    nodes[i].update();
  }
  state.lastPressed = mousePressed;
  fill(0);
  textAlign(LEFT);
  text("Framerate = " + frameRate + "\nElapsed Time = " + state.minutes, 50, 50);
}