function [] = parallelo(midimessages,riferimentomidimessages)
velocity=[];
riferimentovelocity=[];
timestamps=[];
riferimentotimestamps=[]
range=5
startimestamp=0;
riferimentostartimestamp=0;
for i = 1:length(midimessages)
    midiMessage=midimessages(i);
    riferimentomidimessage=riferimentomidimessages(i);
    if(midiMessage.Type ~= "ControlChange" && midiMessage.Type == "NoteOn")
    if(i==1) 
        startimestamp=midiMessage.Timestamp
    end
    if(riferimentomidimessage.Type ~= "ControlChange" && riferimentomidimessage.Type == "NoteOn")
    if(i==1) 
        riferimentostartimestamp=riferimentomidimessage.Timestamp
    end
    lastimestamp=midiMessage.Timestamp;
    riferimentolastimestamp=riferimentomidimessage.Timestamp;
    timestamprelativo=lastimestamp-startimestamp;
    riferimentotimestamprelativo=riferimentolastimestamp-riferimentostartimestamp;
    timestamps=[timestamps,timestamprelativo]
    velocity=[velocity;midiMessage.Velocity];
    riferimentotimestamps=[riferimentotimestamps,riferimentotimestamprelativo]
    riferimentovelocity=[riferimentovelocity;riferimentomidimessage.Velocity];
    plot(timestamps,velocity,'-*',Color="#ff0000");
    hold on
    plot(riferimentotimestamps,riferimentovelocity,'-*',Color="#ff00ff");
    xlim([timestamprelativo-(2*range),timestamprelativo+(range/2)])
    ylim([0,127])
    pause(0.01)
    end
    end
end
end
