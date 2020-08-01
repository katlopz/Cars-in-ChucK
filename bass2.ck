//Final Project - CMPO185
//Katherine Lopez 300412891

500 => float beat;
beat*4 => float bar;

//same initialisation as sequence
[-1.0, -0.5, 0.0, 0.5, 1.0] @=> float pan[];
[659.3, 740.0, 830.6, 987.8, 1108.7] @=> float freq[];
Car @ cars[5]; 
for(0 => int i; i < cars.cap(); i++){
    new Car @=> cars[i]; 
    pan[i] => cars[i].pan;
    freq[i] => cars[i].freq;
}
while (true){
    cars[0].rev(beat/2);
    cars[1].rev(beat/2); 
    cars[0].rev(beat/2);
    cars[1].rev(beat/2);
}