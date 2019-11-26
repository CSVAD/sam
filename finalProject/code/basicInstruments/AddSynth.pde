class AddSynth {
  OscInstrument[] oscs = new OscInstrument[10];
  float baseFrequency;

  AddSynth(float freq, Wavetable type) {
    baseFrequency = freq;
    for (int i = 0; i < oscs.length; i++) {
      oscs[i] = new OscInstrument(freq*(i+1), type);
    }
  }

  void play(float duration) {
    // attach the oscil to the output so it makes sound
    for (int i = 0; i < oscs.length; i++) {
      out.playNote( 0.0, duration*i, oscs[i]);
    }
  }
}
