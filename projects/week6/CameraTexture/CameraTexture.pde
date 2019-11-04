// made by sam bourgault
// on nov 3 2019
// reveal camera output
// to make texture/color picker

import processing.video.*;
import controlP5.*;


Capture video;
Brush brush;
float speed = 0.5;
int bit = 32;
boolean newForeground = true;
int endI = 0;
int endJ = 0;
float[] posX = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
float[] ws = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
float[] posY= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
float[] hs= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

ControlP5 cp5;
RadioButton r1;

void setup() {

  cp5 = new ControlP5(this);
  r1 = cp5.addRadioButton("radioButton")
    .setPosition(50, 50)
    .setSize(20, 20)
    .setColorForeground(color(120))
    .setColorBackground(color(50))
    .setColorActive(color(255))
    .setColorLabel(color(255))
    .setItemsPerRow(5)
    .setSpacingColumn(30)
    .addItem("16", 1)
    .addItem("32", 2)
    .addItem("64", 4)
    .addItem("128", 8)
    ;


  size(1280, 780, P2D);
  background(0);
  video = new Capture(this, 1280, 780);
  video.start();

  brush = new Brush();
}

void draw() {
  pushMatrix();
  scale(-1, 1);
  // background(0);
  video.read();
  //video.resize(-100, 0);
  // image(video, 0, 0, width, height);
  popMatrix();

  //brush.drawCapture(video);
  //brush.display();
  brush.moveBrush(0, 0);

  //foreground();
}

void foreground() {
  fill(0);
  noStroke();

  if (newForeground) {
    newForeground = false;
    endI = (int)random(6) + 5;
    endJ = (int)random(6) + 5;


    for (int i = 0; i < endI; i++) {
      posX[i] = random(width);
      ws[i] = random(100)+10;
    }
    for (int j = 0; j < endJ; j++) {
      posY[j] = random(width);
      hs[j] = random(100)+10;
    }
  }
  for (int i = 0; i < endI; i++) {
    rect(posX[i], 0, ws[i], height);
  }

  for (int j = 0; j < endJ; j++) {
    rect(0, posY[j], width, hs[j]);
  }
}


/*void keyPressed() {
 if (key == 'w') {
 brush.moveBrush(0, -speed);
 } else if (key == 's') {
 brush.moveBrush(0, speed);
 } else if (key == 'd') {
 brush.moveBrush(speed, 0);
 } else if (key == 'a') {
 brush.moveBrush(-speed, 0);
 }
 }*/


void mouseDragged() {
  brush.drawCapture(video);
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(r1)) {
    bit=int(theEvent.getGroup().getValue()*16);
    //println(bit);
  }
}
