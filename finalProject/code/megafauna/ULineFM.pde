class ULineFM extends ULine {
  Oscil wave;
  Oscil fm;
  PVector derivative = new PVector(0, 0, 0);
  PVector previousDerivative= new PVector(0, 0, 0);




  ULineFM() {
    wave = new Oscil( 200, 0.3, Waves.TRIANGLE );
    fm   = new Oscil( 10, 1.0, Waves.TRIANGLE );
    // set the offset of fm so that it generates values centered around 200 Hz
    fm.offset.setLastValue( 200 );
    // patch it to the frequency of wave so it controls it
    fm.patch( wave.frequency );
  }

  void display() {
    beginShape();

    //animation
    if (animateLine) {
      if (animationIndex == 1 && doneDrawing) {
        //noteOff();
        //play(2*(verticesNb - 2)/frameRate);
        noteOn();
      }

      for (int i = 0 + animationIndex2; i < animationIndex; i++) {
        //if (forward) {

        if (i > 0) {
          derivative = PVector.sub(vertices.get(i), vertices.get(i-1));
        }


        float strokeW = strWeight*(abs(sin(radians(i)+1))+0.1f);
        //fm.setFrequency(map( strokeW, 0, 50, 0.1, 100 ));
        //println(strokeW);
        //float freq = map(PVector.angleBetween(derivative, previousDerivative), 0.f, 1f, 1.f, 100.f); //lerp(angle, PVector.angleBetween(derivative, previousDerivative), 0.1);

        if (forward) {
          fm.setFrequency(map(vertices.get(i).x, 0, width, 20, 100 ));
          
          // fm.setFrequency(lerp(fm.frequency.getLastValue(), freq, 0.1 ));
        } else {
          fm.setFrequency(map(vertices.get(verticesNb - animationIndex2).x, 0, width, 20, 100 ));
        }
        fm.setAmplitude( map(strokeW, 0, 100, 50, 1 ) );

        if (drawingMode) {
          strokeWeight(strokes.get(i));
        } else {
          strokeWeight(strokeW);
        }
        //println(i);
        if (forward) {
          // wave.setFrequency(animationIndex*50.0+20.0);
        } else {
          // wave.setFrequency((verticesNb - animationIndex2)*50.0+20.0);
        }


        stroke(color(255*abs(cos(0.5*radians(i)))));
        //stroke(255*map(lerp(fm.frequency.getLastValue(), freq, 0.1), 1.f, 100.f, 0f, 1f));

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
            noteOff();
          }
          forward = true;
          animationIndex = 0;
          animationIndex2 = 0;
        }
      }
    } else {
      // when tracing the first time
      for (int i = 0; i < vertices.size(); i++) {
        if (drawingMode) {
          strokeWeight(strokes.get(i));
        } else {
          strokeWeight(strWeight*abs(sin(radians(i)+1)));
        }

        stroke(color(255*abs(cos(0.5*radians(i)))));

        noFill();
        vertex(vertices.get(i).x, vertices.get(i).y, vertices.get(i).z);
      }
    }
    endShape();
  }


  void play(float _duration) {
    out.playNote( 0.0, _duration, this);
  }

  void noteOn( )
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
