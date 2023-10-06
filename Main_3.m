% Amirreza Bahramani
% Advanced Neuroscience
% Feb. 2023
% HW 1
% Leaky Integrate and Fire Neuron Part c  - Effect of Width and Magnitude of EPSPs on Cv

close all;
clear;
clc;

%% Parameters
dt = 0.1; %time step [ms]
tRefact_temp = 1; %Refactory period [ms]
tTemp = 100;
tEnd = 100000; 
tVec = dt:dt:tEnd;
TauM = 13; %membrane time constant [ms]
EL = 0; %resting membrane potential [mV]
Vth = 15; %spike threshold [mV]
VReset = EL; %value to reset voltage to after a spike [mV]
VSpike = 50; %value to draw a spike to, when cell spikes [mV]
RM = 1; %membrane resistance [MOhm]

%% Part c - Effect of EPSPs Width on Cv
TauPeak_list = logspace(-1,2,200); %1:0.1:20;
Cv_TauPeak_list = zeros(4,length(TauPeak_list));

IStim = 200;
for i=1:length(TauPeak_list)
    IExc_temp = MemCur(tVec,tTemp,TauPeak_list(i),tEnd,IStim);
    [Spikes_temp,~] = LIFNeuron(dt,tVec,TauM,tRefact_temp,Vth,EL,VReset,VSpike,RM,IExc_temp);
    ISI = diff(Spikes_temp);
    Cv_TauPeak_list(1,i) = std(ISI)/mean(ISI);
end
IStim = 250;
for i=1:length(TauPeak_list)
    IExc_temp = MemCur(tVec,tTemp,TauPeak_list(i),tEnd,IStim);
    [Spikes_temp,~] = LIFNeuron(dt,tVec,TauM,tRefact_temp,Vth,EL,VReset,VSpike,RM,IExc_temp);
    ISI = diff(Spikes_temp);
    Cv_TauPeak_list(2,i) = std(ISI)/mean(ISI);
end
IStim = 300;
for i=1:length(TauPeak_list)
    IExc_temp = MemCur(tVec,tTemp,TauPeak_list(i),tEnd,IStim);
    [Spikes_temp,~] = LIFNeuron(dt,tVec,TauM,tRefact_temp,Vth,EL,VReset,VSpike,RM,IExc_temp);
    ISI = diff(Spikes_temp);
    Cv_TauPeak_list(3,i) = std(ISI)/mean(ISI);
end
IStim = 350;
for i=1:length(TauPeak_list)
    IExc_temp = MemCur(tVec,tTemp,TauPeak_list(i),tEnd,IStim);
    [Spikes_temp,~] = LIFNeuron(dt,tVec,TauM,tRefact_temp,Vth,EL,VReset,VSpike,RM,IExc_temp);
    ISI = diff(Spikes_temp);
    Cv_TauPeak_list(4,i) = std(ISI)/mean(ISI);
end

figure('Name','Effect of EPSPs Width on Cv')
loglog(TauPeak_list,Cv_TauPeak_list)
% ylim([-5 55])
xlabel("time [ms]")
ylabel("Cv")
title("Effect of EPSPs Width on Cv")
legend('Amp=200','Amp=250','Amp=300','Amp=350')
grid minor

%% Part c - Effect of EPSPs Amplitude on Cv
IStim_list = 50:5:1000;
Cv_IStim_list = zeros(4,length(IStim_list));

TauPeak = 1;
for i=1:length(IStim_list)
    IExc_temp = MemCur(tVec,tTemp,TauPeak,tEnd,IStim_list(i));
    [Spikes_temp,~] = LIFNeuron(dt,tVec,TauM,tRefact_temp,Vth,EL,VReset,VSpike,RM,IExc_temp);
    ISI = diff(Spikes_temp);
    Cv_IStim_list(1,i) = std(ISI)/mean(ISI);
end
TauPeak = 1.5;
for i=1:length(IStim_list)
    IExc_temp = MemCur(tVec,tTemp,TauPeak,tEnd,IStim_list(i));
    [Spikes_temp,~] = LIFNeuron(dt,tVec,TauM,tRefact_temp,Vth,EL,VReset,VSpike,RM,IExc_temp);
    ISI = diff(Spikes_temp);
    Cv_IStim_list(2,i) = std(ISI)/mean(ISI);
end
TauPeak = 5;
for i=1:length(IStim_list)
    IExc_temp = MemCur(tVec,tTemp,TauPeak,tEnd,IStim_list(i));
    [Spikes_temp,~] = LIFNeuron(dt,tVec,TauM,tRefact_temp,Vth,EL,VReset,VSpike,RM,IExc_temp);
    ISI = diff(Spikes_temp);
    Cv_IStim_list(3,i) = std(ISI)/mean(ISI);
end
TauPeak = 10;
for i=1:length(IStim_list)
    IExc_temp = MemCur(tVec,tTemp,TauPeak,tEnd,IStim_list(i));
    [Spikes_temp,~] = LIFNeuron(dt,tVec,TauM,tRefact_temp,Vth,EL,VReset,VSpike,RM,IExc_temp);
    ISI = diff(Spikes_temp);
    Cv_IStim_list(4,i) = std(ISI)/mean(ISI);
end

figure('Name','Effect of EPSPs Amp on Cv')
plot(IStim_list,Cv_IStim_list)
% ylim([-5 55])
xlabel("I [nA]")
ylabel("Cv")
title("Effect of EPSPs Amp on Cv")
legend('TauPeak=1','TauPeak=1.5','TauPeak=5','TauPeak=10')
grid minor








