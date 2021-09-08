//List of people, their relationships with other people and their rated score of quality of relationship
StringList People = new StringList("Amir", "Baba", "Hassan", "Ali", "Sohrab", "Soraya", "Assef", "Rahim Khan", "General Taheri", "Khala Jamila", "Farzana", "Sanaubar", "Sofia");
StringList People2 = new StringList("Amir", "Baba", "Hassan", "Ali", "Sohrab", "Soraya", "Assef", "Rahim Khan", "General Taheri", "Khala Jamila", "Farzana", "Sanaubar", "Sofia");
IntList Popularity = new IntList(1574, 678, 505, 313, 273, 193, 149, 141, 63, 41, 23, 22, 3);
StringList Amir = new StringList("N/A", "Father", "Best Friend/Servent", "Best Friend's Father", "Best Friend's Son", "Wife", "Nemesis", "Father's Best Friend", "Wife's Father", "Wife's Mother", "Best Friend's Wife", "Best Friend's Mother", "Mother");
StringList Baba = new StringList("Son", "N/A", "Son", "Best Friend/Servent", "Grandson", "Daughter In Law", "N/A", "Best Friend", "Daughter In Laws Father", "Daughter In Laws Mother", "Daughter In Law", "Mother Of His Child", "Wife");
StringList Hassan = new StringList("Best Friend", "Dad", "N/A", "Step Dad", "Son", "N/A", "Nemesis", "N/A", "N/A", "N/A", "Wife", "Mother", "Best Friend's Mother");
StringList Ali = new StringList("Step Son's Best Friend", "Best Friend", "Step Son", "N/A", "Grand Son", "N/A", "N/A", "N/A", "N/A", "N/A", "Step Daughter In Law", "Wife", "Best Friend's Wife");
StringList Sohrab = new StringList("Step Father", "Step Grandad", "Father", "N/A", "N/A", "Step Mum", "Torturer", "Friend", "N/A", "N/A", "Mother", "Grandma", "Step Grandma");
StringList Soraya = new StringList("Husband", "Father In Law", "Brother In Law", "N/A", "Step Son", "N/A", "N/A", "N/A", "Father", "Mother", "N/A", "N/A", "Mother In Law");
StringList Assef = new StringList("Nemesis", "N/A", "Nemesis", "N/A", "Tortured", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A");
StringList RahimKhan = new StringList("Friend", "Best Friend", "Friend", "Friend", "Friend", "N/A", "N/A", "N/A", "N/A", "N/A", "Friend", "Friend", "Friend");
StringList GeneralTaheri = new StringList("Son In Law", "Son In Law's Father", "N/A", "N/A", "Step Grandson", "Daughter", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "Son In Law's Mother");
StringList KhalaJamila = new StringList("Son In Law", "Son In Law's Father", "N/A", "N/A", "Step Grandson", "Daughter", "N/A", "N/A", "Husband", "N/A", "N/A", "N/A", "Son In Law's Mother");
StringList Farzana = new StringList("N/A", "N/A", "Husband", "Father In Law", "Son", "N/A", "N/A", "Friend", "N/A", "N/A", "N/A", "Friend", "N/A");
StringList Sanaubar = new StringList("N/A", "Father Of Her Child", "Son", "Husband", "Grandson", "N/A", "N/A", "Friend", "N/A", "N/A", "Friend", "N/A", "N/A");
StringList Sofia = new StringList("Son", "Husband", "Step Son", "Friend", "N/A", "Daughter In Law", "N/A", "Friend", "Daughter In Law's Father", "Daughter In Law's Mother", "N/A", "Husband's Son's Mother", "N/A");
IntList AmirScore = new IntList(0, 20, 60, 15, 60, 80, -75, 70, 20, 40, 0, 0, 60);
IntList BabaScore = new IntList(20, 0, 40, 30, 0, 60, 0, 30, 20, 20, 0, -20, 45);
IntList HassanScore = new IntList(90, 30, 0, 100, 100, 0, -50, 0, 0, 0, 80, -5, 0);
IntList AliScore = new IntList(15, 30, 100, 0, 0, 0, 0, 0, 15, 0, 0, -25, 15);
IntList SohrabScore = new IntList(60, 0, 90, 0, 0, 20, -100, 15, 0, 0, 55, 50, 0);
IntList SorayaScore = new IntList(80, 35, 0, 0, 60, 0, 0, 0, 60, 60, 0, 0, 0);
IntList AssefScore = new IntList(-75, 0, -75, 0, -100, 0, 0, 0, 0, 0, 0, 0, 0);
IntList RahimKhanScore = new IntList(15, 30, 15, 15, 15, 0, 0, 0, 0, 0, 15, 15, 15);
IntList GeneralTaheriScore = new IntList(20, 40, 0, 0, 0, 60, 0, 0, 0, 100, 0, 0, 0);
IntList KhalaJamilaScore = new IntList(90, 20, 0, 0, 0, 60, 0, 0, 50, 100, 0, 0, 0);
IntList FarzanaScore = new IntList(0, 0, 80, 35, 100, 0, 0, 15, 0, 0, 0, 15, 0);
IntList SanaubarScore = new IntList(-20, -20, -5, -25, 30, 0, 0, 15, 0, 0, 15, 0, 0);
IntList SofiaScore = new IntList(20, 45, -20, 15, 0, 0, 0, 15, 0, 0, 0, -20, 0);

//Creating the classes for the nodes
Char[] characters = new Char[13];
//Variable
int background, person, selectedPerson;
boolean lastPressed, canChange, info, focus, HL;
float distance, tDistance;
int chars = People.size();
int maxSize = 350;
int minSize = 150;
float radius = 0.1;
int counter = 0;

void setup() {
  fullScreen();
  noCursor();
  int largestNode = Popularity.max();
  //Iterate through the amount of people
  for (int i = 0; i < chars; i++) {
    //Choose a random person
    int p = int(random(People.size()));
    //Iterate through the amount of people
    for (int j = 0; j < People2.size(); j++) {
      if (People2.get(j) == People.get(p)) {
        //Make the node and assign it's values
        characters[i] = new Char(People.get(p), map(Popularity.get(p), 0, largestNode, minSize, maxSize), i, j);
      }
    }
    //Make sure you don't pick the same people / values
    People.remove(p);
    Popularity.remove(p);
  }
  //Assign the specific attributs and variables that each node can reference from
  for (int i = 0; i< characters.length; i++) {
    if (characters[i].name == "Amir") {
      characters[i].Relations = (Amir);
      characters[i].Scores = (AmirScore);
    } else if (characters[i].name == "Baba") {
      characters[i].Relations = (Baba);
      characters[i].Scores = (BabaScore);
    } else if (characters[i].name == "Hassan") {
      characters[i].Relations = (Hassan);
      characters[i].Scores = (HassanScore);
    } else if (characters[i].name == "Ali") {
      characters[i].Relations = (Ali);
      characters[i].Scores = (AliScore);
    } else if (characters[i].name == "Sohrab") {
      characters[i].Relations = (Sohrab);
      characters[i].Scores = (SohrabScore);
    } else if (characters[i].name == "Soraya") {
      characters[i].Relations = (Soraya);
      characters[i].Scores = (SorayaScore);
    } else if (characters[i].name == "Assef") {
      characters[i].Relations = (Assef);
      characters[i].Scores = (AssefScore);
    } else if (characters[i].name == "Rahim Khan") {
      characters[i].Relations = (RahimKhan);
      characters[i].Scores = (RahimKhanScore);
    } else if (characters[i].name == "General Taheri") {
      characters[i].Relations = (GeneralTaheri);
      characters[i].Scores = (GeneralTaheriScore);
    } else if (characters[i].name == "Khala Jamila") {
      characters[i].Relations = (KhalaJamila);
      characters[i].Scores = (KhalaJamilaScore);
    } else if (characters[i].name == "Farzana") {
      characters[i].Relations = (Farzana);
      characters[i].Scores = (FarzanaScore);
    } else if (characters[i].name == "Sanaubar") {
      characters[i].Relations = (Sanaubar);
      characters[i].Scores = (SanaubarScore);
    } else if (characters[i].name == "Sofia") {
      characters[i].Relations = (Sofia);
      characters[i].Scores = (SofiaScore);
    }
  }
  rectMode(CENTER);
  noStroke();
}

void draw() {
  focus = false;
  //Flash the selected edge
  if (counter > 20) {
    counter = 0;
    if (HL)
      HL = false;
    else
      HL = true;
  }
  //draw the background items
  updateBackground();
  relationshipTab();

  //Update the edges
  for (int p = 0; p < chars; p++) {
    if (p != person) {
      stroke(255-background);
      float weight = characters[person].Scores.get(characters[p].originalPos);
      if (weight < 0)
        strokeWeight(-weight/8);
      else
        strokeWeight(weight/8);
      if (weight == 0)
        stroke(background);
      else if (weight < 0)
        stroke(255, 0, 0);
      else
        stroke(0, 255, 0);
      if (p == selectedPerson) {
        if (HL) {
          if (background < 255/2)
            stroke(255);
          else
            stroke(0);
        }
      }
      line(characters[person].pos.x, characters[person].pos.y, characters[p].pos.x, characters[p].pos.y);
    }
  }
  //Update the nodes
  for (int i = 0; i < characters.length; i++) {
    characters[i].update();
    if (dist(mouseX, mouseY, characters[i].pos.x, characters[i].pos.y) <= characters[i].size/2) {
      textSize(16);
      text("Importance = " + characters[i].radius, mouseX, mouseY-20);
      focus = true;
    }
  }
  textSize(24);
  //Check the mouses position relative to the node and if clicked perform an action
  canChange = true;
  if (mousePressed &! lastPressed) {
    focus = true;
    for (int c = 0; c < characters.length; c++) {
      if (dist(mouseX, mouseY, characters[c].pos.x, characters[c].pos.y) < characters[c].size/2) {
        selectedPerson = characters[c].ID;
        characters[c].size = characters[c].radius*1.2;
        canChange = false;
      }
      if (!info && dist(40, height-40, mouseX, mouseY) <= 30) {
        info = true;
        canChange = false;
      } else if (info) {
        info = false;
        canChange = false;
      }
    }
  }
  //cursor focusing
  if (dist(40, height-40, mouseX, mouseY) <= 30)
    focus = true;
  //cycles clockwise/counter clockwise around the nodes
  if (mousePressed && canChange &! info) {
    if (mouseX > 255 || mouseY > 50) {
      if (!lastPressed) {
        if (mouseButton == LEFT) {
          person --;
          if (person < 0)
            person += 13;
        } else if (mouseButton == RIGHT) {
          person ++;
          if (person > 12)
            person -= 13;
        }
      }
    } else {
      background = mouseX;
      if (background < 0)
        background = 0;
    }
  }
  if (info) {
    //Boxes
    fill(200, 220);
    rect(width/2, height/2, width, height);
    fill(100, 220);
    rect(width/3, height/2, width/3, height/2);
    rect(width-width/3, height/2, width/3, height/2);

    //Header
    fill(50);
    textSize(50);
    text("The Kite Runner Character Map", width/2, height/6);
    textSize(24);
    fill(255);

    //Text
    text("Controls:", width/3, height/2-height/10*2);
    text("LEFT click = cycle counter clockwise", width/3, height/2-height/10);
    text("RIGHT click = cycle clockwise", width/3, height/2);
    text("Click on a person to display their", width/3, height/2+height/10);
    text("specific attributes and relations", width/3, height/2+height/20*3);

    text("Relationships Key:", width-width/3, height/2-height/10*2);
    text("Relation = 60", width-width/3, height/2-height/20*3);
    text("Marriage / Saving someone's child's life = 50", width-width/3, height/2-height/20*2);
    text("Saved someone's life / Strong relationship = 40", width-width/3, height/2-height/20*1);
    text("BestFriend = 30   Weak Relationship = 20", width-width/3, height/2);
    text("Unwanted Marriage = -5   Very Weak Relation = -20", width-width/3, height/2+height/20*1);
    text("Chose not to save someone's life = -40", width-width/3, height/2+height/20*2);
    text("Being a nemesis of someone = -50", width-width/3, height/2+height/20*3);
    text("Torturing / being tortured by someone = -100", width-width/3, height/2+height/20*4);
  }
  //update cursor
  crs();
  lastPressed = mousePressed;
  counter ++;
}

class Char {
  StringList Relations;
  IntList Scores;
  IntList Weights = new IntList();
  PVector pos, targetPos;
  float size, radius, targetSize, nameSize, r, g, b;
  String name;
  int ID, originalPos;

  Char(String name_, float size_, int ID_, int op) {
    //set ID, name, colour and size of nodes
    ID = ID_;
    originalPos = op;
    name = name_;
    size = size_/2;
    radius = size;
    targetSize = size;
    nameSize = map(size, minSize, maxSize+minSize, 20, 40);
    setColours();

    //create the list of specific relations for that person
    StringList Relations = new StringList();

    //set a basic position for the node (will be changed later)
    pos = new PVector(width/2, height/2);
    targetPos = new PVector(0, 0);
  }

  void setColours() {
    r = random(255);
    g = random(255-r);
    if (g > r/4 && g < r/2)
      g -= r/4;
    else if (g > r/2 && g < r/4*3)
      g += r/4;
    b = 255 - r - g;
  }

  void update() {
    //Update position
    targetPos = new PVector(width/2+cos(radians(360/13*ID))*min(width/2, height/2)*3/4, height/2+sin(radians(360/13*ID))*min(width/2, height/2)*3/4);
    if (ID == person) {
      targetPos = new PVector(width/2, height/2);
    }
    pos.x = lerp(pos.x, targetPos.x, 0.05);
    pos.y = lerp(pos.y, targetPos.y, 0.05);

    //Show the node
    if (dist(mouseX, mouseY, pos.x, pos.y) < radius / 2)
      targetSize = radius * 1.4;
    else
      targetSize = radius;
    size = lerp(size, targetSize, 0.2);
    strokeWeight(2);
    if (background < 255/2)
      stroke(255);
    else
      stroke(0);
    fill(r, g, b);
    ellipse(pos.x, pos.y, size, size);

    //Write the text (name) of the node
    textSize(nameSize);
    textAlign(CENTER);
    if (background < 255/2)
      fill(255);
    else
      fill(0);
    text(name, pos.x, pos.y+nameSize/3);
  }
}

void updateBackground() {
  background(background);
  strokeWeight(2);
  fill(255-map(background, 0, 255, 100, 155));
  stroke(255-background);
  rect(255/2, 25, 255, 50);
  if (dist(mouseX, mouseY, 40, height-40) < 30)
    fill(255-map(background, 0, 255, 100, 155)+20);
  ellipse(40, height-40, 60, 60);
  fill(255);
  text("BACKGROUND", 255/2, 37.5);
  text("i", 40, height-40+30/3);
  rect(background, 25, 20, 55);
}

void relationshipTab() {
  fill(255-map(background, 0, 255, 100, 155));
  rect(width-255, 100, 510, 200);
  fill(255);
  text(characters[person].name + " -> " + characters[selectedPerson].name, width-255, 50);
  text("Relationship = " + characters[person].Relations.get(characters[selectedPerson].originalPos), width-255, 100);
  text("Quality of Relationship (-100, 100) = " + characters[person].Scores.get(characters[selectedPerson].originalPos), width-255, 150);
}

void crs() {
  //Cursor
  if (background < 255/2)
    stroke(255);
  else
    stroke(0);
  strokeWeight(4);
  if (mousePressed)
    tDistance = 0;
  else if (focus)
    tDistance = 5;
  else
    tDistance = 10;
  distance = lerp(distance, tDistance, 0.3);
  line(mouseX+distance, mouseY, mouseX+10+distance, mouseY);
  line(mouseX-distance, mouseY, mouseX-10-distance, mouseY);
  line(mouseX, mouseY-distance, mouseX, mouseY-10-distance);
  line(mouseX, mouseY+distance, mouseX, mouseY+10+distance);
}