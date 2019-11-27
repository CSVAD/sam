class ULine {
  ArrayList<PVector> vertices = new ArrayList<PVector>();
  int verticesNb = 0;
  int animationIndex = 0;
  float strWeight = 5;
  color str = color(0);
  float increment = 1;
  boolean modeLine = false;
  float strokeW = 1;
  float frequency = 300;
  float duration = 0.0;


  ULine() {
  
  }

  void addVertex(PVector point) {
    vertices.add(point);
    verticesNb++;
    strWeight+=0.1;

    if (vertices.size() > 1) {
      duration += dist(point.x, point.y, point.z, vertices.get(verticesNb-2).x, vertices.get(verticesNb-2).y, vertices.get(verticesNb-2).z);
      //println(duration);
    }
  }

  void display() {
    beginShape();

    if (animate) {
      if (animationIndex == 0) {
        //play();
      }
      for (int i = 0; i < animationIndex; i++) {
        strokeW = strWeight*abs(sin(radians(i)+1));
        strokeWeight(strokeW);
        play(i);
        //stroke(str);
        //stroke(color(255*abs(cos(0.5*radians(i))), 100*abs(sin(0.1*radians(i))), 0));
        //stroke(color(255*abs(cos(0.5*radians(i)))));
        if (modeLine) {
          stroke(color(255*abs(cos(0.5*radians(i))), 100*abs(sin(0.1*radians(i))), 0));
        } else {
          stroke(color(255*abs(cos(0.5*radians(i)))));
        }
        noFill();
        vertex(vertices.get(i).x, vertices.get(i).y, vertices.get(i).z);
      }

      animationIndex += increment;
      if (animationIndex > verticesNb || animationIndex < 0) {
        increment = -increment;
        animationIndex += increment;
      }
    } else {
      for (int i = 0; i < vertices.size(); i++) {
        strokeWeight(strWeight*abs(sin(radians(i)+1)));
        //stroke(str);
        //stroke(color(255*abs(cos(0.5*radians(i)))));

        if (modeLine) {
          stroke(color(255*abs(cos(0.5*radians(i))), 100*abs(sin(0.1*radians(i))), 0));
        } else {
          stroke(color(255*abs(cos(0.5*radians(i)))));
        }
        noFill();
        vertex(vertices.get(i).x, vertices.get(i).y, vertices.get(i).z);
      }
    }
    endShape();
  }


  void setColor(color pen) {
    str = pen;
  }

  void play(int index) {
    sendOsc("/amAmp", 3*strokeW+1);
    sendOsc("/amGain", map(index, 0, verticesNb, 40, 100));
    //out.playNote( 0.0, _duration, this);
  }
}
