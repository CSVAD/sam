package live.drawing;


import processing.core.*;
import java.util.ArrayList;

/**
 * This is a template class and can be used to start a new processing Library.
 * Make sure you rename this class as well as the name of the example package 'template' 
 * to your own Library naming convention.
 * 
 * (the tag example followed by the name of an example included in folder 'examples' will
 * automatically include the example in the javadoc.)
 *
 * @example Hello 
 */

public class LiveDrawingManager{
	
	// myParent is a reference to the parent sketch
	PApplet myParent;
	
	// ArrayList containing all the drawn lines
	ArrayList<LDLine> lines;
	
	// State 
	boolean animate = false;
	boolean rotate = false;
	
	// Rotation angles
	float rotateY = 0;
	float rotateXZ = 0;
	
	// Color Mode
	boolean mode = true;
	
	// Current Line
	LDLine line;

	int myVariable = 0;
	
	public final static String VERSION = "1.0.0";
	

	/**
	 * a Constructor, usually called in the setup() method in your sketch to
	 * initialize and start the Library.
	 * 
	 * @example Hello
	 * @param theParent the parent PApplet
	 */
	public LiveDrawingManager(PApplet theParent) {
		myParent = theParent;
		lines =  new ArrayList<LDLine>();
		welcome();
	}
	
	public void activate() {
		  //myParent.background(50);
		  myParent.pushMatrix();
		  myParent.translate(myParent.width/2, myParent.height/2);
		  myParent.rotateX(rotateXZ);
		  myParent.rotateY(rotateY);
		  
		  if (!lines.isEmpty()) {
		    for (int i = 0; i < lines.size(); i++) {
		      lines.get(i).display(animate);
		    }

		  }
		  myParent.popMatrix();


		  if (rotate) {
		    rotateY += Math.toRadians(0.05);
		  }
	}
	
	public void addLine() {
		line = new LDLine(myParent);
		lines.add(line);
	}
	
	public void extendLine() {
		myParent.pushMatrix();
		line.addVertex(new PVector((myParent.mouseX -myParent.width/2)*(float)Math.cos(rotateY), myParent.mouseY - myParent.height/2, (myParent.mouseX -myParent.width/2)*(float)Math.sin(rotateY)));
		myParent.popMatrix();
	}
	
	public void clear() {
		lines.clear();
	}
	
	
	private void welcome() {
		System.out.println("Live Drawing for Processing 1.0.0 by Your Name http://yoururl.com");
	}
	
	
	public String sayHello() {
		return "hello library.";
	}
	/**
	 * return the version of the Library.
	 * 
	 * @return String
	 */
	public static String version() {
		return VERSION;
	}

	/**
	 * 
	 * @param animate_ : animation status
	 */
	public void setAnimationState(boolean animate_) {
		animate = animate_;
	}
	
	/**
	 * 
	 * @param rotate_ : rotation status
	 */
	public void setRotationState(boolean rotate_) {
		rotate = rotate_;
	}
	
	/**
	 * 
	 * @param theA the width of test
	 * @param theB the height of test
	 */
	public void setVariable(int theA, int theB) {
		myVariable = theA + theB;
	}

	/**
	 * 
	 * @return int
	 */
	public int getVariable() {
		return myVariable;
	}
}

