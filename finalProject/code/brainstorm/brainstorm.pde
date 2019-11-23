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

import drawing.library.*;
import processing.pdf.*;

DrawingManager drawingManager;
Line shape;
Line shape2;
ArrayList<Line> shapes = new ArrayList<Line>();

boolean animate = false;
boolean rotate = false;
color penColor = color(0, 0, 0);

// world
float rotateY = 0;
float rotateXZ = 0;
// false is color, true is 
boolean mode = true;

void setup() {
  fullScreen(P3D);
  //size(800, 800, P3D);
  background(255);
  smooth();
  drawingManager = new DrawingManager(this);
  perspective(PI/3.0, float(width)/float(height), 10, 10000);
}

void draw() {
  background(50);
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
    println(shapes.size());
    //shape.addDelta(0,0);
    //shape.renderTransformation(this);
  }

  popMatrix();


  if (rotate) {
    rotateY += radians(0.05);
  }
}

void keyPressed() {
  if (key == ' ') {
    drawingManager.savePDF();
  }
  if (key == 'c') {
    drawingManager.clear();
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
    shape.modeLine = mode;
  }


  // world rotation keys 
  if (key == 'a') {
    rotateY -= radians(5);
  }
  if (key == 'd') {
    rotateY += radians(5);
  }


  if (key == 'w') {
    rotateXZ += radians(5);
  }
  if (key == 's') {
    rotateXZ -= radians(5);
  }
}

void mousePressed() {
  //shape = drawingManager.addShape(); 
  shape = new Line();
  shapes.add(shape);
}

void mouseDragged() {
  pushMatrix();
  //translate(width/2, height/2);
  //drawingManager.stroke(0, 0, 0);
  //float distance = dist();
  shape.addVertex(new PVector((mouseX -width/2)*cos(rotateY), mouseY - height/2, (mouseX -width/2)*sin(rotateY)));
  popMatrix();
}
