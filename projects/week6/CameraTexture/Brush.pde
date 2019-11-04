class Brush {
  PVector pos = new PVector(width/2, height/2);
  int size = 100;
  PImage tmp;
  int bite = 32;

  Brush() {
  }


  void display() {
    noFill();
    stroke(255, 0, 0);
    //ellipse(pos.x, pos.y, size - 40, size -40);
  }


  void moveBrush(float x, float y) {
    //pos = new PVector(pos.x + x, pos.y + y);
    pos = new PVector(mouseX, mouseY);
  }

  void drawCapture(PImage vid) {
    bite = bit;
    if (pos.x > size/2 && pos.x < width-size/2 && pos.y > size/2 && pos.y < height-size/2) {
      vid.loadPixels();
      tmp = new PImage(size, size);
      tmp.loadPixels();

      for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
          //println("i: " + (int)pos.x + i);
          // println("i: " + (int)pos.y + j);
          //if (dist(pos.x, pos.y, pos.x+i-size/2, pos.y+j-size/2) < size/2){
          //tint(255);
          tmp.pixels[i + size*j] = vid.pixels[((int)pos.x + i -size/2) + width*((int)pos.y + j - size/2)];
          int red =  (int)(red(tmp.pixels[i + size*j])/bite)*bite;
          int blue =  (int)(blue(tmp.pixels[i + size*j])/bite)*bite;
          int green =  (int)(green(tmp.pixels[i + size*j])/bite)*bite;
          tmp.pixels[i + size*j] = color(red, green, blue);

          // }
          //else{
          // tint(0);
          // tmp.pixels[i + size*j] = color(0,0);
          //}
          //tmp.pixels[i + size*j] = vid.pixels[(int)pos.x + vid.width*(int)(height/4)];
          //tmp.pixels[i + size*j] = color(red(tmp.pixels[i + size*j]), green(tmp.pixels[i + size*j]), blue(tmp.pixels[i + size*j]), 0);// map(dist(i,j,size/2,size/2), 0, 50, 255, 0));
          //println(constrain(map(dist(i, j, size/2, size/2), 0, 50, 255, 0), 0, 255));
        }
      }

      tmp.updatePixels();
      image(tmp, pos.x - size/2, pos.y - size/2);
    }
  }
}
