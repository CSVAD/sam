import controlP5.*;


ControlP5 cp5;

float spread = 10;
float previousSpread = 10;
float size = 20;
float x, y, z;
float offsetX = 10;
float offsetY = 10;
float offsetZ = 10;
float increment = 0.1;
int maxX = 20;
float angle =0;
float incrementOffset = 0.005;
float boxSize = 800;


float opacity = 255;
float speedPix = 0.5;
float sizePix = 9;
float sli0 = 1;
boolean erase = true;
boolean dimX, dimY, dimZ = false;
long noiseSeed = 0;
boolean rot = true;
boolean colFormat = true;

ArrayList<Pix> pixs = new ArrayList<Pix>();

void setup() {
  cp5 = new ControlP5(this);

  //size(600, 600, P3D);
  fullScreen(P3D);

  background(255);
  for (int i = 0; i < maxX; i++) {
    for (int j = 0; j < maxX; j++) {
      for (int k = 0; k < maxX; k++) {
        pixs.add(new Pix(0, (i-maxX/2)*spread, (j-maxX/2)*spread, k*spread - spread*maxX/2, new PVector(i, j, k)));
      }
    }
  }

  cp5.addSlider("spread")
    .setPosition(40, 30)
    .setRange(1, 25)
    .setColorActive(color(150))
    .setColorForeground(color(100))
    .setColorBackground(color(50))
    .setColorLabel(150);
  ;

  cp5.addSlider("opacity")
    .setPosition(40, 90)
    .setRange(0, 255)
    .setColorActive(color(150))
    .setColorForeground(color(100))
    .setColorBackground(color(50))
    .setColorLabel(150);
  ;

  cp5.addSlider("speedPix")
    .setPosition(40, 70)
    .setRange(0.1, 5)
    .setColorActive(color(150))
    .setColorForeground(color(100))
    .setColorBackground(color(50))
    .setColorLabel(150);
  ;

  cp5.addSlider("sizePix")
    .setPosition(40, 50)
    .setRange(1, 20)
    .setColorActive(color(150))
    .setColorForeground(color(100))
    .setColorBackground(color(50))
    .setColorLabel(150);
  ;

  cp5.addSlider("noiseSeed")
    .setPosition(40, 110)
    .setRange(0, 255)
    .setColorActive(color(150))
    .setColorForeground(color(100))
    .setColorBackground(color(50))
    .setColorLabel(150);
  ;


  // create a toggle
  cp5.addToggle("erase")
    .setPosition(40, 130)
    .setSize(50, 20)
    .setColorActive(color(150))
    .setColorForeground(color(100))
    .setColorBackground(color(50))
    .setColorLabel(150);
  ;

  // create a toggle
  cp5.addToggle("dimX")
    .setPosition(40, 170)
    .setSize(50, 20)
    .setColorActive(color(150))
    .setColorForeground(color(100))
    .setColorBackground(color(50))
    .setColorLabel(150);
  ;
  // create a toggle
  cp5.addToggle("dimY")
    .setPosition(40, 210)
    .setSize(50, 20)
    .setColorActive(color(150))
    .setColorForeground(color(100))
    .setColorBackground(color(50))
    .setColorLabel(150);
  ;

  // create a toggle
  cp5.addToggle("dimZ")
    .setPosition(40, 250)
    .setSize(50, 20)
    .setColorActive(color(150))
    .setColorForeground(color(100))
    .setColorBackground(color(50))
    .setColorLabel(150);
  ;


  // create a toggle
  cp5.addToggle("rot")
    .setPosition(40, 290)
    .setSize(50, 20)
    .setColorActive(color(150))
    .setColorForeground(color(100))
    .setColorBackground(color(50))
    .setColorLabel(150);
  ;
  
    // create a toggle
  cp5.addToggle("colFormat")
    .setPosition(40, 330)
    .setSize(50, 20)
    .setColorActive(color(150))
    .setColorForeground(color(100))
    .setColorBackground(color(50))
    .setColorLabel(150);
  ;
}

void draw() {
  if (erase) {
    background(255);
  }

  noiseSeed(noiseSeed);

  pushMatrix();
  translate(width/2, height/2, 0);
  rotateY(angle);
  for (int i = 0; i < maxX; i++) {
    for (int j = 0; j < maxX; j++) {
      for (int k = 0; k < maxX; k++) {
        // pushMatrix();
        noStroke();
        pixs.get(i+maxX*j+maxX*maxX*k).changeCol(map(noise(i/offsetX+increment, j/offsetY + increment, k/offsetZ+increment), 0., 1., 0., 255.));
        // println(noise(i*offset, j*offset, k*offset));
        //translate((i-maxX/2)*spread, (j-maxX/2)*spread, k*spread - spread*maxX/2);
        //box(size);
        //  popMatrix();
        pixs.get(i+maxX*j+maxX*maxX*k).display();
        pixs.get(i+maxX*j+maxX*maxX*k).move();
        pixs.get(i+maxX*j+maxX*maxX*k).changeSize(sizePix);
        //offsetZ += increment;
      }
    }
  }

  for (int i = 0; i < pixs.size(); i++) {
    // pixs.get(i).display();
  }

  if (previousSpread != spread) {
    changeSpread();
  }


  if (frameCount % 100 == 0) {
    //println("yooo");
    if (random(1) > 0.5) {
      incrementOffset = -incrementOffset;
    } 
  }
  
  increment += incrementOffset;


  if (rot) {
    angle+=0.001;
  }
  popMatrix();

  previousSpread = spread;
}

void changeSpread() {
  for (int i = 0; i < maxX; i++) {
    for (int j = 0; j < maxX; j++) {
      for (int k = 0; k < maxX; k++) {
        pixs.get(i+maxX*j+maxX*maxX*k).adjustSpread(new PVector((i-maxX/2)*spread, (j-maxX/2)*spread, k*spread - spread*maxX/2));
      }
    }
  }
}
