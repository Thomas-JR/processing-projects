public class Slider {
  private static final int SLIDER_MIN = 1;
  private static final int SLIDER_MAX= 15;
  
  private int weight = SLIDER_MIN;
  private int sliderRadius;
  private int verticalRatio;
  private boolean sliderSelected = false;
  private String name;

  public Slider(String name, int sliderRadius, int verticalRatio) {
    this.name = name;
    this.sliderRadius = sliderRadius;
    this.verticalRatio = verticalRatio;
  }

  public void update() {
    displaySlider();
    if (sliderSelected) {
      updateSlider();
    }
  }

  private void displaySlider() {
    rectMode(CENTER);
    fill(0);
    stroke(255);
    strokeWeight(2);
    rect(width/2, sliderRadius*verticalRatio, width/2, sliderRadius, 5);
    textSize(16);
    textAlign(LEFT, CENTER);
    text(name + " Weight = " + weight, width/80, sliderRadius*verticalRatio);
    textAlign(CENTER, CENTER);
    fill(200);
    noStroke();
    ellipse(map(weight, SLIDER_MIN, SLIDER_MAX, width/4, width*3/4), sliderRadius*verticalRatio, sliderRadius*2, sliderRadius*2);
  }

  private void updateSlider() {
    weight = int(constrain(map(mouseX, width/4, width*3/4, SLIDER_MIN, SLIDER_MAX), SLIDER_MIN, SLIDER_MAX));
    if (!mousePressed) {
      sliderSelected = false;
    }
  }

  public boolean collide() {
    if (dist(mouseX, mouseY, map(weight, SLIDER_MIN, SLIDER_MAX, width/4, width*3/4), sliderRadius*verticalRatio) < sliderRadius) {
      sliderSelected = true;
      return true;
    }
    return false;
  }
}
