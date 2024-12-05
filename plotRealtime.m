clear all
device=mididevice("CASIO USB-MIDI");
startTime = tic; % Start timer
duration = 360;% Duration in seconds
threshold=0.1;
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
v=1;
bpm=1;
while toc(startTime) < duration
 msg = midireceive(device);
    if ~isempty(msg)
      for i = 1:length(msg)
        midiMessage=msg(i);
        %disp(midiMessage);
        %midiMessages(j,1)=midiMessage;
        if(midiMessage.Type ~= "ControlChange" && midiMessage.Type == "NoteOn")
            lastTimeStamp=midiMessage.Timestamp;
            if(k==1) 
                startimestamp=midiMessage.Timestamp;
                timestamprelativo=lastTimeStamp;
                precendentetimestamprelativo=timestamprelativo;
                v=v+1;
            elseif(k>1)
                timestamprelativo=lastTimeStamp;
                delta=timestamprelativo-precendentetimestamprelativo;
                if(delta>threshold)
                bpm=(1/delta);
                set(h, 'XData', [get(h, 'XData'), v], 'YData', [get(h, 'YData'), bpm],Color="#ff0000");
                xlim([v-range,v+range]);
                ylim([0,20]);
                drawnow;
                precendentetimestamprelativo=timestamprelativo;
                v=v+1;
                elseif(delta <= threshold)
                    disp(delta);
                end
            end
            k=k+1;
        end
        j=j+1;
      end
    end
    pause(0.001); % Small pause to prevent overloading the CPU
end
clear device
