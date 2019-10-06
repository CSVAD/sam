/* exploration on recursion
 Using the Nature of Code
 */

PImage skin;
float l = 400; 

int t = 0;

void setup() {
  size(600, 600);
  background(255);
  skin = loadImage("skin4.png");
  //drawCircle(width/2, height/2, 200);
  //branch();
  cantor(width/2 - l/2, height/6, l);
  t = 0;
}

void drawCircle(float x, float y, float radius) {
  ellipse(x, y, radius, radius);
  /*pushMatrix();
   //tint(GRAY);
   tint(230, 230, 255, 150);
   imageMode(CENTER);
   image(skin, x, y, radius, radius);
   popMatrix();
   */
  if (radius > 50) {
    fill(200, 255, 200, 100);
    radius *= 0.75f;

    //x *= 1.05;
    //The drawCircle() function is calling itself recursively.
    drawCircle(x + radius/2, y, radius);
    // drawCircle(x - radius/2, y, radius);

    // drawCircle(x, y+ radius/2, radius);
    //drawCircle(x, y- radius/2, radius);
    //drawCircle(width/2 - (x-width/2), y, radius);
    drawCircle(x, y, radius);
    drawCircle(x, y- radius/2, radius);
  }
}

void cantor(float x, float y, float len) {
  strokeWeight(20);
  strokeCap(SQUARE);
  stroke(0);
  line(x, y, x+len, y);

  //fill(0, 50);
  //rectMode(CORNERS);
  //rect(x,y,x+len, 10);
  //fill(255,0,0, 100);

  pushMatrix();
  rotate(cos(x - width/2));
  textSize(100);  
  fill(0);
  text("YOU", x, y);
  fill(255);
  textSize(104);  
  text("YOU", x, y);

  popMatrix();

  /*tint(230, 230, 255, 50);
   pushMatrix();
   imageMode(CENTER);
   translate(x,y);
   rotate(radians((int)random(-4,4) * 90));
   image(skin, 0,0, len, len);
   popMatrix();*/

  // drawCircle(x,y,len);

  if (len > 1) {
    cantor(x, y + 50, len /2.2);
    cantor(x + len - len/2.2, y  + 50, len /2.2);
    /*cantor(x + len - len/2, y + 20, len /2);
     cantor(x + len - len/2, y + 100, len /2);*/
  }
}

void drawSeed(int i, int j, float r) {
  pushMatrix();
  translate(100*i, 100*j);
  fill(255);
  //stroke(0);
  rect(0, 0, 100, 100);

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

void branch() {
  rotate(radians((int)random(-4, 4) * 90));
  image(skin, 0, 0, 100, 100);
  //Draw the branch itself.
  line(0, 0, 0, -100);

  //Translate to the end.
  translate(0, -100);

  if (t < 2) {
    pushMatrix();
    //Rotate to the right and branch again.
    rotate(PI/6);
    branch();
    popMatrix();

    pushMatrix();
    //Rotate to the left and branch again.
    rotate(-PI/6);
    branch();
    popMatrix();
  }
  t++;
}
