class Lazer {
  Lazer() {
    shoot = false;
  }
  void goAway() {
    if (y <= 0) {
      shoot = false;
      y = height - 130;
      textSize(30); 
      String yd = "You Died!";
      String sc = ("Score = ");
      sc += score;
      text(yd, width/2-70, height/2);
      text(sc, width/2-70, height/2 + 50);
      score = 0;
      pause = true;
      xInc = 5;
    } else {
      pause = false;
    }
  }

  void show() {
    if (shoot == true) {
      image(sht, width/2, y);
      y = y - 20;
    }
  }
}