function [] = plotmidimessages(midiMessages)
velocity=[];
timestamps=[];
range=5
startimestamp=0;
for i = 1:length(midiMessages)
    midiMessage=midiMessages(i);
    if(midiMessage.Type ~= "ControlChange" && midiMessage.Type == "NoteOn")
    if(i==1) 
        startimestamp=midiMessage.Timestamp
    end
    lastimestamp=midiMessage.Timestamp;
    timestamprelativo=lastimestamp-startimestamp;
    timestamps=[timestamps,timestamprelativo]
    velocity=[velocity;midiMessage.Velocity];
    plot(timestamps,velocity,'-*',Color="#ff0000");
    xlim([timestamprelativo-(2*range),timestamprelativo+(range/2)])
    ylim([0,127])
    pause(0.005)
    end
end
end
