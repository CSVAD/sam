/**
 ** 
 ** Date: Nov 23, 2019
 ** Description: Starting from the example of week5, the drawing tool.
 **
 **/

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import codeanticode.tablet.*;

Tablet tablet;

Minim minim;
AudioOutput out;

ULine shape;
ArrayList<ULine> shapes = new ArrayList<ULine>();
//HashMap<Integer, ULine> shapes = new HashMap<Integer, ULine>();


boolean animate = false;
boolean rotate = false;
color penColor = color(0, 0, 0);

// world
float rotateY = 0;
float rotateXZ = 0;
// false is color, true is 
boolean mode = true;
int insMode = 1;
// true for tablet, false for mouse
boolean drawingMode = false;

void setup() {
  //fullScreen(P3D);
  size(800, 800, P3D);
  background(255);

  // minim objects
  minim = new Minim(this);
  out = minim.getLineOut();

  tablet = new Tablet(this);

  //smooth();
  perspective(PI/3.0, float(width)/float(height), 10, 10000);
}

void draw() {
  background(50);
  stroke(255);
  strokeWeight(2);
  /*line(width/2, 100, 0, width/2, 1000, 0);
   
   pushMatrix();
   translate(width/2, height/2);
   rectMode(CENTER);
   rotateY(rotateY);
   noFill();
   //translate(width/2, height/2, 0);
   //rotateX(radians(85));
   //ellipse(0,0, 1500, 1500);
   fill(255, 50);
   rect(0, 0, width, 5);
   rotateY(radians(45));
   rect(0, 0, width, 5);
   rotateY(radians(45));
   rect(0, 0, width, 5);
   popMatrix();*/

  pushMatrix();
  translate(width/2, height/2);
  rotateX(rotateXZ);
  rotateY(rotateY);
  // rotateX(rotateXZ);
  //rotateZ(rotateXZ*sin(rotateY)); 

  if (!shapes.isEmpty()) {
    for (int i = 0; i < shapes.size(); i++) {
      shapes.get(i).display();
    }
    //println(shapes.size());
    //shape.addDelta(0,0);
    //shape.renderTransformation(this);
  }

  popMatrix();


  if (rotate) {
    rotateY += radians(0.05);
  }

  checkLife(shapes);
}

void keyPressed() {
  if (key == 'a') {
    // drawingManager.savePDF();
    //shape.play(50.0);
    insMode = 1;
  }
  if (key == 's') {
    // drawingManager.savePDF();
    //shape.play(50.0);
    insMode = 2;
  }
  if (key == 'd') {
    // drawingManager.savePDF();
    //shape.play(50.0);
    insMode = 3;
  }
  if (key == 'f') {
    // drawingManager.savePDF();
    //shape.play(50.0);
    insMode = 4;
  }

  if (key == 'g') {
    // drawingManager.savePDF();
    //shape.play(50.0);
    insMode = 5;
  }


  if (key == 'h') {
    // drawingManager.savePDF();
    //shape.play(50.0);
    insMode = 6;
  }


  if (key == 'c') {
    // drawingManager.clear();
    for (int i = 0; i< shapes.size(); i++) {
      if (shapes.get(i).filePlayer != null) {
        println(shapes.get(i));
        shapes.get(i).filePlayer.pause();
      } else {
        shapes.get(i).noteOff();
      }
    }
    shapes.clear();
  }
  if (key == '1') {
    animate = !animate;
  }
  if (key == '2') {
    rotate = !rotate;
  }
  if (key == '3') {
    mode = !mode;
    //shape.modeLine = mode;
  }


  // world rotation keys 
  if (key == 'a') {
    //  rotateY -= radians(5);
  }
  if (key == 'd') {
    // rotateY += radians(5);
  }


  if (key == 'w') {
    // rotateXZ += radians(5);
  }
  if (key == 's') {
    // rotateXZ -= radians(5);
  }
}

void mousePressed() {
  //shape = drawingManager.addShape(); 
  if (insMode == 1) {
    shape = new ULineB1();
  } else if (insMode == 2) {
    shape = new ULineB2();
  } else if (insMode == 3) {
    shape = new USampler();
  } else if (insMode == 4) {
    shape = new ULineFM();
  } else if (insMode == 5) {
    shape = new ULineC();
  } else if (insMode == 6) {
    shape = new ULineAS();
  }

  shapes.add(shape);
}

void mouseDragged() {
  pushMatrix();
  //translate(width/2, height/2);
  //drawingManager.stroke(0, 0, 0);
  //float distance = dist();
  shape.addVertex(new PVector((mouseX -width/2)*cos(rotateY), mouseY - height/2, (mouseX -width/2)*sin(rotateY)));
  //println(new PVector((mouseX -width/2)*cos(rotateY), mouseY - height/2, (mouseX -width/2)*sin(rotateY)));
  popMatrix();
}

void mouseReleased() {
  //shape.play(2.0);
  shape.finished();
}

void checkLife(ArrayList<ULine> al) {
  for (int i = 0; i < al.size(); i++) {
    if (!al.get(i).checkAlive()) {
      al.get(i).noteOff();
      al.remove(i);
    }
  }
}
