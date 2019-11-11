package live.drawing;

import processing.core.*;
import processing.core.PApplet;
import java.util.ArrayList;
import java.lang.Math;


public class LDLine {
	  ArrayList<PVector> vertices = new ArrayList<PVector>();
	  int verticesNb = 0;
	  int animationIndex = 0;
	  float strWeight = 5;
	  //LDColor str = new LDColor(0,0,0);
	  float increment = 1;
	  boolean modeLine = true;
	  private PApplet myParent;
	  
	  
	  public LDLine(PApplet myParent){
		   this.myParent = myParent;
		  }
	  
	  public void addVertex(PVector point) {
		    vertices.add(point);
		    verticesNb++;
		    strWeight+=0.1;
		  }
	  
	  public void display(boolean animate) {
		    myParent.beginShape();

		    if (animate) {
		      for (int i = 0; i < animationIndex; i++) {
		    	  myParent.strokeWeight(strWeight*(float)Math.abs(Math.sin(radians(i)+1)));
		        
		        if (modeLine) {
		          myParent.stroke(myParent.color(255*(float)(Math.abs(Math.cos(0.5*radians(i)))), 100*(float)Math.abs(Math.sin(0.1*radians(i))), 0));
		        } else {
		          myParent.stroke(myParent.color((float)(255*Math.abs(Math.cos(0.5*radians(i))))));
		        }
		        myParent.noFill();
		        myParent.vertex(vertices.get(i).x, vertices.get(i).y, vertices.get(i).z);
		      }

		      animationIndex += increment;
		      if (animationIndex > verticesNb || animationIndex < 0) {
		        increment = -increment;
		        animationIndex += increment;
		      }
		    } else {
		      for (int i = 0; i < vertices.size(); i++) {
		    	  myParent.strokeWeight(strWeight*(float)Math.abs(Math.sin(radians(i)+1)));

		        if (modeLine) {
		        	myParent.stroke(myParent.color(255*(float)Math.abs(Math.cos(0.5*radians(i))), 100*(float)Math.abs(Math.sin(0.1*radians(i))), 0));
		        } else {
		        	myParent.stroke(myParent.color(255*(float)Math.abs(Math.cos(0.5*radians(i)))));
		        }
		        myParent.noFill();
		        myParent.vertex(vertices.get(i).x, vertices.get(i).y, vertices.get(i).z);
		      }
		    }
		    myParent.endShape();
		  }
	  
	  private float radians(float x) {
		  return x*(float)Math.PI/180.0f;
	  }
	  
	  

}

