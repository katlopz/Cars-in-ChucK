//Major Assignment- CMPO185
//Katherine Lopez 300412891

500 => float beat;
beat*4 => float bar;

//recursive method that simulates pedestrian crossing
//gain decreases on each iteration 
//parameters pan and starting gain
public void beep (float pan, float gain){
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