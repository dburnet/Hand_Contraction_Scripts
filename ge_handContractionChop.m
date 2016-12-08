%for half between markers compute the alpha imbalance
function AIS = ge_handContractionChop(filename)

    lowerBound  = 2;
    upperBound  = 41;
    eegChannels = 3:16;
 
    if regexp(filename,'set$')
        EEG2 = pop_loadset(filename);
   elseif regexp(filename,'edf$')
        EEG2 = pop_biosig(filename);
    else
        error('ge_handContraction: File type unknown');
    end
    
    EEG_only = pop_select(EEG2, 'channel', eegChannels);
    EEG_only = pop_eegfilt(EEG_only, lowerBound, upperBound, [], [0], 0, 0, 'fir1', 0);
   
    
    
    m = 5;
    ss      = ge_getSampleBounds(EEG2, m)
    y       = ceil((ss(2) - ss(1))/2)
    b       = (ss(1)+y)
    first = EEG_only.data(:,ss(1):b);
    second = EEG_only.data(:,b:ss(2));
    

    blob1.Fs = 128;
    blob1.data = first'; 
    blob2.Fs = 128;
    blob2.data = second';
         
     AIS{1}   = alphaImbalance(blob1);
     AIS{2}   = alphaImbalance(blob2);
     
end