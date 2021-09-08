class Person {
  int nodePos, lastPos, infection, ID, targetNodePos;
  float x, y, strength, weakness, fed;
  boolean alive, moving, lastMoving;

  Person(int place_, int ID_) {
    alive = true;
    ID = ID_;
    nodePos = place_;
    strength = random(1, 10);
    fed = state.full;
  }

  void show() {
    if (infection > 0)
      fill(255, 0, 0);
    else
      fill(0, 255, 0);
    ellipse(x, y, 20, 20);
  }

  void update() {
    //Make zombies hungry and increase the person's time being infection
    if (infection > 0) {
      if (state.play) {
        infection ++;
        if (fed > 0)
          fed -= map(strength, 0, 10, 0.2, 0.03);
        else {
          alive = false;
        }
      }
    } else if (state.play &! moving)
      humanMove();
    if (state.play &! moving) {
      //map strength from minimum to maximum fullness to make newly created zombies stronger
      weakness = map(fed, 0, state.full, 0.8, 1.5);

      if (infection > state.infected) {
        //Go through every person until there is one that is in the same location as this person's location
        for (Person otherPerson : people) {
          if (otherPerson.nodePos == nodePos && otherPerson.infection == 0) {
            //Make a zombie if the zombie has not fed and the zombie is stronger
            //Otherwise kill the zombie but weaken the person
            if (strength*weakness > otherPerson.strength) {
              strength -= otherPerson.strength;
              otherPerson.infection = state.infected;
              fed = state.full;
              break;
            } else {
              alive = false;
              otherPerson.strength -= strength;
              break;
            }
          }
        }
      }
      //If infected then calculate a chance for the zombie to move
      if (infection > state.infected) {
        if (random(0, 1) > map(fed/state.full, 1, 0, 1, 0.95)) {
          targetNodePos = nodes[nodePos].connectedNodes.get(int(random(nodes[nodePos].connectedNodes.size())));
          float angle = atan2(nodes[targetNodePos].y-nodes[nodePos].y, nodes[targetNodePos].x-nodes[nodePos].x);
          x = nodes[nodePos].x+cos(angle)*nodes[nodePos].size/2;
          y = nodes[nodePos].y+sin(angle)*nodes[nodePos].size/2;
          if (targetNodePos != lastPos) {
            moving = true;
            lastPos = targetNodePos;
          }
        }
      }
    }
    if (moving && state.play) {
      moving();
    }
  }

  void moving() {
    //Whilst moving check if two people should engage in combat
    for (Person p : people) {
      if (p.alive && p.moving && dist(x, y, p.x, p.y) < 20) {
        if (infection > 0 && p.infection == 0)
          p.alive = false;
        else if (infection == 0 && p.infection > 1)
          infection = 1;
      }
    }
    //Move the zombies on the screen to the target node
    if (state.play) {
      float angle = atan2(nodes[targetNodePos].y-y, nodes[targetNodePos].x-x);
      if (infection == 0) {
        x += cos(angle)*state.humanSpeed;
        y += sin(angle)*state.humanSpeed;
      } else {
        x += cos(angle)*state.zombieSpeed;
        y += sin(angle)*state.zombieSpeed;
      }
      if (dist(x, y, nodes[targetNodePos].x, nodes[targetNodePos].y) <= nodes[targetNodePos].size/2) {
        moving = false;
        nodePos = targetNodePos;
      }
    }
  }

  void humanMove() {
    //Decide to start moving the humans to a new location where it picks a new node only if it has no threat of zombies
    for (int i = 0; i < nodes[nodePos].connectedNodes.size(); i++) {
      if (nodes[nodes[nodePos].connectedNodes.get(i)].zombies == 0 && random(1) >= state.humanFear) {
        targetNodePos = nodes[nodePos].connectedNodes.get(i);
        moving = true;
        float angle = atan2(nodes[targetNodePos].y-nodes[nodePos].y, nodes[targetNodePos].x-nodes[nodePos].x);
        x = nodes[nodePos].x+cos(angle)*nodes[nodePos].size/2;
        y = nodes[nodePos].y+sin(angle)*nodes[nodePos].size/2;
        lastPos = targetNodePos;
        break;
      }
    }
  }
}