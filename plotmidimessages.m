function [grafico] = plotmidimessages(midiMessages,threshold,modulo,range)
lastTimeStamp=0;
startimestamp=0;
precendentetimestamprelativo=0;
delta=0;
grafico=plot(NaN,NaN,'-*');
ylim([0,127]);
k=1;
j=1;
v=1;
for i = 1:length(midiMessages)
        midiMessage=midiMessages(i);
        if(midiMessage.Type ~= "ControlChange" && midiMessage.Type == "NoteOn")
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
                    set(grafico, 'XData', [get(grafico, 'XData'), assex], 'YData', [get(grafico, 'YData'), midiMessage.Velocity],Color="blue");
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
