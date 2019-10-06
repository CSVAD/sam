/* exploration on grid

*/

PImage skin;

int[] patternA = {0, 90,180,270};
int[] patternB = {45,90,135,180};

void setup() {
  size(800, 800);
  background(255);
    skin = loadImage("skin5.png");
   // blendMode(LIGHTEST);



  for (int i = 0; i < 10; i++) {
    if(i%2 == 0){
      
    }
    
    for (int j= 0; j < 10; j++) {
      drawSeed(i, j, cos(0.25*j*PI));
      
    }
  }
}

void drawSeed(int i, int j, float r) {
  
  
  pushMatrix();
  translate(100*i, 100*j);
  fill(255);
  //stroke(0);
  rect(0, 0, 100, 100);
  
  noStroke();
  fill(255,0,0);
//  rect(0,0,100/4,100/4);
  
  //fill(random(255), 100);
  
  ellipseMode(CORNER);
  //ellipse(0, 0, 100, 100);
  rotate(r);
 // rect(0, 0, 50, 20);
  noFill();
  popMatrix();
  
  
  //tint(230, 230, 255, 255);
  pushMatrix();
  imageMode(CENTER);
  translate(100*i,100*j);
  rotate(radians((int)random(-9,9) * 45));
  //rotate(radians(45));
  image(skin, -10,0, 250, 250);
  popMatrix();
}
