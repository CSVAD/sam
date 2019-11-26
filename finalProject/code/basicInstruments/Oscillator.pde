// based on minim sine instrument

class OscInstrument implements Instrument
{
  Oscil wave;
  Line  ampEnv;
  Wavetable waveType;
  
  OscInstrument( float frequency, Wavetable type)
  {
    waveType = type;
    // make a sine wave oscillator
    // the amplitude is zero because 
    // we are going to patch a Line to it anyway
    wave   = new Oscil( frequency, 0, waveType );
    ampEnv = new Line();
    ampEnv.patch( wave.amplitude );
  }
  
  OscInstrument( float frequency)
  {
    waveType = Waves.SINE;
    // make a sine wave oscillator
    // the amplitude is zero because 
    // we are going to patch a Line to it anyway
    wave   = new Oscil( frequency, 0, waveType);
    ampEnv = new Line();
    ampEnv.patch( wave.amplitude );
  }
  
  // this is called by the sequencer when this instrument
  // should start making sound. the duration is expressed in seconds.
  void noteOn( float duration )
  {
    // start the amplitude envelope
    ampEnv.activate( duration, 0.5f, 0 );
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
