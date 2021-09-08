class Person {
  float direction, vision, sightRange, wariness, runDirection, xChance, yChance;
  int nodePos, lastPos, infection, ID, stuck;
  boolean alive, moving, random;

  Person(int ID_) {
    direction = random(360);
    nodePos = int(random(xLen*yLen));
    infection = int(random(2));
    alive = true;
    vision = 80;
    wariness = random(-3, 3);
    sightRange = 200;
    ID = ID_;
    runDirection = random(360);
  }

  void personScan() {
    //boolean cont = true;
    //for (float degrees = runDirection - vision; degrees < runDirection + vision; degrees++) {
    //  int r = 0;
    //  while (cont) {
    //    r+=10;
    //    noStroke();
    //    ellipse(nodes[nodePos].xPos+ cos(radians(degrees))*r, nodes[nodePos].yPos + sin(radians(degrees))*r, 20, 20);
    //    if (r > sightRange)
    //      break;
    //  }
    //}
    int newX = 0;
    int newY = 0;
    for (Node n : nodes) {
      if (dist(nodes[nodePos].xPos, nodes[nodePos].yPos, n.xPos, n.yPos) <= sightRange) {
        boolean seen = false;
        float angle = degrees(atan2(n.yPos-nodes[nodePos].yPos, n.xPos-nodes[nodePos].xPos))+180;
        float min, max;
        min = direction - vision;
        max = direction + vision;
        if (min < 0)
          min += 360;
        if (max >= 360)
          max -= 360;
        if (direction < vision) {
          if (angle >= 0 && angle < max)
            seen = true;
          if (angle > min && angle <= 360)
            seen = true;
        } else if (direction > 360 - vision) {
          if (angle > direction - vision && angle <= 360)
            seen = true;
          if (angle < max && angle >= 0)
            seen = true;
        } else {
          if (angle > min && angle < max)
            seen = true;
        }

        //check if there is a wall in the way
        //if (seen) {
        //  for (int i = 1; i < int(dist(nodes[nodePos].xPos, nodes[nodePos].yPos, n.xPos, n.yPos)/10); i+= 40) {
        //    noFill();
        //    stroke(1);
        //    if (dist(nodes[nodePos].xPos - (nodes[nodePos].xPos-n.xPos)/i, nodes[nodePos].yPos - (nodes[nodePos].yPos-n.yPos)/i, nodes[nodePos].x, nodes[nodePos].y) <= 10) {
        //      if (!nodes[i].wall)
        //        seen = false;
        //    }
        //    ellipse(nodes[nodePos].xPos - (nodes[nodePos].xPos-n.xPos)/i, nodes[nodePos].yPos - (nodes[nodePos].yPos-n.yPos)/i, 10, 10);
        //    break;
        //  }
        //}

        if (seen) {
          n.show(0, 0, 1);
        }
        for (Person p : people) {
          if (seen && p.nodePos == n.ID && p.infection > 0) {
            newX += n.xPos-nodes[nodePos].xPos;
            newY += n.yPos-nodes[nodePos].yPos;
            moving = true;
          }
        }
      }
    }

    runDirection = degrees(atan2(newY, newX)) + 180;
    if (runDirection > 360)
      runDirection -= 360;
    for (Person p : people) {
      if (nodePos == p.nodePos && p.infection > 0)
        infection = 1;
    }
    direction += wariness;
    if (direction > 360)
      direction -= 360;
    if (direction < 0)
      direction += 360;

    stroke(0);
    line(nodes[nodePos].xPos, nodes[nodePos].yPos, nodes[nodePos].xPos + cos(radians(runDirection))*50, nodes[nodePos].yPos+sin(radians(runDirection))*50);
  }


  void zombieScan() {
    float distance = 0;
    for (Node n : nodes) {
      boolean seen = false;
      if (dist(nodes[nodePos].xPos, nodes[nodePos].yPos, n.xPos, n.yPos) <= sightRange*5) {
        seen = true;
        //n.show(0, 1, 1);
      }
      float angle = degrees(atan2(n.yPos-nodes[nodePos].yPos, n.xPos-nodes[nodePos].xPos));
      for (Person p : people) {
        if (seen && p.nodePos == n.ID && p.infection == 0) {
          if (distance == 0) {
            distance = dist(nodes[nodePos].xPos, nodes[nodePos].yPos, nodes[p.nodePos].xPos, nodes[p.nodePos].yPos);
            runDirection = angle;
            if (runDirection > 360)
              runDirection -= 360;
            moving = true;
          } else if (dist(nodes[nodePos].xPos, nodes[nodePos].yPos, nodes[p.nodePos].xPos, nodes[p.nodePos].yPos) < distance) {
            distance = dist(nodes[nodePos].xPos, nodes[nodePos].yPos, nodes[p.nodePos].xPos, nodes[p.nodePos].yPos);
            runDirection = angle;
            if (runDirection > 360)
              runDirection -= 360;
            moving = true;
          }
        }
      }
    }
    stroke(0);
    line(nodes[nodePos].xPos, nodes[nodePos].yPos, nodes[nodePos].xPos + cos(radians(runDirection))*50, nodes[nodePos].yPos+sin(radians(runDirection))*50);
  }

  void move() {
    boolean moved = false;
      if (stuck < 20) {
        if (random(10) > 1) {
          xChance = cos(radians(runDirection));
          yChance = -sin(radians(runDirection));
          float d = random(abs(xChance) + abs(yChance));
          if (d < abs(xChance)) {
            if (xChance >= 0) {
              if (nodePos+1 < xLen*yLen && nodes[nodePos].connectedNodes.get(2) != -1 &! nodes[nodePos+1].wall) {
                nodePos ++;
                moved = true;
              } else {
                if (nodePos-1 > 0 && nodes[nodePos].connectedNodes.get(3) != -1 &! nodes[nodePos-1].wall)
                  nodePos --;
                moved = true;
              }
            }
          } else {
            if (yChance >= 0) {
              if (nodePos-xLen > 0 && nodes[nodePos].connectedNodes.get(0) != -1 &! nodes[nodePos-xLen].wall)
                nodePos -= xLen;
                moved = true;
            } else {
              if (nodePos+xLen < xLen*yLen && nodes[nodePos].connectedNodes.get(1) != -1 &! nodes[nodePos+xLen].wall)
                nodePos += xLen;
                moved = true;
            }
          }
        }
    } if (!moved) {
      float d1 = int(random(2));
      float d2 = int(random(2));
      if (d1 == 0) {
        if (d2 == 0) {
          if (nodePos+1 < xLen*yLen && nodes[nodePos].connectedNodes.get(2) != -1 &! nodes[nodePos+1].wall) {
            nodePos ++;
          } else {
            if (nodePos-1 > 0 && nodes[nodePos].connectedNodes.get(3) != -1 &! nodes[nodePos-1].wall)
              nodePos --;
          }
        }
      } else {
        if (d2 >= 0) {
          if (nodePos-xLen > 0 && nodes[nodePos].connectedNodes.get(0) != -1 &! nodes[nodePos-xLen].wall)
            nodePos -= xLen;
        } else {
          if (nodePos+xLen < xLen*yLen && nodes[nodePos].connectedNodes.get(1) != -1 &! nodes[nodePos+xLen].wall)
            nodePos += xLen;
        }
      }
    }
    lastPos = nodePos;
  }
}