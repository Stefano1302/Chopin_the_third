clear device
device=mididevice("CASIO USB-MIDI");
startTime = tic; % Start timer
duration = 90; % Duration in seconds
range=5;
velocity=[];
timestamps=[];
midiMessages=[];
lastTimeStamp=0;
startimestamp=0;
riferimentovelocity=[];
riferimentotimestamps=[];
riferimentolastTimeStamp=0;
riferimentostartimestamp=0;

h=plot(NaN,NaN,'-*');
 ylim([0,127])
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
            timestamprelativo=lastTimeStamp-startimestamp
            set(h, 'XData', [get(h, 'XData'), timestamprelativo], 'YData', [get(h, 'YData'), midiMessage.Velocity]);
            xlim([timestamprelativo-range,timestamprelativo+range]);
            drawnow;
            hold on
        end
        riferimentomidiMessage=riferimentomidiMessages(i);
        if(riferimentomidiMessage.Type ~= "ControlChange" && riferimentomidiMessage.Type == "NoteOn")
            riferimentolastTimeStamp=riferimentomidiMessage.Timestamp
            if(i==1) 
                riferimentostartimestamp=riferimentomidiMessage.Timestamp
            end
            riferimentotimestamprelativo=riferimentolastTimeStamp-riferimentostartimestamp;
            set(h, 'XData', [get(h, 'XData'), riferimentotimestamprelativo], 'YData', [get(h, 'YData'), riferimentomidiMessage.Velocity],Color="#ff0000");
            drawnow;
        end
      end
    end
    pause(0.001); % Small pause to prevent overloading the CPU
end
clear device