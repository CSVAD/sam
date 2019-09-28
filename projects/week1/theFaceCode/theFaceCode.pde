/**
 Week 1: The Face Exercice
 Author: Sam Bourgault
 
 Course: MAT594X
 Prof: Jennifer Jacobs
 
 Date: Sept 26, 2019
 **/

size (800, 800);

background(0);
rectMode(CENTER);

stroke(255);
noFill();

// face
//fill(100);
ellipse(width/2-25, height/2, 450, 600);

//fill(255);
ellipse(width/2, height/2, 400, 600);
//ellipse(width/2, height/2 + 70, 600, 400);

//right eye
//fill(100);
ellipse(width/2 + 160, height/2 + 100, 35, 35);

//fill(255);
ellipse(width/2 + 165, height/2 + 100, 35, 35);
rect(width/2 + 165, height/2 , 10, 70);


// left eye
//fill(100);
ellipse(width/2 - 5, height/2 + 100, 50, 50);

//stroke(100);
//fill(255);
ellipse(width/2, height/2 + 100, 50, 50);
rect(width/2 - 5, height/2, 10, 70);


// mouth
line(width/2 - 300, height/2 + 200, width/2 + 300, height/2 + 210);
line(width/2 - 300, height/2 + 210, width/2 + 300, height/2 + 190);
line(width/2 - 300, height/2 + 195, width/2 + 300, height/2 + 200);

//nose
fill(255, 0, 0);
noStroke();
triangle(width/2+100, height/2 - 200, width/2 +90, height/2+150, width/2+110, height/2+150);
