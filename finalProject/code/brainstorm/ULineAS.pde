class ULineAS extends ULine {
  ArrayList<PVector>[] vertices = new ArrayList[10];
  Oscil[] oscs = new Oscil[10];
  Oscil[] amps = new Oscil[10];
  float noiseValue = 0.01;
  Summer sum = new Summer();

  ULineAS() {


    for (int i = 0; i < vertices.length; i++) {
      vertices[i] = new ArrayList<PVector>();
    }

    for (int i = 0; i < oscs.length; i++) {
      // oscs[i] = new Oscil(50.f + (i+1) * 50f, 0.0f, Waves.randomNHarms( 10 ));

      oscs[i] = new Oscil(50.f + (i+1) * 50f, 0.0f, Waves.randomNOddHarms( 10 ));
      // oscs[i] = new Oscil(50.f + (i+1) * 50f, 0.0f, Waves.SINE);

      amps[i] = new Oscil(5.0f*(i+1), 1.0/vertices.length, Waves.SINE);
      amps[i].patch(oscs[i].amplitude);
      //oscs[i].patch(sum);
    }

    oscs[0].patch(sum);
  }

  void addVertex(PVector point) {
    for (int i = 0; i < vertices.length; i++) {
      if (i == 0) {
        vertices[i].add(point);
      } else {
        // vertices[i].add(PVector.add(point, PVector.mult(point, map(noise(i+noiseValue), 0, 1, -1, 1))));
        //vertices[i].add(PVector.add(point, new PVector(point.x*map(noise(i+noiseValue), 0, 1, -0.5, 0.5), point.y*map(noise(2*i+noiseValue), 0, 1, -0.5, 0.5), point.z)));
        vertices[i].add(PVector.add(point, new PVector(50*map(noise(i+noiseValue), 0, 1, -1, 1), 50*map(noise(2*i+noiseValue), 0, 1, -1, 1), 0.0)));
      }
    }

    if (drawingMode) {
      strokes.add(tablet.getPressure()*tablet.getPressure()*10);
    }
    //println(tablet.getPressure()*100);

    verticesNb++;
    noiseValue += 0.01;
    //strWeight+=0.1;

    if (vertices[0].size() > 1) {
      duration += dist(point.x, point.y, point.z, vertices[0].get(verticesNb-2).x, vertices[0].get(verticesNb-2).y, vertices[0].get(verticesNb-2).z);
      //println(duration);
    }
  }

  void display() {

    for (int k = 0; k < vertices.length; k++) {
      beginShape();
      //animation
      if (animateLine) {
        if (animationIndex == 0) {
          noteOff();
          //play(2*(verticesNb - 2)/frameRate);
          noteOn(10f);
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
            for (int j = 0; j < oscs.length; j++) {
              //oscs[j].setFrequency(animationIndex*50.0+20.0);
              //oscs[j].setAmplitude(noise(j * noiseValue));
            }
          } else {
            for (int j = 0; j < oscs.length; j++) {
              //oscs[j].setFrequency((verticesNb - animationIndex2)*50.0+20.0);
              //oscs[j].setAmplitude(noise(j * noiseValue));
            }
          }

          noiseValue += 0.01;

          //stroke(str);
          //stroke(color(255*abs(cos(0.5*radians(i))), 100*abs(sin(0.1*radians(i))), 0));
          //stroke(color(255*abs(cos(0.5*radians(i)))));
          if (modeLine) {
            stroke(color(255*abs(cos(0.5*radians(i))), 100*abs(sin(0.1*radians(i))), 0));
          } else {
            stroke(color(255*abs(cos(0.5*radians(i)))));
          }
          noFill();
          //          for (int j = 0; j< vertices.length; j++) {

          vertex(vertices[k].get(i).x, vertices[k].get(i).y, vertices[k].get(i).z);
          //  }
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
              //alive = false;
            }
            forward = true;
            animationIndex = 0;
            animationIndex2 = 0;
          }
        }
      } else {
        // when tracing the first time
        for (int i = 0; i < vertices[0].size(); i++) {
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
          //for (int j = 0; j< vertices.length; j++) {
          vertex(vertices[k].get(i).x, vertices[k].get(i).y, vertices[k].get(i).z);
          //}
        }
      }
      endShape();
    }
  }

  void play(float _duration) {
    out.playNote( 0.0, _duration, this);
  }

  void noteOn( float _duration )
  {
    // start the amplitude envelope
    //ampEnv.activate( _duration, 0.5f, 0 );
    // attach the oscil to the output so it makes sound
    /*for (int i = 0; i < oscs.length; i++) {
     oscs[i].patch( out );
     }*/
    sum.patch(out);
  }

  // this is called by the sequencer when the instrument should
  // stop making sound
  void noteOff()
  {
    /*for (int i = 0; i < oscs.length; i++) {
     oscs[i].unpatch( out );
     }*/
    sum.unpatch(out);
  }
}
