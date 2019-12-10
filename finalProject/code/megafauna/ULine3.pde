// spring + damping version of ULine2

class ULine3 extends ULine {
  // for Line
  float strWeight = 5;
  color str = color(0);
  float increment = 1;
  int rep = 0;
  float alpha = 255;
  ArrayList<PVector>[] vertices = new ArrayList[2];


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


  ULine3() {
    wave   = new Oscil( frequency, 0.4, Waves.SINE );
    noise = new Noise(Noise.Tint.RED);
    adsr = new ADSR(0.2, 0.01, 0.02, 0.2, 1.0);
    noise.patch( adsr );

    for (int i = 0; i < vertices.length; i++) {
      vertices[i] = new ArrayList<PVector>();
    }
  }

  void addVertex(PVector point) {

    for (int i = 0; i < vertices.length; i++) {
      PVector direction = new PVector(mouseX-pmouseX, mouseY - pmouseY, 0);
      PVector perpendicular = direction.cross(new PVector(0, 0, 1)).normalize();
      //println(perpendicular);
      if (i == 0) {
        //vertices[i].add((PVector.add(point, perpendicular.mult(70*sin(radians(vertices[i].size()))))));
        vertices[i].add((PVector.add(point, perpendicular.mult(100*pressure))));
      } else {
        //vertices[i].add((PVector.sub(point, perpendicular.mult(70*sin(radians(vertices[i].size()))))));
        vertices[i].add((PVector.sub(point, perpendicular.mult(100*pressure))));
      }
      //println(vertices[i]);
    }

    // use the tablet pressure, when connected
    if (drawingMode) {
      strokes.add(pressure*10);
    }

    verticesNb++;
    // noiseValue += 0.01;

    //compute average duration based on amount of vertices
    if (vertices[0].size() > 1) {
      duration += dist(point.x, point.y, point.z, vertices[0].get(verticesNb-2).x, vertices[0].get(verticesNb-2).y, vertices[0].get(verticesNb-2).z);
    }
  }

  void display() {
    for (int k = 0; k < vertices.length; k++) {
      beginShape();
      //animation
      if (animateLine) {
        if (animationIndex == 0) {
          noteOff();
          if (vertices[0].size()>0) {
            float dur =  verticesNb/frameRate;
            //void setParameters(float maxAmp, float attTime, float decTime, float susLvl, float relTime, float befAmp, float aftAmp)
            adsr.setParameters(0.3, dur*0.01, dur*0.02, 0.2, dur*0.2, 0.0, 0.0);
            //noteOn(dur);
            play(dur/2);
          }
          //play(2*(verticesNb - 2)/frameRate);
          // noteOn(10f);
          //alpha-=2;
          /* for (int j =0; j < oscs.length; j++) {
           amps[j].setAmplitude(map(alpha, 0., 255., 0., 1.0/vertices.length ));
           }*/
        }

        for (int i = 0 + animationIndex2; i < animationIndex; i++) {
          float strokeW = strWeight*abs(sin(radians(i)+1));
          if (drawingMode) {
            strokeWeight(strokes.get(i));
          } else {
            strokeWeight(strokeW);
            // strokeWeight(100*1/(1+PVector.dist(vertices[0].get(i), vertices[1].get(i))));
            strokeWeight(0.2*PVector.dist(vertices[0].get(i), vertices[1].get(i)));
          }

          if (forward) {
            stroke(255*animationIndex);
          } else {

            stroke(255-255*(verticesNb - animationIndex2));
          }

          //noiseValue += 0.01;

          //if (modeLine) {
          //stroke(color(100*abs(cos(0.5*radians(i))), 0, 255*abs(sin(0.1*radians(i))), alpha));
          //stroke();
          //} else {
          stroke(color(255-255*abs(cos(0.5*radians(i)))));
          //}
          // stroke(255);
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

        if (alpha < 0) {
          alive = false;
          //verticesNb--;
        }
      } else {
        // when tracing the first time
        for (int i = 0; i < vertices[0].size(); i++) {
          if (drawingMode) {
            strokeWeight(strokes.get(i));
          } else {
            strokeWeight(strWeight*abs(sin(radians(i)+1)));
            strokeWeight(0.2*PVector.dist(vertices[0].get(i), vertices[1].get(i)));
          }


          // stroke(255);


          //if (modeLine) {
          // stroke(color(255*abs(cos(0.5*radians(i))), 100*abs(sin(0.1*radians(i))), 0));
          //} else {
          stroke(color(255-255*abs(cos(0.5*radians(i)))));
          //}
          // stroke(color(100*abs(cos(0.5*radians(i))), 0, 255*abs(sin(0.1*radians(i)))));


          noFill();
          //for (int j = 0; j< vertices.length; j++) {
          //println(vertices[k].get(i));
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
    // turn on the ADSRy
    adsr.noteOn();
    // patch to the output
    adsr.patch( out );
  }

  // this is called by the sequencer when the instrument should
  // stop making sound
  void noteOff()
  {
    // tell the ADSR to unpatch after the release is finished
    adsr.unpatch( out );
    // call the noteOff 
    adsr.noteOff();
  }
}
