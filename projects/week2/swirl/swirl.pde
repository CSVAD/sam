

void setup(){
  size(800, 800);
  background(255);
  drawSeed(0,0, 200);
}

void draw(){
  //background(255);
  //drawSeed(0,0, 200);

}

void drawSeed(float theta, float r, float size){
  float x = r*cos(radians(theta));
  float y = r*sin(radians(theta));
  noFill();
  //fill(theta * 10 % 255, 100);
  ellipse(x + width/2, y+width/2, size,size);
  
  if (r < width){
    drawSeed(r-10/(r+1), theta+1, size-2*mouseX/50);
  }
}
