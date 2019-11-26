import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;


Minim minim;
AudioOutput out;

NoiseInstrument noise1;
OscInstrument osc1;

// synthesis
AddSynth addsynth1;

boolean animate = false;


void setup()
{
  size(512, 200, P3D);

  minim = new Minim(this);

  // use the getLineOut method of the Minim object to get an AudioOutput object
  out = minim.getLineOut();

  // when providing an Instrument, we always specify start time and duration
  //out.playNote( 0.0, 0.9, new SineInstrument( 97.99 ) );
  //out.playNote( 1.0, 0.9, new SineInstrument( 123.47 ) );

  // we can use the Frequency class to create frequencies from pitch names
  //out.playNote( 2.0, 2.9, new SineInstrument( Frequency.ofPitch( "C3" ).asHz() ) );
  //out.playNote( 3.0, 1.9, new SineInstrument( Frequency.ofPitch( "E3" ).asHz() ) );
  //out.playNote( 4.0, 0.9, new SineInstrument( Frequency.ofPitch( "G3" ).asHz() ) );

  noise1 = new NoiseInstrument(0.5);
  osc1 = new OscInstrument(200, Waves.SQUARE);
  addsynth1 = new AddSynth(200, Waves.SINE);
}

void draw()
{
  background(0);
  stroke(255);

  // draw the waveforms
  /*for(int i = 0; i < out.bufferSize() - 1; i++)
   {
   line( i, 50 + out.left.get(i)*50, i+1, 50 + out.left.get(i+1)*50 );
   line( i, 150 + out.right.get(i)*50, i+1, 150 + out.right.get(i+1)*50 );
   }*/
}

void keyPressed() {
  if (key == 'q') {
    out.playNote( 0.0, 0.9, noise1);
  }
  if (key == 'w') {
    out.playNote( 0.0, 0.9, osc1);
  }
  if (key == 'e') {
    addsynth1.play(2.0);
  } 
  if (key == 'r') {
    out.playNote(0.0, 5.0, new OscInstrument(200, Waves.squareh( 5 )) );
  }
}
