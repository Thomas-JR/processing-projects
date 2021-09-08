void makeZombie(int ID_, int make_) {
  //Go through every person until there is one that is in the same location as the inputted location
  for (int i = 0; i < make_; i++) {
    for (Person p : people) {
    if (p.nodePos == ID_ && p.infection == 0 &! p.moving) {
        //make a zombie
        p.infection = state.infected;
        break;
      }
    }
  }
}

void keyPressed() {
  //Code to recognise the play/pause of the running sketch
  switch (keyCode) {
  case UP:
    state.started = true;
    state.play = true;
    state.lastSecond = second();
    break;
  case DOWN:
    state.play = false;
    break;
  }
}

void pauseMenu() {
  //Pause menu info and text displaying
  textAlign(CENTER);
  textSize(width/20);
  text("GROUND ZERO PROJECT", width/2, height/3);
  textSize(width/50);
  text("Paused, press the UP arrow to begin", width/2, height/10);
  text("Right click = switch a person to a zombie.", width/2, height/20*12);
  text("Left click + drag = move node (unrecommended)", width/2, height/20*13);
  text("Green nodes = Humans, Red nodes = Zombies", width/2, height/20*14);
  text("Quick notes - Zombies starve to death, a combat winner is determined through individual strengths", width/2, height/20*15);
  //Changing the state of the playing game
  if (state.started) {
    fill(255, 100);
    noStroke();
    rect(0, 0, width, height);
  } else {
    state.back.resize(width, height);
    fill(255, 100);
    rect(0, 0, width, height);
    state.started = true;
  }
}