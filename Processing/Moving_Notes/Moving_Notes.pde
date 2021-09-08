Note[] notes = new Note[10];
Spark[] sparks = new Spark[100];
State state;
PrintWriter output;

void setup() {
  fullScreen();
  frameRate(100);
  //output = createWriter("highScores.txt");
  state = new State();
  for (int i = 0; i < notes.length; i++)
    notes[i] = new Note(i);
  for (int i = 0; i < sparks.length; i++)
    sparks[i] = new Spark(0, 0, 0);
  textAlign(CENTER);
}

void draw() {
  image(state.background, 0, 0);
  state.sheet();
  state.update();
  for (Note note : notes) {
    note.show();
    note.update();
  }
  for (Spark spark : sparks) {
    if (spark.alive > 0) {
      spark.update();
      spark.show();
    }
  }
  state.lastCh = state.ch;
  state.removed = false;
}
