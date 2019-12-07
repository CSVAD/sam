// beat instrument
// clap sound

class Tic extends ULine {
  Noise noise;
  ADSR adsr;
  BandPass   bpf;
  Delay delay;
  Line line;
  LowPassFS lpf;
  Oscil osc;
  Oscil lfo;
  Summer sum;

  Tic() {
    sum = new Summer();
    noise = new Noise();
    noise.setTint( Noise.Tint.RED );
    lfo = new Oscil(10, 1., Waves.sawh( 15 ));
    osc = new Oscil(8000, 0.05, Waves.SQUARE);
    adsr = new ADSR(.4f, 0.0001f, 0.1f, 0.0001f, .001f);
    //bpf = new BandPass(1300, 50, out.sampleRate());
    //lpf = new LowPassFS(1300, out.sampleRate());
    //delay = new Delay(0.1f, 1.0f, true, true);
    //line = new Line(.1f, 5.f, 0.f);
    //lfo.patch(osc.amplitude);
    osc.patch(sum);
    //noise.patch(sum);
    //line.patch(noise.amplitude);
    //noise.patch(bpf).patch( delay );
  }

  // Instrument functions
  void noteOn( float dur )
  {

    //line.activate( dur, 5.f, 0 );
    //osc.patch(adsr);
    sum.patch(adsr);
    // turn on the ADSR
    adsr.noteOn();
    // patch to the output
    adsr.patch( out );
  }

  // every instrument must have a noteOff() method
  void noteOff()
  {
    // tell the ADSR to unpatch after the release is finished
    adsr.unpatchAfterRelease( out );
    // call the noteOff 
    adsr.noteOff();
    //noise.unpatch(out);
  }

  void play(float dur) {
    out.playNote( 0.0, dur, this);
  }
  
}
