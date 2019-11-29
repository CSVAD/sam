class ULineB1 extends ULine {
  ArrayList<PVector> vertices = new ArrayList<PVector>();
  ArrayList<Float> strokes = new ArrayList<Float>();

  int verticesNb = 0;
  int animationIndex = 0;
  int animationIndex2 = 0;
  float strWeight = 5;
  color str = color(0);
  float increment = 1;
  boolean forward = true;
  boolean modeLine = false;
  // for Instrument
  Oscil wave;
  Line  ampEnv;
  float frequency = 300;
  float duration = 0.0;


  ULineB1() {
    wave   = new Oscil( frequency, 0, Waves.SINE );
    ampEnv = new Line();
    ampEnv.patch( wave.amplitude );
  }

  void addVertex(PVector point) {
    vertices.add(point);
    if (drawingMode) {
      strokes.add(tablet.getPressure()*tablet.getPressure()*100);
    }
    //println(tablet.getPressure()*100);

    verticesNb++;
    strWeight+=0.1;

    if (vertices.size() > 1) {
      duration += dist(point.x, point.y, point.z, vertices.get(verticesNb-2).x, vertices.get(verticesNb-2).y, vertices.get(verticesNb-2).z);
      //println(duration);
    }
  }

  void display() {
    beginShape();

    //animation
    if (animate) {
      /*if (animationIndex == 1) {
       noteOff();
       //play(2*(verticesNb - 2)/frameRate);
       }*/
      for (int i = 0 + animationIndex2; i < animationIndex; i++) {
        //if (forward) {
        float strokeW = strWeight*abs(sin(radians(i)+1));
        //} else {
        //float strokeW = strWeight*abs(sin(radians(i)+1));
        // }

        if (drawingMode) {
          strokeWeight(strokes.get(i));
        } else {
          strokeWeight(strokeW);
        }
        //println(i);
        if (forward) {
          wave.setFrequency(animationIndex*50.0+20.0);
        } else {
          wave.setFrequency((verticesNb - animationIndex2)*50.0+20.0);
        }



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

      play(1/frameRate);

      if (forward) {
        animationIndex += increment;

        if (animationIndex > verticesNb) {
          forward = false;
          animationIndex2 = 0;
          animationIndex -= 1;
        }
      }

      if (!forward) {

        animationIndex2 += increment;

        if (animationIndex2 > verticesNb) {
          if (doneDrawing) {
            alive = false;
          }
          forward = true;
          animationIndex = 0;
          animationIndex2 = 0;
        }
      }

      //println(animationIndex);
      /* if (animationIndex > verticesNb || animationIndex < 0) {
       //println(animationIndex);
       increment = -increment;
       if (animationIndex > verticesNb){
       animationIndex = verticesNb;
       } else {
       animationIndex = 0;
       println("yooo " + animationIndex);
       
       }*/

      if (animationIndex < verticesNb) {
        //animationIndex += increment;
      }
    } else {
      // when tracing the first time
      for (int i = 0; i < vertices.size(); i++) {
        //float strokeW = strWeight*tablet.getPressure();
        if (drawingMode) {
          strokeWeight(strokes.get(i));
        } else {
          strokeWeight(strWeight*abs(sin(radians(i)+1)));
        }
        //strokeWeight(strWeight*abs(sin(radians(i)+1)));
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

  void play(float _duration) {
    out.playNote( 0.0, _duration, this);
  }

  void noteOn( float _duration )
  {
    // start the amplitude envelope
    ampEnv.activate( _duration, 0.5f, 0 );
    // attach the oscil to the output so it makes sound
    wave.patch( out );
  }

  // this is called by the sequencer when the instrument should
  // stop making sound
  void noteOff()
  {
    wave.unpatch( out );
  }
}
