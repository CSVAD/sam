class Pix {
  float col ;
  float size = sizeTot;
  PVector pos;
  float speed = 10;
  PVector initialPos;


  Pix(float _col, float _x, float _y) {
    col = _col;
    pos = new PVector(_x, _y);
    initialPos = new PVector(_x, _y);
  }

  void display() {
    noStroke();
    fill(col, 50);
    /* if (col == 0) {
     //println("im white");
     }*/
    rect(pos.x, pos.y, sizeTot, sizeTot);
  }

  void move() {
    pos.x += speed*random(-0.1, 0.1);
    pos.y += speed*random(-0.1, 0.1);
  }

  void resetPos() {
    pos.x = initialPos.x;
    pos.y = initialPos.y;
  }

  PVector getPos() {
    return pos;
  }
  
  void changeCol(float _col){
    col = _col;
  }
}
