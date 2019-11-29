class USampler extends ULine {
  ArrayList<PVector> vertices = new ArrayList<PVector>();
  ArrayList<Float> speed = new ArrayList<Float>();
  //PVector previousPoint;
  
  int verticesNb = 0;
  int animationIndex = 0;
  float strWeight = 5;
  color str = color(0);
  float increment = 1;
  boolean modeLine = false;
  // for Instrument

  float frequency = 300;
  float duration = 0.0;

  String fileName = "colStereo.aif";
  TickRate rateControl;
  FilePlayer filePlayer;


  USampler() {
    filePlayer = new FilePlayer( minim.loadFileStream(fileName) );
    // and then we'll tell the recording to loop indefinitely
    //filePlayer.loop();
    // this creates a TickRate UGen with the default playback speed of 1.
    // ie, it will sound as if the file is patched directly to the output
    rateControl = new TickRate(1.0);
    // patch the file player through the TickRate to the output.
    filePlayer.patch(rateControl).patch(out);
  }

  void addVertex(PVector point) {
    vertices.add(point);
    verticesNb++;
    strWeight+=0.1;

    if (vertices.size() > 1) {
      duration += dist(point.x, point.y, point.z, vertices.get(verticesNb-2).x, vertices.get(verticesNb-2).y, vertices.get(verticesNb-2).z);
      //println(duration);
      speed.add(dist(point.x, point.y, point.z, vertices.get(verticesNb - 2).x, vertices.get(verticesNb - 2).x,vertices.get(verticesNb - 2).x));
    } else if (vertices.size() == 1) {
      speed.add(0.f);
    }
    
    //previousPoint = point;
  }

  void display() {
    beginShape();

    if (animate) {
      if (animationIndex == 0) {
        //play(2*verticesNb/frameRate);
        //filePlayer.play();
        filePlayer.loop();
      }
      for (int i = 0; i < animationIndex; i++) {
        float strokeW = strWeight*abs(sin(radians(i)+1));
        strokeWeight(strokeW);
        //rateControl.value.setLastValue(map(i, 0, animationIndex, 0.2, 1.0));
        // change the rate control value based on mouse position
        //float rate = map(mouseX, 0, width, 0.0f, 3.f);
        //float rate = map(i, 0, verticesNb, 0.2f, 3.0f);
        float rate = map(speed.get(i), 0, 1000, 0f, 3.f);
        //println(rate);
        rateControl.value.setLastValue(rate);
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
    // start the amplitude envelope
    //ampEnv.activate( _duration, 0.5f, 0 );
    // attach the oscil to the output so it makes sound
    //wave.patch( out );
  }

  // this is called by the sequencer when the instrument should
  // stop making sound
  void noteOff()
  {
    //wave.unpatch( out );
  }
}
