/** MEGAFAUNA
 ** 
 ** Author: Sam Bourgault
 ** Date: Dec 2, 2019
 **
 ** Description: sound drawing tools. 
 ** exploring the relationship between drawing gesture and sound.
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
// true for tablet, false for mouse
boolean drawingMode = false;

Minim minim;
AudioOutput out;

// arraylist of shapes, every new shape extends ULine.
ArrayList<ULine> shapes = new ArrayList<ULine>();
ULine shape;

// Rotate the world
boolean rotate = false;
float rotateY = 0;
float rotateXZ = 0;

// what instrument is being drawn
int insMode = 1;

void setup() {
  //fullScreen(P3D);
  size(800, 800, P3D);
  background(0);

  // minim objects
  minim = new Minim(this);
  out = minim.getLineOut();

  tablet = new Tablet(this);

  //smooth();
  perspective(PI/3.0, float(width)/float(height), 10, 10000);
}

void draw() {
  background(0);
  stroke(255);
  strokeWeight(2);

  // world manipulation
  pushMatrix();
  translate(width/2, height/2);
  rotateX(rotateXZ);
  rotateY(rotateY);

  // display the shapes
  if (!shapes.isEmpty()) {
    for (int i = 0; i < shapes.size(); i++) {
      shapes.get(i).display();
    }
  }
  popMatrix();

  // increase rotation
  if (rotate) {
    rotateY += radians(0.05);
  }

  // check life of shapes
  checkLife(shapes);
}

void keyPressed() {

  // change the instrument mode
  if (key == 'a') {
    insMode = 1;
  }
  if (key == 's') {
    insMode = 2;
  }
  if (key == 'd') {
    insMode = 3;
  }
  if (key == 'f') {
    insMode = 4;
  }
  if (key == 'g') {
    insMode = 5;
  }
  if (key == 'h') {
    insMode = 6;
  }

  //clear the arraylist and stop sounds
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

  // start rotating the world
  if (key == '2') {
    rotate = !rotate;
  }
}

void mousePressed() {
  // draw shape and add to arraylist
  if (insMode == 1) {
    shape = new UClap();
  } else if (insMode == 3) {
    shape = new USampler();
  } else if (insMode == 2) {
    shape = new UAddSynth();
  } /*else if (insMode == 4) {
    shape = new ULineFM();
  } else if (insMode == 5) {
    shape = new ULineC();
  } else if (insMode == 6) {
    shape = new ULineAS();
  }*/
  shapes.add(shape);
}

void mouseDragged() {
  // add vertex to the shape being drawn
  pushMatrix();
  shape.addVertex(new PVector((mouseX -width/2)*cos(rotateY), mouseY - height/2, (mouseX -width/2)*sin(rotateY)));
  popMatrix();
}

void mouseReleased() {
  // finish the shape
  shape.finished();
}

// check life of the shape and remove from arraylist if dead
void checkLife(ArrayList<ULine> al) {
  for (int i = 0; i < al.size(); i++) {
    if (!al.get(i).checkAlive()) {
      al.get(i).noteOff();
      al.remove(i);
    }
  }
}
