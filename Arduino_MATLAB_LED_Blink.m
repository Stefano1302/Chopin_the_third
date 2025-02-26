% create an arduino object
clear all;
a = arduino('COM3', 'Uno');     

% start the loop to blink led for 10 seconds

for i = 1:5

    writeDigitalPin(a, 'D2', 1);

    pause(1);

    writeDigitalPin(a, 'D2', 0);

    pause(1);

end
  
%end communication with arduino 
  
clear a