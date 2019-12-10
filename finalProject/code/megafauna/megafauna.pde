/** MEGAFAUNA
 ** 
 ** Author: Sam Bourgault
 ** Date: Dec 2, 2019
 **
 ** Description: sound drawing tools. 
 ** exploring the relationship between drawing gesture and sound.
 **
 **/
import codeanticode.tablet.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Tablet tablet;
float pressure = 0.0;

// true for tablet, false for mouse
boolean drawingMode = true;
UTimer ut;

Minim minim;
AudioOutput out;

// arraylist of shapes, every new shape extends ULine.
ArrayList<ULine> shapes = new ArrayList<ULine>();
ULine shape;

// Rotate the world
boolean rotate = true;
float rotateY = 0;
float rotateXZ = 0;

// what instrument is being drawn
int insMode = 0;
boolean backMode = false;

void setup() {
  fullScreen(P3D);
//size(1600, 1000, P3D);
  //size(1800, 1000, P3D);
  background(255);
  
    tablet = new Tablet(this);


  // minim objects
  minim = new Minim(this);
  out = minim.getLineOut();

  //smooth();
  perspective(PI/3.0, float(width)/float(height), 10, 10000);
}

void draw() {
  /*if (millis() % 100 == 0) {
   backMode = !backMode;
   }*/

  // get pressure value
  //pressure = tablet.getPressure();
  pressure = lerp(pressure, tablet.getPressure(), 0.1);
  //pressure = tablet.getPressure();
  //pressure = 1;
  // println(pressure);


  if (!backMode) {
    background(0);
  } else {
    background(255);
  }
  stroke(255);
  strokeWeight(2);

  // world manipulation
  pushMatrix();
  translate(width/2, height/2);
  rotateX(rotateXZ);
  rotateY(rotateY);

  if (ut != null) {
    if (ut.vertices.size()!=0) {
      ut.display();
    }
    if (insMode != 0) {
      ut.metronome();
    }
  }

  // display the shapes
  if (!shapes.isEmpty()) {
    for (int i = 0; i < shapes.size(); i++) {
      //if (shapes.get(i).vertices.size()!=0) {
      shapes.get(i).display();
      //}
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
  } else if (insMode == 4) {
    shape = new ULine3();
  } else if (insMode == 5) {
    shape = new ULineFM();
  } else if (insMode == 6) {
    shape = new ULine4();
  } else if (insMode == 0) {
    ut = new UTimer();
    //ut = shape;
  }

  pressure = tablet.getPressure();

  if (insMode != 0) {
    shapes.add(shape);
  }
}

void mouseDragged() {
  // add vertex to the shape being drawn
  pushMatrix();
  if (insMode != 0) {
    shape.addVertex(new PVector((mouseX -width/2)*cos(rotateY), mouseY - height/2, (mouseX -width/2)*sin(rotateY)));
  } else {
    ut.addVertex(new PVector((mouseX -width/2)*cos(rotateY), mouseY - height/2, (mouseX -width/2)*sin(rotateY)));
  }
  popMatrix();
}

void mouseReleased() {
  // finish the shape
  if (insMode != 0) {
    shape.finished();
  } else {
    ut.finished();
    insMode++;
  }
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
