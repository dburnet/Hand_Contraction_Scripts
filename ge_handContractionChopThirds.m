%for third between markers compute the alpha imbalance
function AIS = ge_handContractionChopThirds(filename)

lowerBound  = 2;
upperBound  = 41;
eegChannels = 3:16;

if regexp(filename,'set$')
    EEG2 = pop_loadset(filename);
elseif regexp(filename,'edf$')
    EEG2 = pop_biosig(filename);
else
    error('ge_handContractionChopThirdsPre: File type unknown');
end

EEG_only = pop_select(EEG2, 'channel', eegChannels);
EEG_only = pop_eegfilt(EEG_only, lowerBound, upperBound, [], [0], 0, 0, 'fir1', 0);

recordinglength = ceil(size(EEG_only.data));

sessionlength = (recordinglength(2)/128)/60;

for m = 3:5
    markers      = ge_getSampleBounds(EEG2, m);
    thirdsmath      = ceil((markers(2) - markers(1))/3);
    a      = (markers(1)+thirdsmath);
    b      = (a+thirdsmath);
    c = (b+thirdsmath);
    Timepoints = [a b c];
    for ii = 1:length(Timepoints)
        if ii == 1
            thirds   = EEG_only.data(:,1:Timepoints(ii));
            blob1.Fs = 128;
            blob1.data = thirds';
            tempvar = alphaImbalance(blob1);
            AIS{m,ii}   = tempvar(3:4);
        elseif Timepoints(ii) > Timepoints(ii-1)
            thirds   = EEG_only.data(:,1:Timepoints(ii));
            blob1.Fs = 128;
            blob1.data = thirds';
            tempvar = alphaImbalance(blob1);
            AIS{m,ii}   = tempvar(3:4);
        end
    end
end

end

            
%     first = EEG_only.data(:,markers(1):thirdsmath);
%     second = EEG_only.data(:,thirdsmath:h);
%     third = EEG_only.data(:,h:markers(2));
%  
% 
%     blob1.Fs = 128;
%     blob1.data = first';
%     blob2.Fs=128;
%     blob2.data = second';
%     blob3.Fs = 128;
%     blob3.data = third';
% 
%     AIS{1}  = alphaImbalance(blob1);
%     AIS{2}  = alphaImbalance(blob2);
%     AIS{3}  = alphaImbalance(blob3);
% end