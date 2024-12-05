clear all
device=mididevice("CASIO USB-MIDI");
 % Start timer
%start configuration
duration = 300;% Duration in seconds
threshold=0.1;
modulo=1;
range=5;
%end configuration
%newmidiMessages=createArray(50000,1,"midimsg");
lastTimeStamp=0;
startimestamp=0;
precendentetimestamprelativo=0;
delta=0;
ylim([0,127]);
k=1;
j=1;
v=1;
load("datiraccolti\04_12_2024\gneccoBeethovenCuffiaNoVIdeo.mat");
linea=plotmidimessages(midiMessages,threshold,modulo,range);
hold on
h=plot(NaN,NaN,'-*');
startTime = tic;
while toc(startTime) < duration
 msg = midireceive(device);
    if ~isempty(msg)
      for i = 1:length(msg)
        midiMessage=msg(i);
        if(midiMessage.Type ~= "ControlChange" && midiMessage.Type == "NoteOn")
            %newmidiMessages(k,1)=midiMessage;
            lastTimeStamp=midiMessage.Timestamp;
            if(k==1) 
                startimestamp=midiMessage.Timestamp;
                timestamprelativo=lastTimeStamp-startimestamp;
                precendentetimestamprelativo=timestamprelativo;
                v=v+1;
            elseif(k>1)
                timestamprelativo=lastTimeStamp-startimestamp;
                delta=timestamprelativo-precendentetimestamprelativo;
                if(delta>threshold)
                    if(mod(v,modulo)==0)
                    assex=timestamprelativo;
                    set(h, 'XData', [get(h, 'XData'), assex], 'YData', [get(h, 'YData'), midiMessage.Velocity],Color="#ff0000");
                    xlim([assex-range,assex+range]);
                    drawnow;
                    precendentetimestamprelativo=timestamprelativo;
                    end
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
