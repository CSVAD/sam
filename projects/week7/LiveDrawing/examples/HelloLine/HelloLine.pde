/** 
 * LiveDrawing for Processing by sam bourgault
 * Place: Santa-Barbara, CA
 * Date: Nov 9, 2019
 * Website: soon on sambourgault.com/LiveDrawing
 * 
 * HelloLine: drawing the ONE default line of LDfP.
 * 
 **/

import live.drawing.*;

LiveDrawingManager lvd;
LDLine line;

void setup() {
  size(500,500, P3D);
  background(127);
  lvd = new LiveDrawingManager(this);
  line = new LDLine(this);
}

void draw(){
  line.display(false);
}

void mouseDragged(){
  line.addVertex(new PVector(mouseX,mouseY));
}
