String pi = "314159265358979323846264338327950288419716939937510582097494459230781640628620899862803482534211706798214808651328230664709384460955058223172535940812848111745028410270193852110555964462294895493038196442881097566593344612847564823378678316527120190914564856692346034861045432664821";
int count = 0;


int[] digitCount = new int[10];
float[] colours = new float[10];

void setup() {
  size(800, 800);
  frameRate(10);
  colorMode(HSB);
  for (int i = 0; i < 10; i++) {
    colours[i] = 255/10*i;
  }
}

void draw() {
  translate(width/2, height/2);
  background(255);
  println();
  if (count < pi.length()) {
    digitCount[pi.charAt(count) - 48]++;
  }
  if (count > 0) {
    int total = 0;
    for (int i = 0; i < 10; i++) {
      fill(colours[i], 255, 255);
      if (i > 0) {
        arc(0, 0, 700, 700, (2*PI/count)*total, (2*PI/count)*(total+digitCount[i]));
      } else {
        arc(0, 0, 700, 700, 0, (2*PI/count)*digitCount[i]);
      }
      if (digitCount[i] > 0) {
        fill(0);
        text(str(i), cos(((2*PI/count)*total+(2*PI/count)*(total+digitCount[i]))/2)*300, sin(((2*PI/count)*total+(2*PI/count)*(total+digitCount[i]))/2)*300);
      }
      total += digitCount[i];
    }
  }

  count++;
}
