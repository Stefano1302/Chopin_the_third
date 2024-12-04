clear all
device=mididevice("CASIO USB-MIDI");
startTime = tic; % Start timer
duration = 90; % Duration in seconds
velocity=[];
timestamps=[];
midiMessages=[];
while toc(startTime) < duration
 msg = midireceive(device);
    if ~isempty(msg)
        disp(msg);
        midiMessages=[midiMessages;msg]
      for i = 1:length(msg)
        midiMessage=msg(i);
        if(midiMessage.Type ~= "ControlChange" && midiMessage.Type == "NoteOn")
            timestamps=[timestamps,midiMessage.Timestamp]
            velocity=[velocity;midiMessage.Velocity];
            plot(timestamps,velocity,'-*');
            %xlim([timestamps(end)-range,timestamps(end)])
            ylim([20,140])
        end
      end
    end
    pause(0.01); % Small pause to prevent overloading the CPU
end
clear device
