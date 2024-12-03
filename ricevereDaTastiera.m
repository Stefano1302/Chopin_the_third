device = mididevice("CASIO USB-MIDI");
startTime = tic; % Start timer
duration = 10; % Duration in seconds
midiMessages = [];

while toc(startTime) < duration
    msg = midiread(device);
    if ~isempty(msg)
        midiMessages = [midiMessages; msg];
    end
    pause(0.01); % Small pause to prevent overloading the CPU
end

% Process midiMessages as needed
disp(midiMessages);
release(device);
