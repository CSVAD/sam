class UTimer extends ULine {
  float tempo = 1000; // beat per minute
  float trigger = millis();
  float rotation = 0;
  float incRotation = 5;
  float alpha = 255;
  Oscil square;
  ADSR adsr;


  UTimer() {
    square = new Oscil(300f, 0f, Waves.SQUARE);
    adsr = new ADSR(2.0f, 0.0001f, 0.1f, 0.01f, 0.1f);
    square.patch(adsr);
  }


  void metronome() {
    if (millis() - trigger > tempo) {
      trigger = millis();
      rotation += incRotation;
      alpha -= 5;
      // println("hello");
      out.playNote( 0.0, 0.1, new Tic());
    }
  }

  void display() {
    // println("hello");
    pushMatrix();
    if (doneDrawing) {
     // translate(vertices.get(0).x, vertices.get(0).y, vertices.get(0).z);
      rotateZ(radians(rotation));
    }
    beginShape();

    for (int i = 0; i < vertices.size(); i++) {
      strokeWeight(5);
      stroke(0, 0, 255, alpha);

      noFill();
      vertex(vertices.get(i).x, vertices.get(i).y, vertices.get(i).z);
    }

    endShape();
    popMatrix();
  }

  void noteOn(float dur) {
    adsr.noteOn();
    // patch to the output
    adsr.patch( out );
  }

  void noteOff() {
    adsr.unpatchAfterRelease( out );
    // call the noteOff 
    adsr.noteOff();
  }

  void play(float dur) {
    out.playNote( 0.0, dur, this);
  }
}
