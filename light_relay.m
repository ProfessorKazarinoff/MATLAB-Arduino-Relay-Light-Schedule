%% Arduino IoT Project - Light Relay Group
%  Authors: JuliAnna Scusa, Nicholas Sepe, Grace Semerjian, Quinn Gordon
%  Date: 09/05/17
%  Course/Term: ENGR114 Summer 2017
%  Description: This script will grab the most current sunset and sunrise 
%  times of Portland, OR, convert it to datetime arrays and let Matlab
%  determine whether to turn the light relay on or off based on the current
%  time. In addition, the state of the relay will be sent to ThingSpeak and
%  produce a plot on a field. Matlab will then check if the data sent is
%  equivalent to the data stored on ThingSpeak.

%% Clear the command window, all workspace variables, and close any open plot windows.

clc, clear, close all % Clear command line, workspace variables & all open
                      % plot windows. 

format short g        % Makes the commandline output more easily readable.

 
%%  Set up serial port and ensure it outputs data.
%   Change the Port the Arduino is connected to.

delete(instrfindall);         % Find all possible serial port objects 
                              % and delete their connections
arduino = serial('COM4','BaudRate',9600) % Note, COM4 may vary from to computer to computer
                              % Create a serial port object with port
                              % COM4 @ a BaudRate of 9600
fopen(arduino)                % Open up a connection with serial port object 
                              % arduino to this device
pause(1)
disp('Serial Port is Open')  


%% Automatic Scheduling and Talking to ThingSpeak

on = 'H';     % Let the inputs be H & L for the Arduino to read over serial
off = 'L';
    
while 1
    
% Take the API address data and convert into numerical arrays
    
data_api = webread('https://api.sunrise-sunset.org/json?lat=45.5230622&lng=-122.6764815&formatted=0');
                             % Bring the sunrise, sunset and daylength 
                             % data from the API address 

sunrise_api = num2str(data_api.results.sunrise); % Convert the API address 
str = sunrise_api;                               % data into string
str(20:25) = [];             % Get rid of the trailing +00:00's
str(11) = ',';               % Make spacings with commas for 
str(5) = ',';                % the creation of the datetime vector
str(8) = ',';
str(14) = ',';
str(17) = ',';
a_str = str2num(str);

sunset_api = num2str(data_api.results.sunset);
strv = sunset_api;
strv(20:25) = [];
strv(11) = ',';
strv(5) = ',';
strv(8) = ',';
strv(14) = ',';
strv(17) = ',';
b_str = str2num(strv);

% Convert to datetime vectors

a = datetime(a_str);         % Now that the sunrise and sunset data is in
b = datetime(b_str);         % numerical array, convert to datetime array

datetime.setDefaultFormats('default','yyyy-MM-dd hh:mm:ss')
                             % If the datetime arrays weren't in the 
                             % American date format, correct it so it is

sunrise = a - hours(7)       % Convert the sunrise and sunset times from
sunset = b - hours(7)        % Greenwhich Mean Time to Pacific Time

              % If the current time is after sunrise and before sunset
              % turn on the relay and convey this information to
              % ThingSpeak as a value of 1
               
    if sunrise < datetime('now') & datetime('now') < sunset
        fprintf(arduino,'%s',on)
        thingSpeakWrite(323649, 1, 'WriteKey', 'Z6DSIWHY64U6ACQO')
        data = thingSpeakRead(323649,'ReadKey','MCZPNZK0M0REJHWR')
        pause(15)
    end
              % If the current time is before sunrise and after sunset
              % turn off the relay and convey this information to
              % ThingSpeak as a value of 0
               
    if sunrise > datetime('now') & datetime('now') > sunset
        fprintf(arduino,'%s',off)
        thingSpeakWrite(323649, 0, 'WriteKey', 'Z6DSIWHY64U6ACQO')
        data = thingSpeakRead(323649,'ReadKey','MCZPNZK0M0REJHWR')
        pause(15)
    end
    
              % Read the state of the relay on ThingSpeak and compare if 
              % the data sent to ThingSpeak is equivalent to the data read
              % from ThingSpeak

more_data = webread('https://thingspeak.com/channels/323649/field/1.json');
last_data = more_data.feeds(end).field1
last_string = num2str(last_data);
last_numba = str2num(last_string);
compare = (last_numba == data)

              % Create a bar graph showing the daylength for today and time
              % that the relay is off
    
       on_time = data_api.results.day_length;
       on_time = on_time/3600;
             y = [on_time,24-on_time];
             x = [1,0];

bar(x,y)
grid
title('Time on & Time off for today')
ylabel('Time on & Time off (hrs)')
xlabel('On                          &                             Off')

end


%% Close the serial port.

fclose(arduino);               % Close the serial port object connection
delete(arduino);               % with the arduino 
clear arduino;
disp('Serial Port is closed.')

