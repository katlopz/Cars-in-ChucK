//Major Assignment- CMPO185
//Katherine Lopez 300412891

500 => float beat;
beat*4 => float bar;

//method simulate footsteps 
//parameter: number of steps
public void step(float numOfTimes){
    SqrOsc t => ADSR env => dac; 
    0.2 => t.gain;
    500 => t.freq;
    (1::ms, 4::ms, 0, 0::ms) => env.set; 
    for(0 => int i; i<numOfTimes; i++){
        env.keyOn();
        beat::ms => now;
    }   
}