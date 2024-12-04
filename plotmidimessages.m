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
    timestamps=[timestamps,lastimestamp-startimestamp]
    velocity=[velocity;midiMessage.Velocity];
    plot(timestamps,velocity,'-*',Color="#ff0000");
    xlim([lastimestamp-(2*range),lastimestamp+(range/2)])
    ylim([0,127])
    pause(0.01)
    end
end
end
