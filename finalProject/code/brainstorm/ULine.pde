class ULine implements Instrument {
  FilePlayer filePlayer;
  boolean alive = true;
  boolean doneDrawing = false;

  ArrayList<PVector> vertices = new ArrayList<PVector>();
  ArrayList<Float> strokes = new ArrayList<Float>();

  int verticesNb = 0;
  boolean animateLine = false;
  int animationIndex = 0;
  int animationIndex2 = 0;
  float strWeight = 5;
  color str = color(0);
  float increment = 1;
  boolean forward = true;
  boolean modeLine = false;
  float duration = 0.0;


  ULine() {
  }

  void addVertex(PVector point) {
    vertices.add(point);
    if (drawingMode) {
      strokes.add(tablet.getPressure()*tablet.getPressure()*100);
    }
    //println(tablet.getPressure()*100);

    verticesNb++;
    strWeight+=0.1;

    if (vertices.size() > 1) {
      duration += dist(point.x, point.y, point.z, vertices.get(verticesNb-2).x, vertices.get(verticesNb-2).y, vertices.get(verticesNb-2).z);
      //println(duration);
    }
  }

  void noteOn(float duration) {
  }

  void noteOff() {
  }


  void display() {
  }

  boolean checkAlive() {
    if (alive) {
      return true;
    } else {
      return false;
    }
  }

  void finished() {
    doneDrawing = true;
    animateLine = true;
  }
}
