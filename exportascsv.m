function [] = exportascsv(midiMessages,nomeFile)
result=["Type,Note,Channel,Timestamp,Velocity"];
for i = 1:length(midiMessages)
    midiMessage=midiMessages(i);
    if(midiMessage.Type ~= "ControlChange")
    str=""+midiMessage.Type+",";
    str=str+midiMessage.Note+",";
    str=str+midiMessage.Channel+",";
    str=str+midiMessage.Timestamp+",";
    str=str+midiMessage.Velocity;
    result=[result;str]
    end
end
writematrix(result,"datiraccolti/"+nomeFile+".csv");
end
