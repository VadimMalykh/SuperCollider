//Problem Set 1
//Due 3pm Sept 9th 2021

//First, save this scd file as a new file, renaming it with your Last name at the beginning of the file name (e.g. "Fieldsteel Problem Set 1.scd"), and upload this renamed file to the course website for your submission.

//----------
//Problem 0.
//After defining the following function, the additional line below, which evaluates the function, generates an error message. Correct the error and add a comment explaining why the error was produced.

(
~func = {
	arg input;
	if(
		input == 4,
		{ "four is the magic number!".postln },
		{ "not the magic number...".postln }
	);
};
)

~func.value(6);

//----------
//Problem 1.
//Write a function that accepts three input arguments. If all three inputs are members of the same class (e.g. 1, 4, 500 are all Integers), print the string "same". If the three inputs are not members of the same class, return the string "different". Write an additional few lines of code that evaluate this function to demonstrate that it works correctly.

(
~f = {
	arg a1, a2, a3;
	if(
		a1.class == a2.class && a2.class == a3.class,
		"same",
		"different"
	);
};
)

~f.value(10, 15, 14);
~f.value("one", 2, 3);
~f.value(0.1, 1, 2);
~f.value(0.1, 0.2, 0.3);

//----------
//Problem 2.
//Write a function that takes an input argument, and checks whether the input value is an integer multiple of 100 (e.g. 200, 300, 400, etc., including zero and negative numbers). If so, return that number. If not, return the nearest multiple of 100 (the round() method may be helpful). Write an additional few lines of code that evaluate this function to demonstrate that it works correctly.

(
~f2 = {
	arg a;
	a.round(100);
};
)

~f2.(110);
~f2.(300);


//----------
//Problem 3.
//The following UGen function produces an error when we attempt to play it. Study the code and the error message, then correct the error and add a comment indicating what the problem was.

s.boot;
//s.reboot;

(
x = {
	var sig, freq, freq2, width;
	freq = LFSaw.ar(1/5,1).exprange(200,1500);
	freq2 = LFNoise0.ar(40!2).range(1,100);
	freq = (freq + freq2).round(50);
	width = LFTri.ar(0.2).exprange(0.02,0.5);
	sig = VarSaw.ar(freq, 0, width, 0.05);
	sig!2;
}.play;
)

x.free;

//----------
//Problem 4.
//The following UGen function produces an error when we attempt to play it. Study the code and the error message, then correct the error and add a comment indicating what the problem was.

(
x = {
	var sig, freq, amp;
	freq = LFNoise0.ar(9).exprange(40,500);
	amp = LFSaw.ar(9, 1).range(0,1).sqrt.neg + 1;
	sig = SinOsc.ar(freq, 0, 0.2) * amp;
	sig!2;
}.play;
)

x.free;

//----------
//Problem 5.
//The following code does not produce an error, but fails to produce sound. Correct the error and add a comment indicating what the problem was.

(
x = {
	var sig, noiseHz;
	noiseHz = LFNoise1.ar(10).exprange(500,5000);
	sig = LFDNoise1.ar(noiseHz, 0.08);
	//sig = sig * 0;
	sig = sig!2;
}.play;
)

x.free;

//----------
//Problem 6.
//The following code does not produce an error, but fails to produce sound. Correct the error and add a comment indicating what the problem was.

(
x = {
	var sig;
	sig = Pulse.ar([100,101], 0.5, 0.04);
	sig = sig + SinOsc.ar([150,150.6], 0, 0.15);
	sig = sig + BrownNoise.ar(0.04!2);
	sig = sig * Line.ar(0,1,10);
}.play;
)

x.free;

//----------
//Problem 7.
//Use the plot method to graph exactly 4 complete cycles of a triangle wave that has a frequency of 160 Hz.

(
{
	LFTri.ar(160);
}.plot(0.025);
)



//----------
//Problem 8.
//If you grew up with a landline phone in your house, or watched classic horror movies, you may have heard the sound of a telephone that's been left off the hook for too long. It's kind of a disturbing sound: a periodic on-off pulsation of a harsh, mid-range tone. For those who have no idea what I'm talking about, paste this link into your browser:

//https://www.youtube.com/watch?v=KO_YErq1M-M

//Create and play a UGen function that emulates this sound. Through a spectral analysis of this sound, I can tell you that it contains the following sinusoidal frequencies: [1400,2060,2450,2600]. The rest is up to you!

(
{
	var sig;
	sig = SinOsc.ar(1400);
	sig = sig + SinOsc.ar(2060);
	sig = sig + SinOsc.ar(2450);
	sig = sig + SinOsc.ar(2600);
	sig = sig * LFPulse.ar(5).range(0.0, 0.05);
	sig!2;
}.play;
)

//----------
//Problem 9.
//Create and play a UGen function that emulates a police siren. You can use this video for reference:

//https://www.youtube.com/watch?v=1G9mNBUymP8

//Experiment with different types of oscillators to create the timbre, pitch range, etc. You'll get full credit if your emulation generally approximates the siren — you don't have to aim for perfection! But try to get close.

(
{
	var sig, freq;
	freq = abs(LFSaw.ar(0.1)) * 750 + 500;
	sig = LFTri.ar(freq, 0.0, 0.2);
	sig!2;
}.play;
)


//----------
//Problem 10.

/*
You might be familiar with a distinctive type of lawn sprinkler. Paste the following link into your browser to see an image of one of these sprinklers:

http://diy.sndimg.com/content/dam/images/diy/fullset/2014/2/24/0/RX-iStock-187558829_Water_Lawn_Sprinkler_h.jpg.rend.hgtvcom.616.462.suffix/1420798717602.jpeg

And here's a video of one of these sprinklers in action:
https://www.youtube.com/watch?v=-nA7kUgLykA

These sprinklers produce a distinctive sound as they operate: a rapid-fire series of noise bursts for a few seconds, followed by noise bursts at a slower frequency for a longer period of time. Then, this cycle repeats. Here's a link to a clear and simple audio example of the sound itself:

https://uofi.box.com/s/vi5qb9h4yh2uv6mcn9dni7ienjj3p318

Create and play a UGen function that emulates this sound. There are different approaches, and you can take some creative liberties, but this can be done with one WhiteNoise generator and two LFPulse generators.
*/

(
{
	var sig, freqPulse, pulse;
	freqPulse = LFPulse.ar(0.2, 0.0, 0.2).range(8, 20);
	pulse = LFPulse.ar(freqPulse, 0.0, 0.3).range(0, 1);
	sig = WhiteNoise.ar(pulse) * 0.5;
	sig!2;
}.play
)
