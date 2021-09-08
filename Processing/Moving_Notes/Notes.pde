class Note {
  float xPos, barSplitter, noteRadius;
  int note, min, max;

  Note(int pos_) {
    min = 6;
    max = 19;
    note = int(random(min, max));
    barSplitter = height/15;
    noteRadius = 40;
    xPos = state.trebleSplitter+((width-state.trebleSplitter)/notes.length)*(pos_+1);
  }

  void reset() {
    for (int i = 0; i < 100; i++)
      sparks[i] = new Spark(255, state.trebleSplitter, random(height/8+barSplitter/2*note-noteRadius/2, height/8+barSplitter/2*note+noteRadius/2));

    xPos = width+noteRadius/2;
    note = int(random(min, max));
    if (state.speed > 1)
      state.speed *= 0.8;
    if (state.speed < 1)
      state.speed = 1;
    state.r = 255;
    state.streak = 0;
  }

  void update() {
    xPos -= state.speed;
    if (xPos <= state.trebleSplitter+noteRadius/2) {
      reset();
    }
  }

  void show() {
    if (key == 32) {
      float closest = notes[0].xPos;
      for (Note note : notes) {
        if (note.xPos < closest)
          closest = note.xPos;
      }
      if (closest == xPos) {
        if (state.lastCh == state.letters.get((note)%7) &! state.removed) {
          state.g = 255;
          state.streak ++;
          state.speed *= 1.05;
          state.ch = 0;
          xPos = state.reposition();
          note = int(random(min, max));
          state.lastCh = 0;
          state.removed = true;
        }
      }
    }
    fill(0);
    stroke(0);
    ellipse(xPos, height/8+barSplitter/2*note, noteRadius*1.2, noteRadius);
    strokeWeight(5);
    if (note >= 12) {
      line(xPos+noteRadius/2*1.2, height/8+barSplitter/2*(note), xPos+noteRadius/2*1.2, height/8+barSplitter/2*(note)-250);
    } else {
      line(xPos-noteRadius/2*1.2, height/8+barSplitter/2*(note), xPos-noteRadius/2*1.2, height/8+barSplitter/2*(note)+250);
    }
    boolean found = false;
    for (int i = min-2; i < max; i++) {
      if (i == note)
        found = true;
      if (i < 7 && i+1 == note)
        found = true;
      if (!found) {
        if (i > 15 && i % 2 != 0)
          line(xPos-noteRadius, state.ySplitter+(state.barSplitter/2)*(i+1), xPos+noteRadius, state.ySplitter+(state.barSplitter/2)*(i+1));
      } else {
        if (found && i < 7 && i % 2 != 0)
          line(xPos-noteRadius, state.ySplitter+(state.barSplitter/2)*(i+1), xPos+noteRadius, state.ySplitter+(state.barSplitter/2)*(i+1));
      }
    }
  }
}
