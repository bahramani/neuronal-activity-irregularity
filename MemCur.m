function IExc = MemCur(tVec,tTemp,TauPeak,tEnd,IStim)
    Is = tVec(1:tTemp) .* exp(-tVec(1:tTemp) / TauPeak);
    Is = Is / max(Is);
    tSim = tEnd/1000;
    nTrials = 1;
    fr = 200;
    [PreSynSpikeMat,~] = PoissonSpikeGen(fr, tSim, nTrials, 0);
    Conv = conv(double(PreSynSpikeMat), Is, 'same');
    IExc = IStim * (Conv/max(Conv));
end

