class UClap extends ULine {
  float speed = 10f;
  float distance = 0f;

  UClap() {
  }

  void display() {
    beginShape();

    //animation
    if (animateLine) {
      if (animationIndex % speed == 0 && doneDrawing) {
        
        //noteOff();
        //play(2*(verticesNb - 2)/frameRate);
        out.playNote( 0.0, 0.3, new Clap(speed*5));
      }

      // redraw
      for (int i = 0 + animationIndex2; i < animationIndex; i++) {
        if (i > 0) {
          distance = PVector.dist(vertices.get(i - 1), vertices.get(i));
          speed = (int) lerp(speed, distance * 10, 0.1);
          speed = (int) lerp(speed, 1/distance * 50, 0.1);
          //println(speed);
        }

        float strokeW = strWeight*(abs(sin(radians(i)+1))+0.1f);

        // tablet or mouse
        if (drawingMode) {
          strokeWeight(strokes.get(i));
        } else {
          strokeWeight(strokeW);
        }

        // color mode
        stroke(50+205*map(distance, 0., 20., 0., 1.));
        noFill();
        vertex(vertices.get(i).x, vertices.get(i).y, vertices.get(i).z);
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
            alive = false;
            noteOff();
          }
          forward = true;
          animationIndex = 0;
          animationIndex2 = 0;
        }
      }

      if (animationIndex < verticesNb) {
        //animationIndex += increment;
      }
    } else {
      // when tracing the first time
      for (int i = 0; i < vertices.size(); i++) {
        //float strokeW = strWeight*tablet.getPressure();
        if (drawingMode) {
          strokeWeight(strokes.get(i));
        } else {
          strokeWeight(strWeight*abs(sin(radians(i)+1)));
        }

        if (i > 0) {
          distance = PVector.dist(vertices.get(i - 1), vertices.get(i));
        }

        if (modeLine) {
          stroke(color(255*abs(cos(0.5*radians(i))), 100*abs(sin(0.1*radians(i))), 0));
        } else {
          stroke(color(255*abs(cos(0.5*radians(i)))));
        }
        stroke(50+205*map(distance, 0., 20., 0., 1.));

        noFill();
        vertex(vertices.get(i).x, vertices.get(i).y, vertices.get(i).z);
      }
    }
    endShape();
  }
}