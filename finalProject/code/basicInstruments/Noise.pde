// from minim noise exemple

class NoiseInstrument implements Instrument
{
   // create all variables that must be used throughout the class
  Noise myNoise;
  Noise.Tint noiseTint = Noise.Tint.RED;
  
  // constructors for the intsrument
  NoiseInstrument( float amplitude)
  {
    // create new instances of any UGen objects as necessary
    // white noise is used for this instrument
    myNoise = new Noise( amplitude, noiseTint );
  }
  
  // every instrument must have a noteOn( float ) method
  void noteOn( float dur )
  {
    myNoise.patch( out );
  }
  
  // every instrument must have a noteOff() method
  void noteOff()
  {
    // unpatch the output 
    // this causes the entire instrument to stop calculating sampleframes
    // which is good when the instrument is no longer generating sound.
    myNoise.unpatch( out );
  }
  
  void SetNoiseInstrumentTint(Noise.Tint _noiseTint){
    noiseTint = _noiseTint;
  }
}
