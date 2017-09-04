/*
  Physical Pixel
 An example of using the Arduino board to receive data from the
 computer.  In this case, the Arduino boards turns on an LED when
 it receives the character 'H', and turns off the LED when it
 receives the character 'L'.
 The data can be sent from the Arduino serial monitor, or another
 program like Processing (see code below), Flash (via a serial-net
 proxy), PD, or Max/MSP.
 The circuit:
 * LED connected from digital pin 13 to ground
 created 2006
 by David A. Mellis
 modified 30 Aug 2011
 by Tom Igoe and Scott Fitzgerald
 This example code is in the public domain.
 Example from http://www.arduino.cc/en/Tutorial/PhysicalPixel
 */

 // Arduino IoT Project - Light Relay Group
//  Authors: JuliAnna Scusa, Nicholas Sepe, Grace Semerjian, Quinn Gordon
//  Course/Term: ENGR114 Summer 2017
//  Date: 09/05/17
//  Description: This Arduino code should cause a beefcake relay to switch on and off accordingly to a
//  Matlab script that is communicating to it over serial. 

const int ledPin = 13; // the pin that the beefcake relay LED needs to be read and is attached to
int incomingByte;      // a variable to read/write incoming serial data into

void setup() {
  // initialize the serial communication with the redboard and beefcake relay:
  Serial.begin(9600);
  // initialize the LED pin as an output, but doesn't matter an because it doesn't work, go off of the square blue light:
  pinMode(ledPin, OUTPUT);
}

void loop() {
  // see if there's incoming serial data:
  if (Serial.available() > 0) {
    // read the oldest byte in the serial buffer:
    incomingByte = Serial.read();
    // if it's a capital H (ASCII 72), turn on the 13 light (a tiny blue square on the redboard across the 13 pin where the 
    // yellow wire is:
    if (incomingByte == 'H') {
      digitalWrite(ledPin, HIGH); // write to the redboard a high voltage and communicate the status to the beefcake relay, turn on
    }
    // if it's an L (ASCII 76) turn off the 13 light (a tiny blue square on the redboard across the 13 pin where the yellow wire is:
    if (incomingByte == 'L') {
      digitalWrite(ledPin, LOW); // write to the redboard a low voltage and communicate the status to the beefcake relay, turn off
    }
  }
}
