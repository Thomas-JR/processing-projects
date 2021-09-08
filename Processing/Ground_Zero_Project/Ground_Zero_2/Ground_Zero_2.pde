//http://www.illustratedmaps.com/IllustratedMaps/Z-Town-by-blocks_Map_illustration.html

Node[] nodes = new Node[18];
Person[] people = new Person[1350];
Game state = new Game();

void setup() {
  //Change the screen size by uncommenting the nect line, removing fullScreen(); and changing the x and y for size(x, y);
  //size(1800, 900);
  fullScreen();
  StringList places;
  frameRate(60);
  places = new StringList ("CITY COLLEGE", "GAS STATION", "PEARL MALL", "BANK", 
    "PARKVIEW HOTEL", "CITY PARK", "PEOPLE'S BANK", "SUPERMARKET", 
    "COFFEE SHOP", "LIBRARY", "IGGY'S ICE CREAM", "DEPARTMENT STORE", 
    "HOSPITAL", "DRUGSTORE", "INTERNET CAFE", "THE NOODLE SHOP", "DAVIS HIGH", "BUS STATION");
  state.back = loadImage("GZ background 2.jpg");

  //for every possible node make it with all it's possible connected nodes
  int n = 0;
  for (int y = 0; y < state.yLen; y++) {
    for (int x = 0; x < state.xLen; x++) {
      IntList connected = new IntList(0);
      if (n > 5) {
        connected.append(n-6);
      }
      if (n < 12) {
        connected.append(n+6);
      }
      if (x < 5) {
        connected.append(n+1);
      }
      if (x > 0) {
        connected.append(n-1);
      }
      nodes[n] = new Node(n, width/(state.xLen*2)+width/state.xLen*x, height/(state.yLen*2)+height/state.yLen*y, 100, places.get(n), connected);
      n ++;
    }
  }

  FloatList chances;
  chances = new FloatList (400, 12, 300, 40, 30, 40, 30, 50, 6, 100, 4, 20, 75, 8, 8, 6, 200, 20);
  //Find the total chance likelihood of people spawning at a place
  float total = 0;
  for (int i = 0; i < chances.size(); i++) {
    total += chances.get(i);
  }
  println(total);
  //Make every person with a place that has been chosen at random skewed by the chances string list
  for (int p = 0; p < people.length; p++) {
    float location = random(total);
    float flem = 0;
    for (int place = 0; place < chances.size(); place++) {
      flem += chances.get(place);
      if (location <= flem) {
        people[p] = new Person(place, place);
        break;
      }
    }
  }
  strokeWeight(2);
}

void draw() {
  //Background
  image(state.back, 0, 0);
  fill(255, 150);
  rect(0, 0, width, height);
  //Possibility to drag nodes
  if (mousePressed) {
    if (state.selected >= 0) {
      nodes[state.selected].x = mouseX;
      nodes[state.selected].y = mouseY;
    }
  } else
    state.selected = -1;
  //Update and show all the nodes with colours respect to the amount of zombies and people at that node
  for (Node n : nodes) {
    int peops = 0;
    int zombs = 0;
    for (Person p : people) {
      if (p.nodePos == n.ID && p.alive &! p.moving) {
        if (p.infection == 0)
          peops ++;
        else
          zombs ++;
      }
    }
    n.show(peops, zombs);
    n.update();
  }
  //Update all the people from the array-list
  for (Person p : people) {
    if (p.alive)
      p.update();
    if (p.alive && p.moving)
      p.show();
  }
  //Update the general variables from the Game object
  state.update();
  if (!state.play)
    pauseMenu();
}