class Square {
  int x, y, ID, total;
  float xPos, yPos, targetXPos, targetYPos;

  Square(int ID_) {
    ID = ID_;
    x = ID % 4;
    for (int i = 0; i < 4; i++) { 
      if (15-i*4 >= ID) 
        y = 3-i;
    }
    xPos = (x+1)*rectSpacer + x*rectSize + rectSize/2;
    yPos = (y+1)*rectSpacer + y*rectSize + rectSize/2;
  }

  void show() {
    noStroke();
    if (total > 0) {
      fill(map(total, 0, 12, 25, 255), 255, 255);
      rect(xPos, yPos, rectSize, rectSize, 10);
      fill(255);
      text(str(int(pow(2, total))), xPos, yPos+20);
    }
  }
}
