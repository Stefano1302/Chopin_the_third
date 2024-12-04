clear all
device=mididevice("CASIO USB-MIDI");
startTime = tic; % Start timer
duration = 90; % Duration in seconds
velocity=[];
timestamps=[];
midiMessages=[];
range=5;
lastTimeStamp=0;
startimestamp=0;
h=plot(NaN,NaN,'-*');
 ylim([0,127]);
while toc(startTime) < duration
 msg = midireceive(device);
    if ~isempty(msg)
        disp(msg);
        midiMessages=[midiMessages;msg];
      for i = 1:length(msg)
        midiMessage=msg(i);
        if(midiMessage.Type ~= "ControlChange" && midiMessage.Type == "NoteOn")
            lastTimeStamp=midiMessage.Timestamp;
            if(i==1) 
                startimestamp=midiMessage.Timestamp;
            end
            timestamprelativo=lastTimeStamp;
            set(h, 'XData', [get(h, 'XData'), timestamprelativo], 'YData', [get(h, 'YData'), midiMessage.Velocity]);
            xlim([timestamprelativo-range,timestamprelativo+range]);
            drawnow;
        end
      end
    end
    pause(0.01); % Small pause to prevent overloading the CPU
end
clear device
