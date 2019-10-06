void setup() {
  size(800, 800);
  background(0);

fill(255,0,0);
  drawSeed3(450, 600, 5, 20, 80, 20, 0 );

  fill(220);

  //  fill(0,150,0);
  drawSeed3(200, 300, 40, 20, 130, 50, 20 );

  fill(255);

  drawSeed1(100, -150, 300, 400, 500, 500 );

  fill(200);

  // fill(255, 255, 0);
  drawSeed2(100, 600, 200, 300, 300, 600 );

  fill(255);

  // fill(255);
  drawSeed1(100, 100, 20, 150, 200, 300);

  // fill(255, 0, 0);
  drawSeed1(200, -200, 10, 300, 400, 100);

  fill(220);

  // fill(0, 0, 255);
  drawSeed3(-200, -100, 40, 60, 100, 400, 20 );


  // fill(255, 0, 255);
  drawSeed3(-300, -100, 300, 5, 120, 500, 20 );

  fill(200);
  drawSeed2(200, 100, 40, 100, 100, 400 );
  
  /*rotate(radians(20));
  fill(255);
  textSize(350);
  text("REGULAR", 200,200);*/
}



// QUADs 1
void drawSeed1(float x, float y, float h, float w, float spaceX, float spaceY) {
  pushMatrix();
  rotate(radians(20));
  translate(x, y);

  quad(0, 0, h, h, h+w, h, w, 0);
  popMatrix();

  if (x < width) {
    drawSeed1(x + spaceX, y, h, w, spaceX, spaceY);
  }

  if (y < height) {
    drawSeed1(x, y + spaceY, h, w, spaceX, spaceY);
  }
}


// QUADs 2
void drawSeed2(float x, float y, float h, float w, float spaceX, float spaceY) {
  pushMatrix();
  rotate(radians(20));
  translate(x, y);

  quad(0, 0, h, -h, h+w, -h, w, 0);
  popMatrix();

  if (x < width) {
    drawSeed2(x + spaceX, y, h, w/2, spaceX, spaceY);
  }

  if (y < height) {
    drawSeed2(x, y + spaceY, h, w, spaceX, spaceY);
  }
}

void drawSeed3(float x, float y, float h, float w, float spaceX, float spaceY, float rot) {
  pushMatrix();
  rotate(radians(rot));
  translate(x, y);

  //quad(0, 0, h, h, h+w, h, w, 0);
  rect(0, 0, w, h);
  popMatrix();

  if (x < width) {
    drawSeed3(x + spaceX, y, h, w, spaceX, spaceY, rot);
  }

  if (y < height) {
    drawSeed3(x, y + spaceY, h, w, spaceX, spaceY, rot);
  }
}
