class Cross {
  float crossx;
  float crossy;
  int pos;
  int left;
  int right;
  int up;
  int down;

  Cross(float x, float y, int position) {
    crossx = x;
    crossy = y;
    pos = position;
  }

  void check() {
    noFill();
    noStroke();
    strokeWeight(0.5);
    textSize(20);
    textAlign(CENTER);
    //text(" " + pos, crossx, crossy);
    if (check) {
      if (numbers[pos] == 0) {
        if (dist(mouseX, mouseY, crossx, crossy) <= width/22) {
          if (turn % 2 == 0) {
            numbers[pos] = 1;
            turn += 1;
          } else {
            numbers[pos] = 2;
            turn += 1;
          }
        }
      }
    }
    if (numbers[pos] == 1) {
      fill(0);
      stroke(200);
    } else if (numbers[pos] == 2) {
      fill(255);
      stroke(50);
    } else {
      noFill();
    }

    ellipse(crossx, crossy+1, width/30*2, height/30*2);

    //kill piece
    if (pos > 8 && pos < 72) {
      if (pos % 9 == 0) {
        up = 0; //!!!!!
        down = numbers[pos + 1];
      }
      if (pos % 9 == 8) {
        up = numbers[pos-1];
        down = 0;//!!!!!
      }
      left = numbers[pos - 9];
      right = numbers[pos + 9];
    }

    if (pos < 9 || pos > 71) {
      if (pos != 0 && pos != 8 && pos != 72 && pos != 80) {
        up = numbers[pos-1];
        down = numbers[pos+1];
        if (pos < 9) {
          left = 0;//!!!!
          right = numbers[pos+9];
        }
        if (pos > 71) {
          left = numbers[pos-9];
          right = 0;//!!!!
        }
      }
      if (pos == 0) {
        left = 0;//
        right = numbers[pos+9];
        up = 0;//
        down = numbers[pos+1];
      }
      if (pos == 8) {
        left = 0;//
        right = numbers[pos+9];
        up = numbers[pos-1];
        down = 0;//
      }
      if (pos == 72) {
        left = numbers[pos-9];
        right = 0;//
        up = 0;//
        down = numbers[pos+1];
      }
      if (pos == 81) {
        left = numbers[pos-9];
        right = 0;//
        up = numbers[pos-1];
        down = 0;//
      }
    }

    if (numbers[pos] == 1) {
      if (left == 2 && right == 2 && down == 2 && up == 2) {
        numbers[pos] = 0;
        print("AAAAHHHHH");
      }
    }
    if (numbers[pos] == 2) {
      if (left == 1 && right == 1 && down == 1 && up == 1) {
        numbers[pos] = 0;
        print("AAAAHHHHH");
      }
    }
  }
}