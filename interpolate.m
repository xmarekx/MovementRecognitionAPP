function [vq] = interpolate(sensorData, timeSeriesVect)
    for i=1:3:21
        [C,ia,ic] = unique(sensorData(:,2));
        vq(i,:) = interp1(sensorData(ia,2),sensorData(ia,3),timeSeriesVect,'linear','extrap');
        vq(i+1,:) = interp1(sensorData(ia,2),sensorData(ia,4),timeSeriesVect,'linear','extrap');
        vq(i+2,:) = interp1(sensorData(ia,2),sensorData(ia,5),timeSeriesVect,'linear','extrap');
    end
   
end

