% This function gets firing rate, simulation duration and number of trials
% then it produces a matrix of Poisson based spiking. Note that dt of
% simulation is fixed. You can change it here.

function [SpikeMat, tVec] = PoissonSpikeGen(fr, tSim, nTrials, Inhibit)
    dt = 1/10000; % s
    nBins = floor(tSim/dt);
    SpikeMat = rand(nTrials, nBins) < fr*dt;
    if Inhibit
        SpikeMat = -1 * SpikeMat;
    end
    tVec = 0:dt:tSim-dt;
end