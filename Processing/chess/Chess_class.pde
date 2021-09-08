class Chess {
  int[][] board = new int[8][8];
  PImage[] images;
  float squareLength;
  PVector selected;
  int count = 0;
  boolean checkCastle[] = new boolean[6];

  Chess() {
    // 1 = W pawn
    // 2 = W knight
    // 3 = W bishop
    // 4 = W rook
    // 5 = W queen
    // 6 = W king
    // 7 = B pawn
    // 8 = B knight
    // 9 = B bishop
    // 10 = B rook
    // 11 = B queen
    // 12 = B king
    for (int y = 0; y < 8; y++) {
      if (y == 0) {
        board[y] = new int[]{10, 8, 9, 11, 12, 9, 8, 10};
      } else if (y == 1) {
        board[y] = new int[]{7, 7, 7, 7, 7, 7, 7, 7};
      } else if (y == 6) {
        board[y] = new int[]{1, 1, 1, 1, 1, 1, 1, 1};
      } else if (y == 7) {
        board[y] = new int[]{4, 2, 3, 5, 6, 3, 2, 4};
      }
    }
    squareLength = min(width, height);

    images = new PImage[12];
    for (int i = 0; i < 12; i++) {
      String fileName = new String(str(i+1) + ".png");
      images[i] = loadImage(fileName);
      images[i].resize(int(squareLength/8*0.8), int(squareLength/8*0.8));
    }
    selected = new PVector(-1, -1);
  }

  void showBoard() {
    for (int y = 0; y < 8; y++) {
      for (int x = 0; x < 8; x++) {
        float xCoor = (squareLength/8)/2 + (squareLength/8)*x;
        float yCoor = (squareLength/8)/2 + (squareLength/8)*y;
        fill(125, 148, 93);
        if ((x+y) % 2 == 0) {
          fill(238, 238, 213);
        }
        if (selected.x == x && selected.y == y) {
          fill(186, 202, 43);
        }
        rect(xCoor, yCoor, squareLength/8, squareLength/8);
        if (board[y][x] > 0) {
          image(images[board[y][x] - 1], xCoor, yCoor);
        }
      }
    }
  }

  void updatePosition(PVector from, PVector to) {
    //println(int(from.x), int(from.y));
    //println(int(to.x), int(to.y));
    board[(int)to.y][(int)to.x] = board[(int)from.y][(int)from.x];
    board[(int)from.y][(int)from.x] = 0;
  }

  void highlightSquare() {
    // Find square clicked on
    PVector currentSelected = null;
    for (int y = 0; y < 8; y++) {
      for (int x = 0; x < 8; x++) {
        float xCoor = (squareLength/8)/2 + (squareLength/8)*x;
        float yCoor = (squareLength/8)/2 + (squareLength/8)*y;
        if (mouseX > xCoor-(squareLength/8)/2 && mouseX < xCoor+(squareLength/8)/2) {
          if (mouseY > yCoor-(squareLength/8)/2 && mouseY < yCoor+(squareLength/8)/2) {
            currentSelected = new PVector((int)x, (int)y);
            break;
          }
        }
      }
      if (currentSelected != null) {
        break;
      }
    }

    if (currentSelected == null) {
      return;
    }

    // Check if there was a previously highlighted square
    if (selected.x == -1 && selected.y == -1) {
      selected = currentSelected;
    } else if (selected.x == currentSelected.x && selected.y == currentSelected.y) {
      selected = new PVector(-1, -1);
    } else {
      boolean legalMove = false;
      PVector dist = new PVector(abs(currentSelected.x-selected.x), abs(currentSelected.y-selected.y));
      PVector direction = new PVector(int((currentSelected.x-selected.x)/abs(currentSelected.x-selected.x)), int((currentSelected.y-selected.y)/abs(currentSelected.y-selected.y)));
      switch ((returnType(selected)-1)-6*(count%2)) {
      case 0:
        //Pawn
        if (currentSelected.x == selected.x && currentSelected.y < selected.y) {
          if ((selected.y == 6 && dist.mag() <= 2) || dist.mag() == 1) {
            for (int i = 0; i < dist.mag(); i++) {
              if (returnType(selected.add(0, -i)) != 0) {
                break;
              }
            }
            legalMove = true;
          }
        } else if (dist.x == 1 && dist.y == 1 && currentSelected.y < selected.y) {
          if ((returnType(currentSelected)) != 0 && ((returnType(currentSelected)-1)-6*(count%2) < 0 || (returnType(currentSelected)-1)-6*(count%2) >= 6)) {
            legalMove = true;
          }
        }
        break;
      case 1:
        //Knight
        if ((dist.x == 1 && dist.y == 2) || (dist.x == 2 && dist.y == 1)) {
          legalMove = true;
        }
        break;
      case 2:
        //Bishop
        if (dist.x == dist.y) {
          legalMove = true;
          for (int i = 1; i <= dist.x; i++) {
            PVector current = new PVector(int(selected.x + direction.x*i), int(selected.y + direction.y*i));
            if (board[int(current.y)][int(current.x)] != 0) {
              println((returnType(current)-1)-6*(count%2));
              if ((returnType(current)-1)-6*(count%2) < 0 || (returnType(current)-1)-6*(count%2) >= 6) {
                break;
              }
              legalMove = false;
              break;
            }
            if (int(current.x) == int(currentSelected.x) && int(current.y) == int(currentSelected.y)) {
              break;
            }
          }
        }
        break;
      case 3:
        //Rook
        if (dist.x == 0 || dist.y == 0) {
          legalMove = true;
          for (int i = 1; i <= dist.mag(); i++) {
            PVector current = new PVector(int(selected.x + direction.x*i), int(selected.y + direction.y*i));
            if (board[int(current.y)][int(current.x)] != 0) {
              if ((returnType(current)-1)-6*(count%2) < 0 || (returnType(current)-1)-6*(count%2) >= 6) {
                break;
              }
              legalMove = false;
              break;
            }
            if (int(current.x) == int(currentSelected.x) && int(current.y) == int(currentSelected.y)) {
              break;
            }
          }
          if (legalMove) {
            println(int(selected.x%6+(count%2)*2));
            checkCastle[int(selected.x%6+(count%2)*2)] = true;
            println(checkCastle);
          }
        }
        break;
      case 4:
        //Queen
        if (dist.x == 0 || dist.y == 0) {
          legalMove = true;
          for (int i = 1; i <= dist.mag(); i++) {
            PVector current = new PVector(int(selected.x + direction.x*i), int(selected.y + direction.y*i));
            if (board[int(current.y)][int(current.x)] != 0) {
              if ((returnType(current)-1)-6*(count%2) < 0 || (returnType(current)-1)-6*(count%2) >= 6) {
                break;
              }
              legalMove = false;
              break;
            }
            if (int(current.x) == int(currentSelected.x) && int(current.y) == int(currentSelected.y)) {
              break;
            }
          }
        } else if (dist.x == dist.y) {
          legalMove = true;
          for (int i = 1; i <= dist.x; i++) {
            PVector current = new PVector(int(selected.x + direction.x*i), int(selected.y + direction.y*i));
            if (board[int(current.y)][int(current.x)] != 0) {
              if ((returnType(current)-1)-6*(count%2) < 0 || (returnType(current)-1)-6*(count%2) >= 6) {
                break;
              }
              legalMove = false;
              break;
            }
            if (int(current.x) == int(currentSelected.x) && int(current.y) == int(currentSelected.y)) {
              break;
            }
          }
        }
        break;
      case 5:
        //King
        if ((dist.x == 1 && dist.y == 1) || (dist.x == 1 && dist.y == 0) || (dist.x == 0 && dist.y == 1)) {
          if ((returnType(currentSelected)-1)-6*(count%2) < 0 || (returnType(currentSelected)-1)-6*(count%2) >= 6) {
            legalMove = true;
            checkCastle[4+(count%2)] = true;
          }
        } else if (dist.x == 2 && dist.y == 0) {
          // left W castle, right W castle, left B castle, right B castle, W king, B king
          if (currentSelected.x < selected.x) {
            println(checkCastle[2*(count%2)], checkCastle[4+(count%2)]);
            if (!checkCastle[2*(count%2)] &! checkCastle[4+(count%2)]) {
              legalMove = true;
              for (int i = 1; i <= 2+(count+1)%2; i++) {
                if (board[int(selected.y)][int(selected.x-i)] != 0) {
                  legalMove = false;
                  break;
                }
              }
              if (legalMove) {
                println("BL castle");
                board[7][0] = 0;
                board[7][2+(count+1)%2] = 4+6*((count)%2);
              }
            }
          } else {
            if (!checkCastle[2*(count%2)+1] &! checkCastle[4+(count+1)%2]) {
              legalMove = true;
              for (int i = 1; i <= 2; i++) {
                if (board[int(selected.y)][int(selected.x+i)] != 0) {
                  legalMove = false;
                  break;
                }
              }
              if (legalMove) {
                println("BR castle");
                println((5+(count+1)%2), (4+6*(count%2)));
                board[7][7] = 0;
                board[7][5-(count)%2] = 4+6*(count%2);
              }
            }
          }
          //if (legalMove) {
          //  legalMove = checkKingSafety();
          //}
        }
        break;
      }
      if (legalMove) {
        updatePosition(selected, currentSelected);
        selected = new PVector(-1, -1);
        count++;
        flipBoard();
        playSound();
      } else {
        selected = new PVector(-1, -1);
      }
    }
    showBoard();
  }

  void flipBoard() {
    int temp;
    for (int y = 0; y < 4; y++) {
      for (int x = 0; x < 8; x++) {
        temp = board[x][y];
        board[x][y] = board[7-x][7-y];
        board[7-x][7-y] = temp;
      }
    }
  }

  int returnType(PVector pos) {
    return board[int(pos.y)][int(pos.x)];
  }
}
