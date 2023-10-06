% Amirreza Bahramani
% Advanced Neuroscience
% Feb. 2023
% HW 1
% Leaky Integrate and Fire Neuron Part d - e - f

close all;
clear;
clc;

%% Parameters
dt = 0.1; %time step [ms]
tRefact = 1; %Refactory period [ms]
tTemp = 100;
tEnd = 500; 
tVec = dt:dt:tEnd;
TauM = 13; %membrane time constant [ms]
EL = 0; %resting membrane potential [mV]
Vth = 15; %spike threshold [mV]
VReset = EL; %value to reset voltage to after a spike [mV]
VSpike = 50; %value to draw a spike to, when cell spikes [mV]
RM = 1; %membrane resistance [MOhm]
fr = 200;
TauPeak = 1.5; % [ms]

%% Part d
IStim = 100;
tTemp = 100;
Is = tVec(1:tTemp) .* exp(-tVec(1:tTemp) / TauPeak);
Is = Is / max(Is);
tSim = tEnd/1000;
nTrials = 1;
[PreSynSpikeMat,~] = PoissonSpikeGen(fr, tSim, nTrials, 0);
PreSynSpikes = find(PreSynSpikeMat);
PerInh = 0.25;
NumInh = floor(PerInh * length(PreSynSpikes));
msize = numel(PreSynSpikes);
InhSpikes = PreSynSpikes(randperm(msize, NumInh));
InhPreSynSpikeMat = double(PreSynSpikeMat);
InhPreSynSpikeMat(InhSpikes) = -1;
Conv = conv(InhPreSynSpikeMat, Is, 'same');
IExc = IStim * (Conv/max(Conv));
figure('Name','Membrane Current (Inh)')
plot(IExc,'Color',[1.00 0.54 0.00], 'LineWidth',1)
% ylim([0 60])
xlabel("t [ms]")
ylabel("I Exciting [nA]")
title("Membrane Current with "+num2str(PerInh*100)+'% Inhibitory Neurons')
grid minor

[Spikes,Vm] = LIFNeuron(dt,tVec,TauM,tRefact,Vth,EL,VReset,VSpike,RM,IExc);
figure('Name','LIF Neuron Simulation')
plot(tVec,Vm,'Color',[1.00 0.54 0.00], 'LineWidth',1)
hold on
scatter(Spikes,45*ones(size(Spikes)),100,'*')
ylim([min(Vm) 55])
xlabel("t [ms]")
ylabel("V [mV]")
title("LIF Neuron Simulation")
grid minor
