import processing.sound.*;
SoundFile[] files = new SoundFile[3];

Graph graph;

void setup() {
  size(800, 800);
  //fullScreen();
  textAlign(CENTER, CENTER);
  //colorMode(HSB);
  files[0] = new SoundFile(this, "createNode.mp3");
  files[1] = new SoundFile(this, "createEdge.mp3");
  files[2] = new SoundFile(this, "deleteNode.mp3");
  graph = new Graph(files, false);
}

void draw() {
  //fill(0, 10);
  //rect(0, 0, width, height);
  background(255);
  graph.update();
  //println(graph.toString());
  //println(frameRate);
}
