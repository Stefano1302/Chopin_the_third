clear all
device=mididevice("CASIO USB-MIDI");
startTime = tic; % Start timer
duration = 90; % Duration in seconds
velocity=[];
timestamps=[];
midiMessages=createArray(10000,1,"midimsg");
range=5;
lastTimeStamp=0;
startimestamp=0;
precendentetimestamprelativo=0;
delta=0;
h=plot(NaN,NaN,'-*');
ylim([0,127]);
k=1;
j=1;
bpm=1;
while toc(startTime) < duration
 msg = midireceive(device);
    if ~isempty(msg)
      for i = 1:length(msg)
        midiMessage=msg(i);
        disp(midiMessage);
        midiMessages(j,1)=midiMessage;
        if(midiMessage.Type ~= "ControlChange" && midiMessage.Type == "NoteOn")
            lastTimeStamp=midiMessage.Timestamp;
            if(k==1) 
                startimestamp=midiMessage.Timestamp;
            end
            timestamprelativo=lastTimeStamp-startimestamp;
            %set(h, 'XData', [get(h, 'XData'), timestamprelativo], 'YData', [get(h, 'YData'), midiMessage.Velocity]);
            %xlim([timestamprelativo-range,timestamprelativo+range]);
            if(k>1)
                delta=timestamprelativo-precendentetimestamprelativo;
                bpm=(1/delta);
                set(h, 'XData', [get(h, 'XData'), timestamprelativo], 'YData', [get(h, 'YData'), bpm],Color="#ff0000");
                ylim([0,1]);
            end
            drawnow;
            precendentetimestamprelativo=timestamprelativo;
            k=k+1;
        end
        j=j+1;
      end
    end
    pause(0.01); % Small pause to prevent overloading the CPU
end
clear device
