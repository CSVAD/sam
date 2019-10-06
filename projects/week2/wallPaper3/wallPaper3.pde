int[] patternA = {0, 90, 180, 270};
int[] patternB = {45, 90, 135, 180};

void setup() {
  size(800, 800);
  background(255);
  for (int i = 0; i < 12; i++) {
    for (int j= 0; j < 12; j++) {
      drawSeed2(i, j, cos(0.25*j*PI));
    }
  }


  for (int i = 0; i < 8; i++) {
    for (int j= 0; j < 8; j++) {
      drawSeed(i, j, cos(0.25*j*PI));
    }
  }

  for (int i = 0; i < 12; i++) {
    for (int j= 0; j < 12; j++) {
      drawSeed3(i, j, cos(0.25*j*PI));
    }
  }
}

void drawSeed(int i, int j, float r) {
  pushMatrix();
  translate(100*i, 100*j);
  fill(255);
  //stroke(0);
  //rect(0, 0, 100, 100);

  noStroke();
  fill(255, 0, 0);
  rect(0, 0, 100/4, 100/4);

  //fill(random(255), 100);

  ellipseMode(CORNER);
  //ellipse(0, 0, 100, 100);
  rotate(r);
  rect(0, 0, 50, 20);
  noFill();
  popMatrix();
}


void drawSeed2(int i, int j, float r) {
  pushMatrix();
  translate(80*i, 80*j);
  //fill(255);
  //stroke(0);
  //rect(0, 0, 120, 120);

  noStroke();
  fill(255, 255, 0);
  rect(0, 0, 80, 30);

  //fill(random(255), 100);

  //ellipseMode(CORNER);
  //ellipse(0, 0, 100, 100);
  rotate(r);
  rect(0, 0, 20, 80);
  noFill();
  popMatrix();
}


void drawSeed3(int i, int j, float r) {
  pushMatrix();
  translate(150*i, 150*j);
  //fill(255);
  //stroke(0);
  //rect(0, 0, 120, 120);

  noStroke();
  fill(0, 0, 255);
 // rect(0, 0, 80, 30);

  //fill(random(255), 100);

  //ellipseMode(CORNER);
  rotate(r);
  //rect(0, 0, 20, 80);
    ellipse(0, 0, 20, 15);

  noFill();
  popMatrix();
}
