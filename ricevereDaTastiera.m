clear all
device=mididevice("CASIO USB-MIDI");
startTime = tic; % Start timer
duration = 90; % Duration in seconds
midiMessages = [];
timestamps=[]
while toc(startTime) < duration
 msg = midireceive(device);
    if ~isempty(msg)
        disp(msg);
        midiMessages = [midiMessages; msg];
    end
    pause(0.01); % Small pause to prevent overloading the CPU
end
%ritmo=timestamps(1,2:end)-timestamps(1,1:(end-1))
% 
% % Process midiMessages as needed