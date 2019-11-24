## process journal

### Nov 23, 2019
Exploring minim on Processing.
- I attached a sine oscillator from the minim library to the line unit from my previous sketch. The duration of the note is directly proportional to the length of the line.
    - more questions arise from this first test.
    - the output is very chaotic, which is not necessarily wrong. but the lack of pauses and silences makes the sonic quality of the output a bit boring. I would like to reach a sound that is closer to what electroacoustic musicians produce.
    - lack of direct sonic and visual output when in animation mode.
    - maybe I should start by making the sound I like me minim first.

Designing metaphor:
- each line: an instrument with some characteristics depending of its physiognomy.
- implementing big lines die before short ones.
- inspirations for title
    - ici, on crache
    - macrophage
    - megafauna

What could be sonified:
- ADSR
- additive synthesis
    - with varying amount of partial depending of the weight stroke?
- wavetable stacking technic: "When four to eight complex waveforms can be staked, deep and rich hybrid textures can be created for each sound event." (Roads, 1996)
- how to embrace reverb?
- can lines interact visually and sonically with each other?
- granular synthesis
    - the envelope of the grain modifies its sonic qualities (Roads, 1996).
    - could textural visual inputs represent grains?
    - (have to continue reading from p.191 to p.203 of pdf for more about granulation.)
- subtractive synthesis implies filters (Chapter 10).


What could be the playback reader:
- my current framework could be seen as a 3d radar. The user could be able to manipulate the distance from the center point.

What kind of sound I want my interface to enable?
- beats --> follow a rhythmic structure.
- grain --> doesn't have to follow the structure.
- long harmonic sounds --> doesn't have to follow a rhythmic structure.

** Reading Curtis Roads: The Computer Music Tutorial


### Nov 22, 2019
Taking a pen and paper to prototype.



### Nov 21, 2019
I just finished reading Golan Levin [thesis]{https://acg.media.mit.edu/people/golan/thesis/thesis300.pdf}. His thesis follows his thorough process of design, from inspiration to creation. He is critical about previous work and about his own, which gives me a lot of insights regarding directions to take or not to take. More on this later.

**Questions emerged form the reading:**
- Where/what is the reader? A movable rectangle like in [_Yellowtail_]{http://www.flong.com/projects/yellowtail/} or an abstracted timeline based on the line's length like in _Loom_ (Levin, c. 1999)? Or something else?
- How can I use 3 dimensions sonically?
- How could I develop grouping behaviors between the lines in order to develop a choir like system?
- Could adding physics to the process be interesting visually and sonically?
- Could sonifying textures be relevant?
- How can the user erase visual/sonic events? Without clearing the whole frame?