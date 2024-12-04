clear all
device=mididevice("CASIO USB-MIDI");
startTime = tic; % Start timer
duration = 90; % Duration in seconds
velocity=[];
timestamps=[];
midiMessages=[];
range=10;
lastTimeStamp=0;
startimestamp=0;
while toc(startTime) < duration
 msg = midireceive(device);
    if ~isempty(msg)
        disp(msg);
        midiMessages=[midiMessages;msg]
      for i = 1:length(msg)
        midiMessage=msg(i);
        if(midiMessage.Type ~= "ControlChange" && midiMessage.Type == "NoteOn")
            lastTimeStamp=midiMessage.Timestamp
            if(i==1) 
                startimestamp=midiMessage.Timestamp
            end
            timestamps=[timestamps,lastTimeStamp-startimestamp]
            velocity=[velocity;midiMessage.Velocity];
            plot(timestamps,velocity,'-*');
            xlim([lastTimeStamp-range,lastTimeStamp+range])
            ylim([0,127])
        end
      end
    end
    pause(0.01); % Small pause to prevent overloading the CPU
end
clear device
