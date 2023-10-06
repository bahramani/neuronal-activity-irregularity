function [RenewalSpikeMat] = RenewalProcess(SpikeMat,k)
    if k==1
        RenewalSpikeMat = SpikeMat;
    else
        RenewalSpikeMat = zeros(size(SpikeMat));
        for i = 1:size(SpikeMat,1)
            SpikeLoc = find(SpikeMat(i,:));
            NewSpikeLoc = SpikeLoc(1:k:end);
            RenewalSpikeMat(i,NewSpikeLoc) = 1;
        end
    end   
    RenewalSpikeMat = logical(RenewalSpikeMat);
end

