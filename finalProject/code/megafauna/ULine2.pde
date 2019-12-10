// spring + damping version of ULine2

class ULine2 extends ULine {
  // for Line
  float strWeight = 5;
  color str = color(0);
  float increment = 1;
  int rep = 0;

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

  void display() {
    beginShape();

    if (animateLine) {
      println(animationIndex);
      
      if (animationIndex == 0) {
        noteOff();
        rep++;
        println("blop");
        if (vertices.size()>0) {
          float dur =  20*verticesNb/frameRate;
          println(dur);
          //float maxAmp, float attTime, float decTime, float susLvl, float relTime, float befAmp, float aftAmp)
          adsr.setParameters(0.3, dur*0.01, dur*0.02, 0.2, dur*0.2, 0.0, 0.0);
          play(dur);
        }
      }

      // animating phase
      for (int i = 0; i < animationIndex; i++) {
        float strokeW = strWeight*abs(sin(radians(i)+1));
        strokeWeight(strokeW);
        stroke(color(255*abs(cos(2*radians(i)))));

        noFill();
        vertex(vertices.get(i).x, vertices.get(i).y, vertices.get(i).z);
      }

      animationIndex += increment;
      if (animationIndex > verticesNb || animationIndex < 0) {
        if (animationIndex < 0) {
          if (vertices.size() > 1) {
            vertices.remove(vertices.size()-1);
            verticesNb --;
          } else {
            alive = false;
          }
        }

        increment = -increment;
        animationIndex += increment;
      }
    } else {

      // tracing phase
      for (int i = 0; i < vertices.size(); i++) {
        strokeWeight(strWeight*abs(sin(radians(i)+1)));
        stroke(color(255*abs(cos(2*radians(i)))));

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
