
## final project proposal: updated
Revise your final project proposal description based on class feedback and instructor comments.

### Live Animated Drawing and Sound Exploration
After receiving feedback from Jennifer and the class, I decided that I will investigate the relationship between animated drawing and sound. My goal is to put together a sketch (or multiple sketches) that will present various metaphors to understand this relationship.

I believe that, in the amount of time left to execute this project, exploring different strategies to connect sounds and visuals and reporting back on them is a good starting point. My thought process will be compiled into a [journal](https://github.com/CSVAD/sam/tree/master/finalProject/process) that I will update on a daily basis.

**Technical challenges**
I decided to use Max/MSP as my prototyping software for sound, therefore, I will need to enable communication between my patch and Processing. This adds a layer of complexity to the whole system and latency might be an issue. I find Max/MSP easier to use and my few experiments with minim and sound for Processing have consisted mainly to get rid of aliasing unsuccessfully. Allocating a different instrument to every lines using Max/MSP will be another challenge.

**Design challenges**
Coming up with compelling metaphors for the lines in terms of sonic affordances is definitely challenging. I have started brainstorming and prototyping. A first idea is to think of the sketch as an instrument that needs maintenance, if you stop drawing sound slowly vanishes through different phenomena. We will see of this evolves! So far, I have been going back and forth from the drawing sketch to the sound patch in order to build my examples. It believe that this strategy is efficient to tackle this challenge.


**Evaluation**
As for the evaluation, I hope to have a first prototype that can be performed live using a graphic tablet that by the end of the quarter. I also wish that the drawn lines and the generated sound to feel well integrated, part of a whole. If these two components are achieved I will consider this first stage a success.



## final project proposal

Write a short proposal for your final project based on one of the options. You may propose one idea, or several different possibilities. Projects may be collaborative. If you plan to work with other members of the class, describe how you plan to organize the work across the members of the team members.


### IDEA 1: LiveSoundDrawing Library
_LiveSoundDrawing Library_ would be the continuation of my LiveDrawing Library made for week 7. This framework would facilitate artists that want to draw and make sounds for live audio/visual performance. (I'm already excited to perform with my own tool. (Invent Things That You Would Want to Use Yourself, Construction Kits for Kids)). In addition to the basic examples distributed with the library, I would also make a more complex ready-to-perform interface. This project would, therefore, combine the prompts 1 and 3 suggested by Jennifer.

Steps:
1. Increase the drawing flexibility of the current _LiveDrawing Library_: adding control on color, stroke weight, multiline possibilities.
2. Adding animation capabilities.
3. Adding sound mapping to the drawings: stroke weight to resonant filter, multiline to polyphony, color to pitch. (still need to be determined)
4. (optional) Design a very simple/intuitive UI to increase the possibilities (for my personal interface only).
5. (optional) Adding quadraphonic features.

As described in week 7 project, this tool would be strongly inspired by [Bret Victor essence of digital art](https://www.youtube.com/watch?v=ZfytHvgHybA) and [Golan Levin performative tools](http://www.flong.com/projects/yellowtail/) (also [this a/v tool](http://www.flong.com/projects/aves/) from Golan Levin).

### IDEA 2: Building/Moving Blocks
I would like to make a Processing (or P5.js) interface of a design tool that would allow artists to visualize and control kinetic installations. The idea is to model simple components (such as gear, link, motor, pulley, wheel, sensor) and enable designers to assemble them together on a canvas (probably a Processing sketch) and control them later on using Arduino (or potentially other microcontrollers).

Steps:
1. Making a few simple components first
2. Setting up a GUI that allows to drag and drop (or maybe another interaction technique) components in a grid layout (that allows for snapping components together)
3. Integrating mechanical physics principle: gravity, speed, force, force moment to make the interaction between components as realistic as possible.
4. Adding communication to a microcontroller in order to physically control the controllable components of a kinetic project that would be based on a design made within the tool.

This project idea comes from the fact that having a simple framework to design my kinetic work would be very helpful. Of course, one could use AutoCAD or SOLIDWORKS, but the goal here is to create something easy to prototype with such as a Processing sketch. This could be the first version of a more complex software that I would like to develop in the future, maybe as part of my Ph.D. research.

This project builds on projects such as [Volume](https://softlabnyc.com/portfolio/volume/) by SOFTlab, which involves a processing interface to monitor and control the states of a mirrors and lights installation.
