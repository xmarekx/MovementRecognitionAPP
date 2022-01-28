function [labels, timeSeriesVect] = getLabels(data,timeStamps)
timeSeriesVect = 0:10:max(data(:,2));
    vq = zeros(7*3, size(timeSeriesVect,2));
    
    labels = (timeSeriesVect <= timeStamps(1))*1 + ...
        (timeSeriesVect >= timeStamps(1) & (timeSeriesVect < timeStamps(2)))*2 + ...
        (timeSeriesVect >= timeStamps(2) & (timeSeriesVect < timeStamps(3)))*3 + ...
        (timeSeriesVect >= timeStamps(3))*4;
end

