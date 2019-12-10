// beat instrument
// clap sound

class Clap extends ULine {
  Noise noise;
  ADSR adsr;
  BandPass   bpf;
  Delay delay;
  Line line;
  LowPassFS lpf;
  Oscil osc;
  Oscil lfo;
  Summer sum;

  Clap(float freq) {
    sum = new Summer();
    noise = new Noise();
    //noise.setTint( Noise.Tint.RED );
    lfo = new Oscil(10, 1., Waves.SAW);
    osc = new Oscil(freq, 0.5, Waves.SINE);
    adsr = new ADSR(2.0f, 0.0001f, 0.1f, 0.01f, .5f);
    bpf = new BandPass(300, 50, out.sampleRate());
    lpf = new LowPassFS(400, out.sampleRate());
    delay = new Delay(0.1f, 1.0f, true, true);
    //line = new Line(.1f, 5.f, 0.f);
    //lfo.patch(osc.amplitude);
    osc.patch(sum);
    noise.patch(sum);
    //line.patch(noise.amplitude);
    //noise.patch(bpf).patch( delay );
  }

  // Instrument functions
  void noteOn( float dur )
  {

    //line.activate( dur, 5.f, 0 );
    //osc.patch(adsr);
    sum.patch(bpf).patch( delay ).patch(lpf).patch(adsr);
    //sum.patch( delay ).patch(lpf).patch(adsr);

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
