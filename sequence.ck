//Final Project - CMPO185
//Katherine Lopez 300412891

500 => float beat;
beat*4 => float bar;

fun void beep (float pan, float gain){
    SinOsc s => Gain g => BPF filt => Pan2 panner => dac;
    SinOsc q => g;
    
    gain => float gainTemp; 
    
    if (gainTemp >= 0.5){ //only on first time do quick sweep
        panner.pan(pan);
        500 => filt.freq; 
        1 => filt.Q;
    
        0.7 => s.gain; 
        0.05 => q.gain;
    
        0.5 => g.gain;
    
        for(4000 => int i; i > 493.9; i--) {
            i => s.freq;
            i => q.freq;
            0.02::ms => now;
        }
    }
    
    400 => filt.freq;
    3 => filt.Q; 
    
    493.9 => s.freq; 
    246.9 => q.freq;
    0.7 => s.gain; 
    0.05 => q.gain;
    0.5 => g.gain;
    
    
    0.5 => g.gain;
    100::ms => now; 
    0 => g.gain;
    20::ms => now;
    
    
    gainTemp - 0.04 => gainTemp; 
    if(gain > 0.032){
        beep(pan, gainTemp);
    }
    <<<gainTemp>>>;
}


//method simulate footsteps 
//parameter: number of steps
fun void step(float numOfTimes){
    SqrOsc t => ADSR env => dac; 
    0.2 => t.gain;
    500 => t.freq;
    (1::ms, 4::ms, 0, 0::ms) => env.set; 
    for(0 => int i; i<numOfTimes; i++){
        env.keyOn();
        beat::ms => now;
    }   
}


//for instantiating car objects
[-1.0, -0.5, 0.0, 0.5, 1.0] @=> float pan[];
[659.3, 740.0, 830.6, 987.8, 1108.7] @=> float freq[];
Car @ cars[5]; 
for(0 => int i; i < cars.cap(); i++){  //fills with corresponding 
    new Car @=> cars[i];               //pan and frequency
    pan[i] => cars[i].pan;
    freq[i] => cars[i].freq;
}


//start of sequence

//INTRO
spork~ step(9);
bar::ms => now;
spork~ beep(0, 0.5);

bar::ms => now;
cars[0].honk(250);
spork~ cars[0].honk(1000);
spork~ cars[2].doppler("right");

bar::ms => now;

spork~ cars[4].honk(250);
beat::ms => now;
spork~ cars[4].honk(1000);
(beat*3)::ms => now;

spork~ cars[3].honk(250);
beat::ms => now;
spork~ cars[3].honk(1000);
(beat*3)::ms => now;

spork~ cars[4].honk(250);
beat::ms => now;
spork~ cars[3].honk(250);
beat::ms => now;

spork~ cars[4].honk(250);
beat::ms => now;
spork~ cars[3].honk(250);
beat::ms => now;

spork~ cars[4].honk(1000); 
spork~ cars[3].honk(1000); 
beat::ms => now; 

spork~ beep(0, 0.5);
(beat*3)::ms => now;

//A SECTION
Machine.add(me.dir() + "/rev.ck") => int rev;
((bar*2) + (beat/2))::ms => now;
spork~ step(16);
bar*2::ms => now;

Machine.remove(rev);
spork~ cars[0].honk(bar + bar);
beat::ms => now;
spork~ cars[2].honk(bar*2 - beat);
beat::ms => now;
spork~ cars[3].honk(bar*2 - beat*2);
beat::ms => now; 
spork~ cars[4].honk(bar*2 - beat*3);
(bar )::ms => now;

for(0 => int i; i<4; i++){
    spork~ cars[0].rev(beat);
    if (i%2 == 0){
        spork~ cars[i].doppler("left");   
    }
    else{
        spork~ cars[i].doppler("right");
    }
    
    beat*2::ms => now;
}

bar::ms => now;

//B SECTION
Machine.add(me.dir() + "/bass.ck") => int bass;
(beat/2)::ms => now; 
spork~ step(32);


spork~ cars[4].honk(250);
beat::ms => now;
spork~ cars[4].honk(1000);
(bar-beat)::ms => now;

spork~ cars[3].honk(250);
beat::ms => now;
spork~ cars[3].honk(1000);
(bar-beat)::ms => now;

spork~ cars[0].honk(250);
spork~ cars[2].honk(250);
beat::ms => now;
spork~ cars[0].honk(1000);
spork~ cars[2].honk(1000);
(bar-beat)::ms => now;

spork~ cars[1].honk(250);
spork~ cars[3].honk(1000);
beat::ms => now;
spork~ cars[3].honk(1000);
(bar-beat)::ms => now;

//C SECTION
Machine.remove(bass);
Machine.add(me.dir() + "/bass2") => bass;
(bar*2)::ms => now;

cars[2].honk(250);
cars[2].honk(750);
cars[3].honk(beat);

cars[2].honk(250);
cars[2].honk(750);
cars[3].honk(beat);

cars[2].honk(250); 
cars[3].honk(250); 
cars[2].honk(250); 
cars[3].honk(250); 

Machine.remove(bass);

250 => float between;
while(between > 50){
    cars[2].honk(between);
    cars[3].honk(between);
    between - 20 => between; 
}

//D SECTION
cars[3].doppler("right");

for(0 => int i; i<4; i++){
    Std.rand2(0, cars.cap()-1) => int rand1; 
    Std.rand2(0, cars.cap()-1) => int rand2; 
    while(rand2 == rand1) {
        Std.rand2(0, cars.cap()-1) => rand2; //ensures that random values differ
    }                                       
    
    spork~ cars[rand1].honk(beat*2);
    spork~ cars[rand2].honk(beat*2);
    (beat*2)::ms => now;
}
    
beat*2::ms => now; 

spork~ step(13);
spork~ beep(1, 0.5);
spork~ beep(-1, 0.5);


(beat*13)::ms => now;







