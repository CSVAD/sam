class ULineFM extends ULine {
  Oscil wave;
  Oscil fm;

  ULineFM() {
    wave = new Oscil( 200, 0.8, Waves.TRIANGLE );
    fm   = new Oscil( 10, 2, Waves.SINE );
    // set the offset of fm so that it generates values centered around 200 Hz
    fm.offset.setLastValue( 200 );
    // patch it to the frequency of wave so it controls it
    fm.patch( wave.frequency );
  }

  void display() {
    beginShape();

    //animation
    if (animate) {
      if (animationIndex == 1 && doneDrawing) {
       noteOff();
       play(2*(verticesNb - 2)/frameRate);
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



  void play(float _duration) {
    out.playNote( 0.0, _duration, this);
  }

  void noteOn( float _duration )
  {
    // start the amplitude envelope
    //kampEnv.activate( _duration, 0.5f, 0 );
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
