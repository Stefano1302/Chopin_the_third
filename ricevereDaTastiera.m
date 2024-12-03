clear all
device=mididevice("CASIO USB-MIDI");
startTime = tic; % Start timer
duration = 360; % Duration in seconds
midiMessages = [];
matrice=[[]]
while toc(startTime) < duration
 msg = midireceive(device);
    if ~isempty(msg)
        disp(msg);
        %midiMessages = [midiMessages; msg];
    end
    pause(0.01); % Small pause to prevent overloading the CPU
end
% 
% % Process midiMessages as needed