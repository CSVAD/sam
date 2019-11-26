class ULine implements Instrument {
  ArrayList<PVector> vertices = new ArrayList<PVector>();
  int verticesNb = 0;
  int animationIndex = 0;
  float strWeight = 5;
  color str = color(0);
  float increment = 1;
  boolean modeLine = true;
  // for Instrument
  Oscil wave;
  Line  ampEnv;
  float frequency = 300;
  float duration = 0.0;


  ULine() {
    wave   = new Oscil( frequency, 0, Waves.TRIANGLE );
    ampEnv = new Line();
    ampEnv.patch( wave.amplitude );
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
        play(2*verticesNb/frameRate);
      }
      for (int i = 0; i < animationIndex; i++) {
        float strokeW = strWeight*abs(sin(radians(i)+1));
        strokeWeight(strokeW);
        wave.setFrequency(strokeW*50.0+20.0);
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
