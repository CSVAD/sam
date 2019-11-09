## live drawing library for processing

- What is are the goals of your library? (What is it intended to help people do and why?)
Processing is a great environment for artists to learn how to do things using programming. Artists can easily create visuals and sounds and communicate between software and machines using this open-source platform.

However, one thing that Processing does not allow is to make an independent executable out of a sketch. This could enable people to share games and interactive experiences more easily.    

LiveDrawing-for-Processing does not solve this issue but aims toward a live usage of a sketch. The library creates an environment that can be manipulated in a live setting without having to go back to the code. It focuses more precisely on live drawing/animation, but could be extended to sound in a near future. This proposed system could enable artists to generate animated drawings during a live performance.

This library is strongly inspired by [Bret Victor essence of digital art](https://www.youtube.com/watch?v=ZfytHvgHybA) and [Golan Levin performative tools](http://www.flong.com/projects/yellowtail/) (also [this a/v tool](http://www.flong.com/projects/aves/) from Golan Levin).


- What approaches do you provide for people to accomplish those goals (i.e. what are the methods you expose to the person using the library)?
For now, the library contains two classes: The _LiveDrawingManager_ and the _LDLine_.

The _LDLine_ is the basic unit of that library and its constructor is public. The _addVertex()_ method and the _display()_ are also public, which allows someone to simply draw a line if they wish to.

The _LiveDrawingManager_ gives the animation feature to the library. One can set the rotation and animation states (on or off) using respectively _setRotationState()_ and _setAnimationState()_



- What key terminology did you use for your library (i.e. function, class, and property names). How did you select this terminology?
For the terminology, I was inspired by DrawingManger made by Jennifer Jacobs and the core Processing library. So far, my library contains only two classes: The _LiveDrawingManager_ and the _LDLine_.

In _LDLine_, the _LD_ stands for _LiveDrawing_. The _LivingDrawingManager_ is a class that control the animation of the lines created through drawings, it holds the important status information and enables the transformation matrices.


![LiveDrawing0](https://github.com/CSVAD/sam/blob/master/projects/week7/LiveDrawing0.png)

![LiveDrawing1](https://github.com/CSVAD/sam/blob/master/projects/week7/LiveDrawing1.png)

![LiveDrawing2](https://github.com/CSVAD/sam/blob/master/projects/week7/LiveDrawing2.png)

![LiveDrawing3](https://github.com/CSVAD/sam/blob/master/projects/week7/LiveDrawing3.png)
