import controlP5.*;

PImage img;
ArrayList<Pix> pixs = new ArrayList<Pix>();

Controller sli1;
Controller sli2;
Controller sli3;
Controller sli4;

float increment = 0.1;

float sizeTot = 1;
boolean resetValue = false;

ControlP5 cp5;

void setup() {
  size(600, 600, P3D);

  cp5 = new ControlP5(this);

  img = loadImage("canboy.png");
  image(img, 0, 0, 600, 600);
  loadPixels();
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      //println(red(pixels[i+width*j]));
      if (red(pixels[i+width*j]) == 0.) {
        pixs.add(new Pix(red(pixels[i+width*j]), i, j));
      }
    }
  }
  updatePixels();
  background(255);

  sli1 = cp5.addSlider("sizeTot")
    .setPosition(40, 30)
    .setRange(1, 10)
    ;


  sli1 = cp5.addButton("reset")
    .setPosition(40, 50)
    ;
}


void draw() {
  background(255, 20);
  /*if (resetValue) {
   for (int i = 0; i < pixs.size(); i++) {
   pixs.get(i).resetPos();
   }
   }*/


  for (int i = 0; i < pixs.size(); i++) {
    pixs.get(i).display();
    pixs.get(i).move();
    //pixs.get(i).changeCol(map(noise(pixs.get(i).getPos().x+increment, pixs.get(i).getPos().y + increment), 0., 1., 0., 255.));
  }

  increment+=0.005;
}

void reset() {
  for (int i = 0; i < pixs.size(); i++) {
    pixs.get(i).resetPos();
  }
}

void mousePressed(){
  for (int i = 0; i < pixs.size(); i++) {
    pixs.get(i).resetPos();
  }
}
