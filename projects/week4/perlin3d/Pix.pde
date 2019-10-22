class Pix {
  float col ;
  float size = 5;
  PVector pos;
  float speed = 0.5;
  PVector index;


  Pix(float _col, float _x, float _y, float _z, PVector _index) {
    col = _col;
    pos = new PVector(_x, _y, _z);
    index = _index;
  }

  void display() {
    pushMatrix();
    noStroke();
    // allow for red and black and white graphics
    if (colFormat) {
      fill(col, 0, 0, opacity);
    } else {
      fill(col, opacity);
    }
    translate(pos.x, pos.y, pos.z);
    box(size);
    popMatrix();
  }

  void move() {
    speed = speedPix;
    float tmp = speed*(col/255 - 0.5);

    if (dimX) {
      pos.x += tmp;
      if (pos.x < -boxSize/2) {
        pos.x = boxSize/2;
      } else if (pos.x > boxSize/2) {
        pos.x = -boxSize/2;
      }
    }
    if (dimY) {
      pos.y += tmp;
      if (pos.y < -boxSize/2) {
        pos.y = boxSize/2;
      } else if (pos.y > boxSize/2) {
        pos.y = -boxSize/2;
      }
    }
    if (dimZ) {
      pos.z += tmp;
      if (pos.z < -boxSize/2) {
        pos.z = boxSize/2;
      } else if (pos.z > boxSize/2) {
        pos.z = -boxSize/2;
      }
    }
    //pos.z +=
  }

  void changeCol(float _col) {
    col = _col;
  }

  void changeSize(float _size) {
    size = _size;
  }

  void adjustSpread(PVector _pos) {
    pos = _pos;
  }
}
