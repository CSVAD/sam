class USampler extends ULine {
  ArrayList<Float> speed = new ArrayList<Float>();

  // for Instrument
  float frequency = 300;
  float duration = 0.0;
  String fileName = "colors1.aif";
  TickRate rateControl;
  FilePlayer filePlayer;

  USampler() {
    filePlayer = new FilePlayer( minim.loadFileStream(fileName) );
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
      speed.add(dist(point.x, point.y, point.z, vertices.get(verticesNb - 2).x, vertices.get(verticesNb - 2).x, vertices.get(verticesNb - 2).x));
    } else if (vertices.size() == 1) {
      speed.add(0.f);
    }
  }

  void display() {
    beginShape();

    if (animateLine) {
      if (animationIndex == 0) {
        //play(2*verticesNb/frameRate);
        //filePlayer.play();
        filePlayer.loop();
      }
      for (int i = 0 + animationIndex2; i < animationIndex; i++) {
        float strokeW = strWeight*abs(sin(radians(i)+1));
        strokeWeight(strokeW);

        float rate = map(speed.get(i), 0, 1000, 0f, 3.f);
        rateControl.value.setLastValue(rate);

        stroke(color(255*map(rate, 0f, 1.5f, 1f, 0f), 50*map(rate, 0f, 1.5f, 0f, 1f), 0.0));
        noFill();
        vertex(vertices.get(i).x, vertices.get(i).y, vertices.get(i).z);
      }

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
            // filePlayer.pause();
            noteOff();
          }
          forward = true;
          animationIndex = 0;
          animationIndex2 = 0;
        }
      }
    } else {
      for (int i = 0; i < vertices.size(); i++) {
        float rate = map(speed.get(i), 0, 1000, 0f, 3.f);

        strokeWeight(strWeight*abs(sin(radians(i)+1)));
        stroke(color(255*map(rate, 0f, 1.5f, 1f, 0f), 50*map(rate, 0f, 1.5f, 0f, 1f), 0.0));

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
  }

  // this is called by the sequencer when the instrument should
  // stop making sound
  void noteOff()
  {
    rateControl.unpatch(out);
  }
}
