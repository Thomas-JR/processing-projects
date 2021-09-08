class Person {
  PVector pos, lastPos;
  int nodePos, infection, ID;
  IntList targetNodes, newPlaces;
  float strength, weakness, fed;
  boolean alive, moving;

  Person(int place_, int ID_) {
    pos = new PVector();
    alive = true;
    ID = ID_;
    nodePos = place_;
    strength = random(1, 10);
    fed = state.full;
    targetNodes = new IntList(0);
  }

  void show() {
    // Show the display of person or zombie
    if (infection > 0)
      image(state.zombie, pos.x, pos.y);
    else
      image(state.plant, pos.x, pos.y);
  }

  void update() {
    if (state.play && alive) {
      if (infection > 0) {
        //Make zombies hungry and increase the person's time being infection
        infection ++;
        fed -= map(strength, 1, 10, 0.2, 0.03);
      }
      if (fed < 0)
        alive = false;
      if (!moving && random(0, map(fed, 0, 100, 0, 10)) <= 0.1) {
        //map strength from minimum to maximum fullness to make newly created zombies stronger
        weakness = map(fed, 0, state.full, 0.8, 1);

        if (infection > state.infected) {
          boolean ate = false;
          //Go through every person until there is one that is in the same location as this zombie's location
          for (Person otherPerson : people) {
            if (!otherPerson.moving && otherPerson.nodePos == nodePos && otherPerson.infection == 0) {
              if (strength*weakness > otherPerson.strength) {
                //Make the person a zombie if the zombie is stronger
                strength -= otherPerson.strength;
                otherPerson.infection = state.infected;
                otherPerson.targetNodes.clear();
                fed = state.full;
                ate = true;
                break;
              } else {
                //Otherwise kill the zombie but weaken the person
                alive = false;
                otherPerson.strength -= strength*weakness;
                targetNodes.clear();
                ate = true;
                break;
              }
            }
          }
          // Give destination
          if (targetNodes.size() == 0 && random(100) <= 100/state.zombieSpeed*10) {
            moving = false;
            zombieMove(); // Give the zombie a target destination and start moving
          }
        }
      }
      if (random(1) > state.humanFear &! moving)
        humanMove(); //Make a route for a person to move on
      if (alive && moving)
        move();
    }
  }

  void move() {
    //Whilst moving check if two people should engage in combat
    for (Person otherPerson : people) {
      if (otherPerson.ID != ID && infection > 0 && otherPerson.alive && otherPerson.moving && dist(pos.x, pos.y, otherPerson.pos.x, otherPerson.pos.y) < 30) {
        if (int(random(4)) == 2) {
          otherPerson.infection = 1;
        } else
          alive = false;
      }
    }
    //Move the zombies on the screen to the target node
    if (targetNodes.size() > 0) {
      float angle = atan2(nodes[targetNodes.get(0)].y-pos.y, nodes[targetNodes.get(0)].x-pos.x);
      if (infection == 0) {
        pos.x += cos(angle)*state.humanSpeed;
        pos.y += sin(angle)*state.humanSpeed;
      } else {
        pos.x += cos(angle)*state.zombieSpeed;
        pos.y += sin(angle)*state.zombieSpeed;
      }
      //If withing a certain distance make the person become at that point and reset it's route plan
      if (dist(pos.x, pos.y, nodes[targetNodes.get(0)].x, nodes[targetNodes.get(0)].y) <= nodes[targetNodes.get(0)].size/2) {
        moving = false;
        nodePos = targetNodes.get(0);
        targetNodes.clear();
      }
    }
  }

  void humanMove() {
    int target = 0; // Integer that will change for where the human will have to go
    IntList possibleTargets = new IntList(0);
    if (strength < state.strongPerson) { // weak people
      if (!safe(nodePos) || conflict(nodePos, infection)) { // make sure you have to leave
        // Go through all the nodes, all the neighbouring nodes of that node and save the ones without zombies
        int leastStrength = 270000000;
        int weakness = 0;
        for (Node n : nodes) {
          if (safe(n.ID) &! conflict(n.ID, infection)) {
            for (Person person : people)  if (person.nodePos == n.ID)  weakness ++;
            // Store the value of the ID and weakness value so we can use them later on
            if (weakness > 0 && weakness < leastStrength) {
              target = n.ID;
              leastStrength = weakness;
            }
          }
        }
        targetNodes = dijkstrasAlgorithm(target);
      } else if (random(1) > state.humanFear) {
        target = nodes[nodePos].connectedNodes.get(int(random(nodes[nodePos].connectedNodes.size())));
      }
    } else { // strong people
      if (!conflict(nodePos, infection) && safe(nodePos)) {
        // If not fighting, add all the infected neighbours to a list
        for (int node : nodes[nodePos].connectedNodes) {
          for (Person p : people) {
            if (node == p.nodePos && p.infection > 0)
              possibleTargets.append(node);
          }
        }
        if (possibleTargets.size() > 0) {
          // if there are infected nodes go to one of the infected nodes randomly
          target = possibleTargets.get(int(random(possibleTargets.size())-1));
        }
      } else if (!conflict(nodePos, infection)) {
        for (Node n : nodes) {
          for (Person p : people) {
            if (n.ID == p.nodePos && p.infection > 0)
              possibleTargets.append(n.ID);
          }
        }
        if (possibleTargets.size() > 0) {
          targetNodes = dijkstrasAlgorithm(possibleTargets.get(int(random(possibleTargets.size())-1)));
        }
      }
    }
    // go to better location if there is one
    if (targetNodes.size() == 0)
      targetNodes.append(dijkstrasAlgorithm(target));
    if (targetNodes.size() > 1)
      targetNodes.remove(0);
    moving = true;
    float angle = atan2(nodes[targetNodes.get(0)].y-nodes[nodePos].y, nodes[targetNodes.get(0)].x-nodes[nodePos].x);
    pos.x = nodes[nodePos].x+cos(angle)*nodes[nodePos].size/2;
    pos.y = nodes[nodePos].y+sin(angle)*nodes[nodePos].size/2;
  }

  void zombieMove() {
    boolean go = true;
    for (Person p : people) {
      if (p.nodePos == nodePos && p.alive && p.infection == 0) 
        go = false;
    }
    if (go) {
      //For every neighbouring node check if there is a human on it
      for (int node : nodes[nodePos].connectedNodes) {
        for (Person p : people) {
          if (p.nodePos == node && p.infection == 0) {
            targetNodes.append(node);
          }
        }
      }
      int target;
      if (targetNodes.size() == 0)
        target = nodes[nodePos].connectedNodes.get(int(random(nodes[nodePos].connectedNodes.size())));
      else 
      target = targetNodes.get(int(random(targetNodes.size())));
      targetNodes.clear();
      targetNodes.append(target);
      float direction = atan2(nodes[targetNodes.get(0)].y-nodes[nodePos].y, nodes[targetNodes.get(0)].x-nodes[nodePos].x);
      pos.x = nodes[nodePos].x+cos(direction)*nodes[nodePos].size/2;
      pos.y = nodes[nodePos].y+sin(direction)*nodes[nodePos].size/2;
      moving = true;
    }
  }

  IntList dijkstrasAlgorithm(int targetNode) {
    // For every node set a starting distance of infinity (integer max number) 
    //and set the starting node to 0
    for (Node n : nodes) {
      n.dDistance = 2147483647;
      n.dAlive = true;
      if (n.ID == nodePos)
        n.dDistance = 0;
    }
    //Make sure the person is not already at the target node
    boolean finished = true;
    if (targetNode != nodePos)
      finished = false;
    //Repeat for all nodes...
    while (!finished) {
      // Select from all the alive nodes the one with the smallest distance from the starting node
      int currentNode = 0;
      for (Node n : nodes) {
        if (n.dAlive) {
          if (nodes[currentNode].dAlive) {
            if (n.dDistance < nodes[currentNode].dDistance)
              currentNode = n.ID;
            //Make sure that the starting checker node is actually an active node
          } else currentNode = n.ID;
        }
      }
      //Update the distance from the starter node for all new neighbouring nodes
      for (int newNode : nodes[currentNode].connectedNodes) {
        if (nodes[currentNode].dAlive && nodes[currentNode].dDistance + dist(nodes[currentNode].x, nodes[currentNode].y, nodes[newNode].x, nodes[newNode].y) < nodes[newNode].dDistance)
          nodes[newNode].dDistance = nodes[currentNode].dDistance + dist(nodes[currentNode].x, nodes[currentNode].y, nodes[newNode].x, nodes[newNode].y);
      }
      finished = true;
      //if every node is updated end
      for (Node n : nodes) if (n.dDistance == 2147483647) finished = false;
      nodes[currentNode].dAlive = false;
    }
    IntList route = new IntList(0);
    route.append(targetNode);
    finished = false;
    //Create the route from the end node to the starter node
    while (!finished) {
      int smallest = nodes[targetNode].connectedNodes.get(0);
      for (int smallNode : nodes[targetNode].connectedNodes)
        if (nodes[smallNode].dDistance < nodes[smallest].dDistance)  smallest = smallNode;
      if (nodes[targetNode].dDistance != 0) {
        targetNode = smallest;
        // add to a list the smallest element making its way back from the target node
        route.append(targetNode);
      } else { 
        break;
      }
    }
    //reverse and return the list
    route.reverse();
    return route;
  }
}