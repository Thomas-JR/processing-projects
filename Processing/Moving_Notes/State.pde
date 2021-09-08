class State {
  PImage treble, background;
  IntList letters;
  float trebleSplitter, ySplitter, barSplitter, noteSplitter, speed, highestSpeed;
  int starter, ch, lastCh, streak, wave, HSColour;
  boolean removed;
  float r, g;

  State() {
    treble = loadImage("Treble_Clef.png");
    treble.resize(800*32/100, 1400*32/100);
    ySplitter = height/8;
    background = loadImage("Background.jpg");
    background.resize(width, height);
    barSplitter = height/15;
    trebleSplitter = width/7;
    noteSplitter = (width-width/8)/12;
    starter = 4;
    speed = 1;
    letters = new IntList();
    for (int i = 0; i < 7; i++)
      letters.append(71-i);
    wave = 0;
    parseFile();
    HSColour = 0;
  }

  void sheet() {
    stroke(200);
    strokeWeight(10);
    if (r > g) {
      g = 0;
      fill(255, 255-r, 255-r);
      r = lerp(r, 0, 0.08);
    } else {
      r = 0;
      fill(255-g, 255, 255-g);
      g = lerp(g, 0, 0.08);
    }
    if (r + g < 1)
      fill(255);
    rect(0, 0, width-1, ySplitter);
    //fill(0, (speed*100)/2-100);
    fill(255, 0);
    rect(0, ySplitter, width-1, ySplitter*7-1);
    for (int i = 0; i < 5; i++) {
      stroke(0);
      strokeWeight(2);
      line(0, ySplitter+state.barSplitter*(i+starter), width, ySplitter+barSplitter*(i+starter));
      fill(255, 255, 255);
      triangle(0, ySplitter+state.barSplitter*(i+starter)-barSplitter/3, 0, ySplitter+barSplitter*(i+starter)+barSplitter/3, barSplitter/3, ySplitter+barSplitter*(i+starter));
      triangle(width, ySplitter+state.barSplitter*(i+starter)-barSplitter/3, width, ySplitter+barSplitter*(i+starter)+barSplitter/3, width-barSplitter/3, ySplitter+state.barSplitter*(i+starter));
    }
    stroke(map(streak, 0, 30, 0, 255), 0, 0);
    strokeWeight(5+streak/5);
    int eff = 5;
    float lastX = trebleSplitter + cos(radians(ySplitter + wave))*streak;
    for (int y = int(ySplitter); y < height; y += eff) {
      line(trebleSplitter + cos(radians(y + wave))*streak, y, lastX, y-eff);
      lastX = trebleSplitter + cos(radians(y + wave))*streak;
    }
    wave += streak;
    if (wave >= 360)
      wave -= 360;
    image(treble, 0, barSplitter*5);
  }

  void update() {
    if (keyPressed) {
      ch = key;
      if (state.ch >= 97)
        state.ch -= 32;
    }
    fill(0);
    textSize(50);
    text("Next Note = " + char(ch), width/8, ySplitter*2/3);
    text("Streak = " + streak, width/8*2.5, ySplitter*2/3);
    text("Speed = " + str(int(speed*100)), width/8*4, ySplitter*2/3);
    if (highestSpeed < speed) {
      highestSpeed = speed;
      HSColour = 100;
      output = createWriter("HS.txt");
      output.println(str(state.highestSpeed));
      output.flush();
      output.close();
    }
    text("Highest Speed = " + str(int(highestSpeed*100)), width/8*6, ySplitter*2/3);
    if (HSColour > 0) {
      textSize(100);
      fill(0, 0, 0, map(HSColour, 0, 100, 0, 500));
      text("!!!NEW HIGHEST SPEED!!!", width/2+5, height/20*19+5);
      fill(255, 255, 0, map(HSColour, 0, 100, 0, 500));
      text("!!!NEW HIGHEST SPEED!!!", width/2, height/20*19);
      HSColour -= 2;
    }
    //textAlign(LEFT);
    //text(frameRate, 20, height-20);
    textAlign(CENTER);
  }

  float reposition() {
    float farthest = 0;
    for (Note note : notes) {
      if (note.xPos > farthest)
        farthest = note.xPos;
    }
    return farthest + (width-trebleSplitter)/notes.length;
  }

  void parseFile() {
    BufferedReader reader = createReader("HS.txt");
    String line = null;
    try {
      while ((line = reader.readLine()) != null) {
        highestSpeed = float(line);
        println(highestSpeed);
      }
      reader.close();
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }
}
