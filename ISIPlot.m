% This function generate an ISI plot from a matrix of spike activity.
% Note that the matrix is only consisted from ones and zeros.

function [ISI] = ISIPlot(SpikeMat, x, plot)
    temp = size(SpikeMat);
    nTrials = temp(1,1);
    ISI = cell(nTrials,1);
    for TrialCount = 1:size(SpikeMat,1)
        ISI{TrialCount} = diff(find(SpikeMat(TrialCount,:)));
    end

    if plot
        figure('Name','ISI Plot');
        histogram(cell2mat(cellfun(@(x)x(:),ISI(:),'un',0)), x, ...
            'Normalization', 'probability', 'FaceColor', "#D95319");
        title('Inter-Spike Interval Plot')
        xlabel("time [ms]")
        ylabel("Probability")
    end
end

