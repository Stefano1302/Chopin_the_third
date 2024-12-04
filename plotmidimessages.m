function [] = plotmidimessages(midiMessages)
velocity=[];
timestamps=[];
range=5
for i = 1:length(midiMessages)
    midiMessage=midiMessages(i);
    if(midiMessage.Type ~= "ControlChange")
    timestamps=[timestamps,midiMessage.Timestamp]
    velocity=[velocity;midiMessage.Velocity];
    plot(timestamps,velocity,'-*');
    %xlim([timestamps(end)-range,timestamps(end)])
    ylim([20,140])
    pause(0.01)
    end
end
end
