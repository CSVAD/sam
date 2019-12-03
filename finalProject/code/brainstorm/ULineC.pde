class ULineC extends ULine {
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
  float freq = 0.0;

  PVector derivative = new PVector(0, 0, 0);
  PVector previousDerivative= new PVector(0, 0, 0);


  ULineC() {
    wave   = new Oscil( frequency, 0, Waves.randomNHarms( 10 ) );
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
    if (animateLine) {
      if (animationIndex == 1) {
        noteOff();
        play(2*(verticesNb - 1)/frameRate);
      }

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

        if (i > 0) {
          derivative = PVector.sub(vertices.get(i), vertices.get(i-1));
        }

        //println(i);
        if (forward) {
          //wave.setFrequency(animationIndex*50.0+20.0);
          if (i>1) {
            freq = map(PVector.angleBetween(derivative, previousDerivative), 0.f, 1f, 100.f, 1000.f); //lerp(angle, PVector.angleBetween(derivative, previousDerivative), 0.1);
            wave.setFrequency(lerp(wave.frequency.getLastValue(), freq, 0.2 ));
          } else {
            wave.setFrequency(0);
          }
        } else {
          //wave.setFrequency((verticesNb - animationIndex2)*50.0+20.0);
          
          if (verticesNb - animationIndex2 > 0) {
            //println(verticesNb - animationIndex2 );
            freq = map(PVector.angleBetween(derivative, previousDerivative), 0.f, 1f, 100.f, 1000.f); //lerp(angle, PVector.angleBetween(derivative, previousDerivative), 0.1);
            float a = lerp(wave.frequency.getLastValue(), freq, 0.2 );
            //println(a);
            wave.setFrequency(lerp(wave.frequency.getLastValue(), freq, 0.1 ));
            
          } else {
            wave.setFrequency(0);
          }
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

        if (i > 0) {
          previousDerivative = derivative;
        }
      }

      //play(1/frameRate);

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
