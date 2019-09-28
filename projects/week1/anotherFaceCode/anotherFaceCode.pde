/**
 Week 1: The Face Exercice
 Author: Sam Bourgault
 
 Course: MAT594X
 Prof: Jennifer Jacobs
 
 Date: Sept 26, 2019
 **/

size (800, 800);

background(0);

stroke(255);
noFill();
//ellipse(width/2, height/2 - 300, 100, 100);
/*ellipse(width/2 + 70, height/2 - 290, 100, 100);
ellipse(width/2 - 70, height/2 - 293, 100, 100);
ellipse(width/2 + 140, height/2 - 260, 100, 100);
ellipse(width/2 - 140, height/2 - 260, 100, 100);
ellipse(width/2 + 210, height/2 - 200, 100, 100);
ellipse(width/2 - 210, height/2 - 200, 100, 100);*/

/*ellipse(width/2 , height/2 - 55, 600, 600);
ellipse(width/2 + 8 , height/2 - 52, 604, 603);
ellipse(width/2 - 2 , height/2 - 56, 610, 608);*/

//ellipse(width/2 - 100 , height/2 + 200, 120, 120);
fill(255);
noStroke();
rect(width/2,0,1,height);
rect(width/2 - 100 ,0,1,height);
rect(width/2 - 200 ,0,1,height);
rect(width/2 - 300 ,0,1,height);
rect(width/2 - 400 ,0,1,height);
rect(width/2 + 100 ,0,1,height);



rectMode(CENTER);

stroke(255);
fill(255);
//ellipse(width/2 + 100, height/2 - 130, 450, 450);
//ellipse(width/2, height/2 - 55, 500, 500);

//noFill();
line(width/2-100, height/2 + 100, width/2-270, height/2 + 70);
line(width/2-270, height/2 + 70, width/2-245, height/2 + 10);
//triangle(width/2-100, height/2 + 100, width/2-250, height/2 + 50, width/2-245, height/2 + 10 );

//face
fill(0);
ellipse(width/2, height/2, 400, 400);
fill(0, 0);
ellipse(width/2 - 2, height/2, 400, 420);

noFill();
// forehead
line(width/2 - 100, height/2 - 50, width/2 + 100, height/2 - 55);
line(width/2 - 80, height/2 - 60, width/2 + 90, height/2 - 58);
line(width/2 - 95, height/2 - 70, width/2 + 110, height/2 - 72);


// left eyes
triangle(width/2 - 70, height/2, width/2 - 150, height/2 + 30, width/2 - 90, height/2 + 50);
//triangle(width/2 - 74 , height/2, width/2 - 153 , height/2 + 33, width/2 - 91 , height/2 + 47);
triangle(width/2 - 72, height/2, width/2 - 151, height/2 + 32, width/2 - 89, height/2 + 49);

ellipse(width/2 - 101, height/2 + 30, 40, 40);
ellipse(width/2 - 105, height/2 + 40, 50, 50);
ellipse(width/2 - 110, height/2 + 50, 70, 70);
ellipse(width/2 - 112, height/2 + 60, 80, 80);

// right eyes
triangle(width/2 + 70, height/2, width/2 + 150, height/2 + 30, width/2 + 90, height/2 + 50);
triangle(width/2 + 74, height/2, width/2 + 153, height/2 + 33, width/2 + 91, height/2 + 47);
//triangle(width/2 + 72 , height/2, width/2 + 151 , height/2 + 32, width/2 + 89 , height/2 + 49);

ellipse(width/2 + 101, height/2 + 30, 41, 41);
ellipse(width/2 + 107, height/2 + 41, 53, 53);
ellipse(width/2 + 112, height/2 + 49, 67, 67);
ellipse(width/2 + 115, height/2 + 62, 81, 81);

//nose

ellipse(width/2, height/2 + 80, 50, 50);
ellipse(width/2 +4, height/2 + 78, 48, 53);
ellipse(width/2 - 2, height/2 + 81, 53, 49);

ellipse(width/2 - 32, height/2 + 90, 30, 30);
ellipse(width/2 - 33, height/2 + 90, 29, 32);

ellipse(width/2 + 32, height/2 + 90, 30, 30);
ellipse(width/2 + 34, height/2 + 90, 32, 28);

rect(width/2, height/2 + 20, 50, 100);
rect(width/2, height/2 + 22, 51, 97);
rect(width/2 - 2, height/2 + 20, 46, 105);


//mouth
triangle(width/2, height/2 + 130, width/2 - 50, height/2 + 150, width/2 + 60, height/2 + 155);
triangle(width/2, height/2 + 140, width/2 - 50, height/2 + 145, width/2 + 60, height/2 + 152);


//nose
/*fill(255, 0, 0);
 noStroke();
 triangle(width/2+100, height/2 - 200, width/2 +90, height/2+150, width/2+110, height/2+150);
 */
