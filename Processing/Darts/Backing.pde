class Backing {
  float leftSplit;
  float left, up, h, w;
  int start, total1, total2;
  PImage background;
  String name1, name2;
  Character lastKeyPressed;
  boolean started, lastKey, lastPress, name1pressed, name2pressed, singlePlayer;
  IntList scores;

  Backing() {
    leftSplit = width/10;
    start = 27;
    background = loadImage("background.jpg");
    background.resize(width, height);
    left = width/20;
    up = height/7;
    w = width/3;
    h = height/30;
    name1 = "";
    name2 = "";
    scores = new IntList(0);
  }

  void show() {
    if (!singlePlayer) {
      fill(150, 50);
      textSize(100);
      text(int(scores.size()-1/2)/2+1, width/2, height/2);
      if (keyPressed && key-48 >= 0 && key-48 <= 9 &! lastKey && scores.size() < 40) {
        int s = key - 48;
        if (s == 0) {
          s = -2;
        }
        if (scores.size() % 2 == 0) {
          total1 += s*((int(scores.size()-1/2)/2)+1);
          scores.append(total1);
          //scores.append(0);
        } else {
          total2 += s*((int(scores.size()-1/2)/2)+1);
          scores.append(total2);
        }
        println(s, scores, s*((int(scores.size()-1)/2)+1));
      }
      if (keyPressed &! lastKey && key == '') {
        if (scores.size() > 2) {
          if (scores.size() % 2 == 0) {
            total2 = scores.get(scores.size()-3);
            println(scores.get(scores.size()-3));
          } else {
            total1 = scores.get(scores.size()-3);
            println(scores.get(scores.size()-3));
          }
          scores.pop();
          println(scores);
        } else if (scores.size() > 0) {
          scores.pop();
          if (scores.size() == 0) {
            total1 = start;
          } else {
            total2 = start;
          }
        }
      }

      stroke(230);
      line(leftSplit, height/4, width, height/4);
      line(leftSplit, height/4*3, width, height/4*3);

      float maximum = 0;
      for (int i = 0; i < scores.size(); i++) {
        if (sqrt(sq(scores.get(i))) > maximum)
          maximum = sqrt(sq(scores.get(i)));
      }

      float xdist = width-leftSplit;
      float ydist = height/4;
      for (int i = 0; i < 20; i++) {
        line(xdist/20*i + xdist/40 + leftSplit, 0, xdist/20*i + xdist/40 + leftSplit, height);
      }
      stroke(0);
      float lx = leftSplit;
      float ly = height/4;
      for (int i = 0; i < scores.size(); i += 2) {
        float y = height/4;
        y -= (ydist/maximum) * scores.get(i);
        float x = xdist/20*int(i/2) + xdist/40 + leftSplit;
        if (i == 0) {
          lx = x;
          ly = y;
        }
        line(x, y, lx, ly);
        lx = x;
        ly = y;
      }
      lx = leftSplit;
      ly = height/4*3;
      for (int i = 1; i < scores.size(); i += 2) {
        float y = height/4 * 3;
        y -= (ydist/maximum) * scores.get(i);
        float x = xdist/20*int(i/2) + xdist/40 + leftSplit;
        if (i == 1) {
          lx = x;
          ly = y;
        }
        line(x, y, lx, ly);
        lx = x;
        ly = y;
      }

      line(0, height/2, width, height/2);
      line(0, height/4, leftSplit, height/4);
      line(0, height/4*3, leftSplit, height/4*3);
      line(leftSplit, 0, leftSplit, height);

      fill(0);
      textSize(24);
      textAlign(CENTER);
      text(name1, leftSplit/2, height/8);
      text(name2, leftSplit/2, height/8*5);
      text(total1, leftSplit/2, height/8*3);
      text(total2, leftSplit/2, height/8*7);
    } else {
      fill(150, 50);
      textSize(100);
      text(int(scores.size()-1/2)/2+1, width/2, height/2);
      if (keyPressed && key-48 >= 0 && key-48 <= 9 &! lastKey && scores.size() < 40) {
        int s = key - 48;
        if (s == 0) {
          s = -2;
        }
        if (scores.size() % 2 == 0) {
          total1 += s*((int(scores.size()-1/2)/2)+1);
          scores.append(total1);
          //scores.append(0);
        } else {
          total2 += s*((int(scores.size()-1/2)/2)+1);
          scores.append(total2);
        }
        println(s, scores, s*((int(scores.size()-1)/2)+1));
      }
      if (keyPressed &! lastKey && key == '') {
        if (scores.size() > 2) {
          if (scores.size() % 2 == 0) {
            total2 = scores.get(scores.size()-3);
            println(scores.get(scores.size()-3));
          } else {
            total1 = scores.get(scores.size()-3);
            println(scores.get(scores.size()-3));
          }
          scores.pop();
          println(scores);
        } else if (scores.size() > 0) {
          scores.pop();
          if (scores.size() == 0) {
            total1 = start;
          } else {
            total2 = start;
          }
        }
      }

      stroke(230);
      line(leftSplit, height/4, width, height/4);
      line(leftSplit, height/4*3, width, height/4*3);

      float maximum = 0;
      for (int i = 0; i < scores.size(); i++) {
        if (sqrt(sq(scores.get(i))) > maximum)
          maximum = sqrt(sq(scores.get(i)));
      }

      float xdist = width-leftSplit;
      float ydist = height/4;
      for (int i = 0; i < 20; i++) {
        line(xdist/20*i + xdist/40 + leftSplit, 0, xdist/20*i + xdist/40 + leftSplit, height);
      }
      stroke(0);
      float lx = leftSplit;
      float ly = height/4;
      for (int i = 0; i < scores.size(); i += 2) {
        float y = height/4;
        y -= (ydist/maximum) * scores.get(i);
        float x = xdist/20*int(i/2) + xdist/40 + leftSplit;
        if (i == 0) {
          lx = x;
          ly = y;
        }
        line(x, y, lx, ly);
        lx = x;
        ly = y;
      }
      lx = leftSplit;
      ly = height/4*3;
      for (int i = 1; i < scores.size(); i += 2) {
        float y = height/4 * 3;
        y -= (ydist/maximum) * scores.get(i);
        float x = xdist/20*int(i/2) + xdist/40 + leftSplit;
        if (i == 1) {
          lx = x;
          ly = y;
        }
        line(x, y, lx, ly);
        lx = x;
        ly = y;
      }

      line(0, height/2, width, height/2);
      line(0, height/4, leftSplit, height/4);
      line(0, height/4*3, leftSplit, height/4*3);
      line(leftSplit, 0, leftSplit, height);

      fill(0);
      textSize(24);
      textAlign(CENTER);
      text(name1, leftSplit/2, height/8);
      text(name2, leftSplit/2, height/8*5);
      text(total1, leftSplit/2, height/8*3);
      text(total2, leftSplit/2, height/8*7);
    }
  }

  void create() {
    strokeWeight(3);
    image(background, 0, 0);
    textSize(60);
    fill(255);
    text("Starting Score:", left, height/10);
    fill(240);
    noStroke();
    rect(left, up, w, h);
    if (mouseX > left && mouseX < left+w) {
      if (mouseY > up && mouseY < up+h) {
        if (mousePressed) 
          start = int(map(mouseX, left, left+w, -101, 101));
      }
    }
    fill(180);
    stroke(100);
    rect(map(start, -100, 100, left, left + w)-h/4, up-h/2, 20, (h*2), 30);
    fill(255);
    text(start, left, up + 4*h);


    if (keyPressed) {
      if (!lastKey || lastKeyPressed != key) {
        if (name1pressed) {
          if (key != '?' && key != '') {
            if (name1.length() == 0)
              name1 += char(key - 32);
            else
              name1 += key;
          }
        } 
        if (name1pressed && key == '' && name1.length() >= 1) {
          String n = "";
          for (int i = 0; i < name1.length()-1; i++) {
            n += name1.charAt(i);
          }
          name1 = n;
        }
        if (name2pressed) {
          if (key != '?' && key != '')
            if (name2.length() == 0)
              name2 += char(key - 32);
            else
              name2 += key;
        } 
        if (name2pressed && key == '' && name2.length() >= 1) {
          String n = "";
          for (int i = 0; i < name2.length()-1; i++) {
            n += name2.charAt(i);
          }
          name2 = n;
        }
      }
    }

    stroke(255);
    text("Name 1: " + name1, left, height/2-height/10);
    fill(255);
    if (name1pressed) {
      fill(150);
    } else {
      if (dist(left+h*3, height/2+h*2-height/10, mouseX, mouseY) <= h*2)
        fill(200);
    }
    if (mousePressed &! lastPress && dist(left+h*3, height/2+h*2-height/10, mouseX, mouseY) <= h*2) {
      if (name1pressed) {
        name1pressed = false;
      } else {
        name1pressed = true;
        if (name2pressed) name2pressed = false;
      }
    }
    ellipse(left+h*3, height/2+h*2-height/10, h*2, h*2);
    fill(255);
    text("Name 2: " + name2, left, height/6*4-height/10);
    fill(255);
    if (name2pressed) {
      fill(150);
    } else {
      if (dist(left+h*3, height/6*4+h*2-height/10, mouseX, mouseY) <= h*2)
        fill(200);
    }
    if (mousePressed &! lastPress && dist(left+h*3, height/6*4+h*2-height/10, mouseX, mouseY) <= h*2) {
      if (name2pressed) {
        name2pressed = false;
      } else {
        name2pressed = true;
        if (name1pressed) name1pressed = false;
      }
    }
    ellipse(left+h*3, height/6*4+h*2-height/10, h*2, h*2);
    fill(0, 255, 0);
    if (mouseX > left && mouseX < left + w*3/4 && mouseY > height*5/6 - height/20 && mouseY < height*5/6 - height/20 + h*3) {
      fill(0, 230, 0);
      if (mousePressed) {
        started = true;
        total1 = start;
        total2 = start;
      }
    }
    rect(left, height*5/6 - height/20, w*3/4, h*3);
    noStroke();
    fill(255);
    textAlign(CENTER);
    text("Single Player", width/2, height-height*0.9);
    text("START", left+w*3/8, height*5/6 + h*2 - height/20);
    if (singlePlayer) {
      fill(150);
    }
    if (dist(mouseX, mouseY, width/2, height-height*0.8) <= h) {
      fill(200);
      if (mousePressed &! lastPress) {
        if (singlePlayer) {
          singlePlayer = false;
        } else {
          singlePlayer = true;
        }
      }
    }
    stroke(255);
    ellipse(width/2, height-height*0.8, h*2, h*2);
    textAlign(LEFT);
  }

  void update() {
    lastKey = keyPressed;
    lastPress = mousePressed;
    lastKeyPressed = key;
  }
}
