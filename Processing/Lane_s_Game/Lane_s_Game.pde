Lazer[] lazers = new Lazer[1];
Planet[] planets = new Planet[1];

boolean shoot;
int score = 0;
int hScore = 0;
PImage bkg;
PImage pnt;
PImage sht;
PImage ply;
PImage bam;
int y;
float x;
float pp;
boolean pause = true;
boolean lilPause = false;
int xInc;

void setup() {
  imageMode(CENTER);
  frameRate(60);
  for (int i = 0; i < lazers.length; i++) {
    lazers[i] = new Lazer();
    planets[i] = new Planet();
  }
  sht = loadImage("Shot.png");
  sht.resize(20, 60);
  pnt = loadImage("Planet.png");
  bkg = loadImage("Back.jpg");
  bkg.resize(width, height);
  ply = loadImage("Player.png");
  ply.resize(60, 60);
  bam = loadImage("Bam.png");
  bam.resize(60, 60);
  size (700, 700);
}

void draw() {
  if (mousePressed == true) {
    shoot = true;
  }
  //Background Image
  image(bkg, width/2, height/2);
  noFill();
  stroke(0);
  strokeWeight(200);
  ellipse(width/2, height/2, width+200, height+200);
  //Score
  stroke(0);
  textSize(20); 
  String ss = "Score = " + score;
  text(ss, width - 240, height-100);
  textSize(20); 
  String hs = "High Score = " + hScore;
  text(hs, 120, height-100);
  if (score > hScore) {
    hScore = score;
  }
  if (pause == true) {
    delay(1500);
  }
  if (lilPause == true) {
    delay(200);
    lilPause = false;
  }
  //Actual Things
  for (int i = 0; i < lazers.length; i++) {
    lazers[i].goAway();
    lazers[i].show();
  }
  for (int i = 0; i < planets.length; i++) {
    planets[i].update();
    planets[i].show();
    planets[i].reset();
  }
  //Little player thing
  image(ply, width/2, height-130);
  noFill();
  strokeWeight(2);
  stroke(255);
  ellipse(width/2, height/2, width, height);
}