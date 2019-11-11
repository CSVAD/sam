/** 
 * LiveDrawing for Processing by sam bourgault
 * Place: Santa-Barbara, CA
 * Date: Nov 9, 2019
 * Website: soon on sambourgault.com/LiveDrawing
 * 
 * LiveDrawing: live drawing using the LiveDrawingManager.
 * 
 **/

import live.drawing.*;

LiveDrawingManager lvd;

boolean animate = false;
boolean rotate = false;

void setup() {
  size(500, 500, P3D);
  background(127);
  lvd = new LiveDrawingManager(this);
  lvd.setAnimationState(animate);
  lvd.setAnimationState(rotate);
  perspective(PI/3.0, float(width)/float(height), 10, 10000);
}

void draw() {
  background(0);
  lvd.activate();
}

void keyPressed() {
  /*if (key == ' ') {
   drawingManager.savePDF();
   }*/
  if (key == 'c') {
    lvd.clear();
  }
  if (key == '1') {
    animate = !animate;
    lvd.setAnimationState(animate);
  }
  if (key == '2') {
    rotate = !rotate;
    lvd.setRotationState(rotate);
  }


  //  if (key == '3') {
  //    mode = !mode;
  //    shape.modeLine = mode;
  //  }
}

void mousePressed() {
  lvd.addLine();
}

void mouseDragged() {
  lvd.extendLine();
}
