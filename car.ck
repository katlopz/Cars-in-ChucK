//Final Project - CMPO185
//Katherine Lopez 300412891

public class Car{  
    //fields for horn and rev  
    float pan; 
    float freq; 
    0.3 => float gain;   
    
    //method that simulates doppler effect of speeding car 
    //panning should change from left to right/right to left 
    //depending on parameter either "left" or "right" 
    //indicating the direction 
    fun void doppler(string direc){
        TriOsc t => Pan2 panner => ADSR env => Gain g => dac; 
        TriOsc t2 => panner;
        TriOsc t3 => panner;
        (20::ms, 20::ms, 0.8, 200::ms) => env.set;
    
        1 => float pan;
        0 => float gain; 
    
        0.2 => t.gain;
        0.3 => t2.gain;
        0.3 => t3.gain;
    
        1000 => float obs; 
        350 => float freq; 
        600 => float source; 
        330 => float vel;
        
        1000 => float totalDist;
        0.0005 => float timeInc;
        
        for(totalDist => float distance; distance > 0; distance-(source*timeInc) => distance){
            //<<<"Distance1: " + distance>>>;
            
            if (direc == "left") {
                1 - (1 - (distance/totalDist)) => pan;
                //( -(1/Math.pow(totalDist, 2))*(Math.pow(distance-totalDist, 2)) ) + 1 => pan;
                pan => panner.pan;
                <<<"Pan: " + pan>>>;
            }
            else {
                -1 + (1 - (distance/totalDist)) => pan;
                //( (1/Math.pow(totalDist, 2))*(Math.pow(distance-totalDist, 2)) ) - 1 => pan;
                pan => panner.pan;
                <<<"Pan: " + pan>>>;
                
            }
            
            //1 - Std.fabs(pan) => gain;
            (0.6/Math.pow(totalDist, 2))*(Math.pow(distance-totalDist, 2)) => gain;
            if(distance < 5 && distance > -5){
                1 => gain;
            }
            gain => g.gain;         
            //<<<"Gain: " + gain>>>;
            
            //(vel/(vel-source))*freq => obs;  //towards observer 
            740.0/2 => obs; 
            obs/2 => t.freq;
            obs-2 => t2.freq;
            obs/2 => t3.freq;
            <<<obs>>>;
            env.keyOn();
            timeInc::second => now;  
            env.keyOff();
        }

        for(0 => float distance; distance > -totalDist; distance-(source*timeInc) => distance){
            //<<<"Distance2: " + distance>>>;
            
            if (direc == "left") {
                0 - (Std.fabs(distance)/totalDist) => pan;
                //( (1/Math.pow(totalDist, 2))*(Math.pow(distance+totalDist, 2)) ) - 1 => pan;
                pan => panner.pan;
                <<<"Pan: " + pan>>>;
            }
            else {
                0 + (Std.fabs(distance)/totalDist) => pan;
                //( -(1/Math.pow(totalDist, 2))*(Math.pow(distance+totalDist, 2)) ) + 1 => pan;
                pan => panner.pan;
                <<<"Pan: " + pan>>>;
            }
            
            //1 - Std.fabs(pan) => gain;
            (0.6/Math.pow(totalDist, 2))*(Math.pow(distance+totalDist, 2)) => gain;
            if(distance < 5 && distance > -5){
                1 => gain;
            }
            gain => g.gain;
            //<<<"Gain: " + gain>>>;
            
            //(vel/(vel+source))*freq => obs; //away from observer
            659.3/2 => obs;
            obs/2 => t.freq;
            obs-2 => t2.freq;
            obs/2 => t3.freq;
            <<<obs>>>;
            env.keyOn();
            timeInc::second => now;  
            env.keyOff();
        }
    }
    
    
    //simulates car horn 
    fun void honk(float duration){
        SqrOsc t => ADSR env => LPF filt => Gain g => Pan2 panner => dac;
        SqrOsc q => env; 
        TriOsc q2 => env;
        pan => panner.pan;
        
        10000 => filt.freq;
    
        freq => t.freq; //to get other F's remember to double or half
        freq/2 => q.freq;
        (freq/2)-5 => q2.freq;

        0.2 => g.gain;
    
        env.set(10::ms, 10::ms, 0.5, 100::ms); 
        env.keyOn();
        duration::ms => now;
        env.keyOff();
    }
    
    //low pass start up sound 
    fun void rev(float beat){
        TriOsc t => ADSR env => Pan2 panner => dac;
        freq/8 => t.freq; 
        pan => panner.pan;
        env.set(50::ms, 100::ms, 0.5, 100::ms); 
        
        0.2 => float gain;
        
        for(0 => int i; i<4; i++){
            env.keyOn();
            (beat/2)::ms => now;
            env.keyOff();
            gain*0.6 => t.gain;
        }
        
    }
}

<<<"Car class added">>>;


