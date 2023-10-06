% Amirreza Bahramani
% Advanced Neuroscience
% Feb. 2023
% HW 1
% Leaky Integrate and Fire Neuron

close all;
clear;
clc;

%% Parameters
dt = 0.1; %time step [ms]
tEnd = 500; %total time of run [ms]
tVec = dt:dt:tEnd;
TauM = 13; %membrane time constant [ms]
TauPeak = 1.5; % [ms]
tRefact = 0;% Refactory period [ms]
EL = 0; %resting membrane potential [mV]
Vth = 15; %spike threshold [mV]
VReset = EL; %value to reset voltage to after a spike [mV]
VSpike = 50; %value to draw a spike to, when cell spikes [mV]
RM = 1; %membrane resistance [MOhm]
IStim = 20; %Stimulus Current [nA]
fr = 200;

%% Part a
[~,Vm] = LIFNeuron(dt,tVec,TauM,tRefact,Vth,EL,VReset,VSpike,RM...
    ,IStim*ones(size(tVec)));
figure('Name','LIF Neuron Simulation')
plot(tVec,Vm,'b', 'LineWidth',1)
ylim([-5 55])
xlabel("t [ms]")
ylabel("V [mV]")
title("LIF Neuron Simulation")
grid minor

%% Part b
% The answer is in the report

%% Part c - Neuron Stimulation
IStim = 100;
tTemp = 100;
Is = tVec(1:tTemp) .* exp(-tVec(1:tTemp) / TauPeak);
Is = Is / max(Is);
figure('Name','Current Kernel')
plot(tVec(1:tTemp), Is, 'Color',[0.83 0.14 0.14], 'LineWidth',1)
% ylim([0 60])
xlabel("t [ms]")
ylabel("Normalized Is")
title("Current Kernel")
grid minor

tSim = tEnd/1000;
nTrials = 1;
[PreSynSpikeMat,~] = PoissonSpikeGen(fr, tSim, nTrials, 0);
Conv = conv(double(PreSynSpikeMat), Is, 'same');
IExc = IStim * (Conv/max(Conv));
figure('Name','Membrane Exciting Current')
plot(IExc,'Color',[0.83 0.14 0.14], 'LineWidth',1)
% ylim([0 60])
xlabel("t [ms]")
ylabel("I [nA]")
title("Membrane Exciting Current")
grid minor

[Spikes,Vm] = LIFNeuron(dt,tVec,TauM,tRefact,Vth,EL,VReset,VSpike,RM,IExc);
figure('Name','LIF Neuron Simulation')
plot(tVec,Vm,'Color',[0.83 0.14 0.14], 'LineWidth',1)
hold on
scatter(Spikes,45*ones(size(Spikes)),100,'*','b')
ylim([-5 55])
xlabel("t [ms]")
ylabel("V [mV]")
title("LIF Neuron Simulation")
grid minor

%% Part c - Contour Plot of Cv
