% This function generate a Raster plot from a matrix of spike activity.
% Note that the matrix is only consisted from ones and zeros.

function [] = RasterPlot(SpikeMat, tVec)
    figure('Name','Raster Plot');
    hold all;
    for TrialCount = 1:size(SpikeMat,1)
        SpikePos = tVec(SpikeMat(TrialCount, :));
        for SpikeCount = 1:length(SpikePos)
            plot([SpikePos(SpikeCount) SpikePos(SpikeCount)], ...
            [TrialCount-0.4 TrialCount+0.4], 'k');
        end
    end
    title('Raster Plot')
    xlabel('time [s]')
    ylabel('Trial')
    ylim([0 size(SpikeMat, 1)+1]);
end