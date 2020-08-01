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
        400 => float source; 
        330 => float vel;
        
        1000 => float totalDist;
        0.0005 => float timeInc;
        
        for(totalDist => float distance; distance > 0; distance-(source*timeInc) => distance){
            //<<<"Distance1: " + distance>>>;
            
            if (direc == "left") {
                //1 - (1 - (distance/totalDist)) => pan;
                ( -(1/Math.pow(totalDist, 2))*(Math.pow(distance-totalDist, 2)) ) + 1 => pan;
                pan => panner.pan;
                <<<"Pan: " + pan>>>;
            }
            else {
                //-1 + (1 - (distance/totalDist)) => pan;
                ( (1/Math.pow(totalDist, 2))*(Math.pow(distance-totalDist, 2)) ) - 1 => pan;
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
            550 => obs; 
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
                //0 - (Std.fabs(distance)/totalDist) => pan;
                ( (1/Math.pow(totalDist, 2))*(Math.pow(distance+totalDist, 2)) ) - 1 => pan;
                pan => panner.pan;
                <<<"Pan: " + pan>>>;
            }
            else {
                //0 + (Std.fabs(distance)/totalDist) => pan;
                ( -(1/Math.pow(totalDist, 2))*(Math.pow(distance+totalDist, 2)) ) + 1 => pan;
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
            470 => obs;
            obs/2 => t.freq;
            obs-2 => t2.freq;
            obs/2 => t3.freq;
            <<<obs>>>;
            env.keyOn();
            timeInc::second => now;  
            env.keyOff();
        }
    }


//doppler("left");
//doppler("right");

Car car;
0 => car.pan;
600 => car.freq;
car.rev(250);