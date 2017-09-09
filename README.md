# Light_Schedule (using ThingSpeak)
Light relay for an aquaponic grow system that is controlled by the daily sunrise and sunset times of Portland, OR. 

We use MATLAB code to read daily sunrise and sunset times from the website https://sunrise-sunset.org/ (specifically for Portland, OR data: https://sunrise-sunset.org/search?location=Portland%2C+OR%2C+United+States ).

Once we retrieve this data we convert into a character array, then a numerical array, eventually to be converted into the daytime array for MATLAB so we can speak to Thingspeak.com

## Problem Statement:
Our group was tasked with improving on what the team last year created. By connecting our MATLAB script with Thinkspeak and allow for an automatic on and off of the light relay coherent with the daily sunrise and sunset schedule.

## Hardware Setup:
The hardware for the project was assembled as follows. Safety must be taken into consideration as the relay switches on and off electricty from the wall. Use proper precautions and double check all connections before plugging relay box into wall.
### Bill of Materials:

### Hardware Schematic
![fritzing_diagram](/doc/fritzing_diagram.png)

## MATLAB Code
From the description in the MATLAB code:  
"This script will grab the most current sunset and sunrise 
  times of Portland, OR, convert it to datetime arrays and let Matlab
 determine whether to turn the light relay on or off based on the current
 time. In addition, the state of the relay will be sent to ThingSpeak and
 produce a plot on a field. Matlab will then check if the data sent is
 equivalent to the data stored on ThingSpeak."

## Arduino Code
From the description in the arduino code:
" This Arduino code should make a beefcake relay switch on and off accordingly to a
  Matlab script that is communicating to it over serial. "
  
## Future Work:
What could another group of students do to build on this project? Any resources this group could use to build this future work?


## License
 GNU GENERAL PUBLIC LICENSE Version 3

  
  Thanks to the previous PCC students for writing much of the previous Arduino code.
