void makeZombie(int ID_, int make_) {
  //Go through every person until there is one that is in the same location as the inputted location
  int i = 0;
  for (Person p : people) {
    if (p.nodePos == ID_ && p.infection == 0 &! p.moving) {
      //make a zombie if this person can be made a person
      p.infection = state.infected;
      p.targetNodes.clear();
      i++;
      if (i >= make_) break;
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
  //Changing the state of the playing game
  if (state.started) {
    fill(0, 100);
    noStroke();
    rect(0, 0, width, height);
  } else {
    state.back.resize(width, height);
    fill(0, 100);
    rect(0, 0, width, height);
    state.started = true;
  }
  fill(255);
  //Pause menu info and text displaying
  textAlign(CENTER);
  textSize(width/20);
  text("GROUND ZERO PROJECT", width/2, height/3);
  textSize(width/50);
  text("Paused, press the UP arrow to begin", width/2, height/10);
  text("Right click = switch a person to a zombie.", width/2, height/20*9);
  text("Left click + drag = move node", width/2, height/20*10);
  text("Green nodes = Humans, Red nodes = Zombies", width/2, height/20*11);
  text("Quick notes - Zombies starve to death, a combat winner is determined through individual strengths", width/2, height/20*12);

  if (mousePressed) {
    if (mouseX >= width/10*2-width/80 && mouseX <= width/10*2+width/80) {
      if (mouseY >= height/20*16-height/10 && mouseY <= height/20*16+height/10) {
        state.clickPower = int(map(mouseY, height/20*16-height/10, height/20*16+height/10, 100, 1));
      }
    }
    if (mouseX >= width/10*4-width/80 && mouseX <= width/10*4+width/80) {
      if (mouseY >= height/20*16-height/10 && mouseY <= height/20*16+height/10) {
        state.full = int(map(mouseY, height/20*16-height/10, height/20*16+height/10, 200, 0));
      }
    }
    if (mouseX >= width/10*6-width/80 && mouseX <= width/10*6+width/80) {
      if (mouseY >= height/20*16-height/10 && mouseY <= height/20*16+height/10) {
        state.humanFear = map(mouseY, height/20*16-height/10, height/20*16+height/10, 0.999, 0.9);
        if (state.humanFear > 0.999)
          state.humanFear = 0.999;
      }
    }
    if (mouseX >= width/10*8-width/80 && mouseX <= width/10*8+width/80) {
      if (mouseY >= height/20*16-height/10 && mouseY <= height/20*16+height/10) {
        state.strongPerson = int(map(mouseY, height/20*16-height/10, height/20*16+height/10, 10, 1));
      }
    }
  }
  textSize(30);
  rectMode(CENTER);
  fill(255);
  text("Click Power", width/10, height/20*16);
  text(state.clickPower, width/10, height/20*18);
  fill(0, 150);
  rect(width/10*2, height/20*16, width/40, height/5);
  fill(255, 0, 0, 200);
  rect(width/10*2, height/20*16+map(state.clickPower, 1, 100, height/10, -height/10), width/40, height/50);
  fill(255);
  text("Zombie Hunger", width/10*3, height/20*16);
  text(int(state.full), width/10*3, height/20*18);
  fill(0, 150);
  rect(width/10*4, height/20*16, width/40, height/5);
  fill(255, 0, 0, 200);
  rect(width/10*4, height/20*16+map(state.full, 0, 200, height/10, -height/10), width/40, height/50);
  fill(255);
  text("Human Agitation", width/10*5, height/20*16);
  text(int(map(state.humanFear, 0.9, 0.999, 0, 10)), width/10*5, height/20*18);
  fill(0, 150);
  rect(width/10*6, height/20*16, width/40, height/5);
  fill(255, 0, 0, 200);
  rect(width/10*6, height/20*16+map(state.humanFear, 0.9, 0.999, height/10, -height/10.0), width/40, height/50);  
  fill(255);
  text("Strong Humans", width/10*7, height/20*16);
  text(state.strongPerson, width/10*7, height/20*18);
  fill(0, 150);
  rect(width/10*8, height/20*16, width/40, height/5);
  fill(255, 0, 0, 200);
  rect(width/10*8, height/20*16+map(state.strongPerson, 1, 10, height/10, -height/10), width/40, height/50);
  rectMode(RIGHT);
}

boolean safe(int n) {
  boolean re = false;
  //Figure out how many zombies there are in the adjacent nodes
  for (int neighbour : nodes[n].connectedNodes) {
    if (nodes[neighbour].zombies > 0) {
      re = true;
      break;
    }
  }
  return re;
}

boolean conflict(int nodePos, int humanity) {
  boolean re = false;
  //Find if this node is in conflict by checking if there is an infected person on the node pos
  if (humanity == 0) {
    for (Person p : people) {
      if (p.nodePos == nodePos && p.infection > 0) {
        re = true;
        break;
      }
    }
  } else {
    for (Person p : people) {
      if (p.nodePos == nodePos && p.alive && p.infection == 0) {
        re = true;
        break;
      }
    }
  }
  return re;
}