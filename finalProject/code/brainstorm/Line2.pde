class ULine2 extends ULine {
  ArrayList<PVector> vertices = new ArrayList<PVector>();
  int verticesNb = 0;
  int animationIndex = 0;
  float strWeight = 5;
  color str = color(0);
  float increment = 1;
  boolean modeLine = false;
  // for Instrument
  Oscil wave;
  Noise noise;
  
  /*maxAmp — float: the maximum amplitude for the envelope
   attTime — float: the attack time, in seconds
   decTime — float: the decay time, in seconds
   susLvl — float: the percentage of the maximum amplitude to maintain after the decay completes
   relTime — float: the release time, in seconds
   befAmp — float: the amplitude to apply before the envelope is activated
   aftAmp — float: the amplitude to apply once the envelope has completed*/
  ADSR  adsr;
  float frequency = 300;
  float duration = 0.0;


  ULine2() {
    wave   = new Oscil( frequency, 0.4, Waves.SINE );
    noise = new Noise(Noise.Tint.RED);
    adsr = new ADSR(0.2, 0.01, 0.02, 0.2, 1.0);
    noise.patch( adsr );
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
        play(verticesNb/frameRate);
        //play(2.0);
      }
      for (int i = 0; i < animationIndex; i++) {
        float strokeW = strWeight*abs(sin(radians(i)+1));
        strokeWeight(strokeW);
        //wave.setFrequency(strokeW*50.0+20.0);
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

  void play(float _duration) {
    out.playNote( 0.0, _duration, this);
  }

  void noteOn( float _duration )
  {
    // turn on the ADSR
    adsr.noteOn();
    // patch to the output
    adsr.patch( out );
  }

  // this is called by the sequencer when the instrument should
  // stop making sound
  void noteOff()
  {
    // tell the ADSR to unpatch after the release is finished
    adsr.unpatchAfterRelease( out );
    // call the noteOff 
    adsr.noteOff();
  }
}
