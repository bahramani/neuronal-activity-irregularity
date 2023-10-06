function [] = SpikeCountProb(SpikeMat,fr)
    figure('Name','Spike Count Probability');
    SpikeCount = sum(SpikeMat,2);
    x = min(SpikeCount):max(SpikeCount);
    histogram(SpikeCount, x, 'FaceColor', "#D95319", ...
              'Normalization', 'probability');
    hold on
    plot(x, poisspdf(x, fr),'Color',"r", 'LineWidth',1.5)
    title('Spike Count Probability')
    xlabel("lambda")
    ylabel("Probability")
end

