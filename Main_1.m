% Amirreza Bahramani
% Advanced Neuroscience
% Feb. 2023
% HW 1
% Integrate and Fire Neuron

close all;
clear;
clc;

%% Parameters
dt = 1/1000; % [s]
fr = 100;
tSim = 1; % [s]
nTrials = 1000;

%% Part a
[SpikeMat, tVec] = PoissonSpikeGen(fr, tSim, nTrials, false);
% RasterPlot(SpikeMat, tVec); % Not recommended for large nTrials

%% Part b
SpikeCountProb(SpikeMat,fr);

%% Part c
x = 0:100;
[ISI] = ISIPlot(SpikeMat, x, true);
hold on
plot(x, dt*exppdf(x/1000, 1/fr), 'Color',"r", 'LineWidth',1.5)

%% Part a-c
k = 5;
[RenewalSpikeMat] = RenewalProcess(SpikeMat,k);

SpikeCountProb(RenewalSpikeMat, fr);

x = 0:150;
[RenewalISI] = ISIPlot(RenewalSpikeMat, x, true);
hold on
plot(x, gampdf(x,k,1/(dt*fr)), 'Color',"r", 'LineWidth',1.5)

%% Part d

ISIMat = cell2mat(cellfun(@(x)x(:),ISI(:),'un',0)); 
Cv = std(ISIMat)/mean(ISIMat);

RenewalISIMat = cell2mat(cellfun(@(x)x(:),RenewalISI(:),'un',0)); 
RenewalCv = std(RenewalISIMat)/mean(RenewalISIMat);

%% Part e
% The answer is in the report

%% Part f
figure('Name','Fig.3 paper');
scatter(cellfun(@mean,ISI), cellfun(@std,ISI)./cellfun(@mean,ISI));
hold on
scatter(cellfun(@mean,RenewalISI), cellfun(@std,RenewalISI)...
    ./cellfun(@mean,RenewalISI), 'red');
xlim([0 60])
ylim([0 1.5])
legend('Poisson Process','Renewal Process')
xlabel('delta t');
ylabel("CV")
title("Cv from Simulation")
grid minor

%% Part g
f = [999:-50:200,199:-20:150,150:-5:30];
Nth = [1,4,51];
RefPeriod = 1; % ms
% for large Nth (e.g. 51), we should choose large tSim since there will be
% enough spikes in one trial
tSim = 10; % s
% for computational cost it's better to choose smaller nTrials
nTrials = 1000;

CvMat = zeros(length(Nth),length(f));
for j = 1:length(Nth)
    for i = 1:length(f)
    fr = f(i);
    [SpikeMat, ~] = PoissonSpikeGen(fr, tSim, nTrials, false);
    [RenewalSpikeMat] = RenewalProcess(SpikeMat, Nth(j));
    [RenewalISI] = ISIPlot(RenewalSpikeMat, x, false);
    RenewalISIMat = cell2mat(cellfun(@(y)y(:),RenewalISI(:),'un',0));
    RenewalISIMat = RenewalISIMat + RefPeriod;
    RenewalCv = std(RenewalISIMat)/mean(RenewalISIMat);
    CvMat(j, i) = RenewalCv;
    end
end
cmap = hsv(length(CvMat));
figure;
hold on
for i = 1:size(CvMat,1)
    scatter(1000./f, CvMat(i,:), 'Color',cmap(i,:))
end
yline(1,'k')
yline(0.5,'k')
yline(0.15,'k')
xlabel('delta t');
ylabel("CV")
ylim([0 1.2])
legend('Nth=1','Nth=4','Nth=51','1','0.5','0.15')
title("Comparison of Cv from integrator models")