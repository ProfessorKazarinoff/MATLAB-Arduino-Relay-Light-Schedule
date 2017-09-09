# Light_Schedule (using ThingSpeak)
Light relay for an aquaponic grow system that is controlled by the daily sunrise and sunset times of Portland, OR. 

We use MATLAB code to read daily sunrise and sunset times from the website https://sunrise-sunset.org/ (specifically for Portland, OR data: https://sunrise-sunset.org/search?location=Portland%2C+OR%2C+United+States ).

Once we retrieve this data we convert into a character array, then a numerical array, eventually to be converted into the daytime array for MATLAB so we can speak to Thingspeak.com

## Problem Statement
Our group was tasked with improving on what the team last year created. By connecting our MATLAB script with Thinkspeak and allow for an automatic on and off of the light relay coherent with the daily sunrise and sunset schedule.

## Hardware Setup
The hardware for the project was assembled as follows. Safety must be taken into consideration as the relay switches on and off electricty from the wall. Use proper precautions and double check all connections before plugging relay box into wall.

### Bill of Materials
| Component | Vendor | Item Description | Item Number | Web Link |
| --------- | ------ | -----------------| ----------- | ---------|
| Redboard | SparkFun | Microcontroller |DEV-13975 | https://www.sparkfun.com/products/13975 |
| Jumper wires x3 | SparkFun | Wires | PRT-10897 | https://www.sparkfun.com/products/10897 |
| USB cable | SparkFun | Connecting device | CAB-11301 | https://www.sparkfun.com/products/11301 |
| Beefcake Relay | SparkFun | Relay | KIT-13815 | https://www.sparkfun.com/products/13815 | 
| USB Mini-B Cable | SparkFun | USB Mini-B Cable - 6 Foot | CAB-11301 | https://www.sparkfun.com/products/11301 |

### Hardware Schematic
![fritzing_diagram](/doc/fritzing_diagram.png)

### Hookup Guide
#### First step: Lay out all the components on the relay board following the instruction on previous page (drawn in fritzing)
![image1](/doc/image1.png)

#### Second step:
connect the wires to the controller 
![image2](/doc/image2.png)

#### Third step:
Prepare the box by drilling two holes on either end for the power cord. Also cut out two access holes for the USB and adapter cables.
![image3](/doc/image3.png)

#### Fourth step:
Temporarily install stand-offs on the red board and relay board; use some zip ties to keep things secure in place. Then position inside box with outlets towards previously made cut-outs. 
![image4](/doc/image4.png)

#### Fifth step:
Feed the power cables inside the box. Connect the two white (neutral) wires together and the two green (ground) wires together with wire nuts. Then feed the two black (hot) wires into the blue terminal block (high voltage side) of the relay into the two right-hand most slots (order depends on the code order, but CO - common and NO - normally open are the best options).
![image5](/doc/image5.png)
![image6](/doc/image6.png)





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
  
## Future Work
What could another group of students do to build on this project? Any resources this group could use to build this future work?


## License
 GNU GENERAL PUBLIC LICENSE Version 3

  
 **Thanks to the previous PCC students for writing much of the previous Arduino code.**
