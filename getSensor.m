function [sensorData, timeStamps] = getSensor(sensor, data)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    indexStamps = find(data(:, 1) == -1);
    timeStamps = data(indexStamps, 2);
    sen{1} = data(find(data(:, 1) == 0),:);
    sen{2} = data(find(data(:, 1) == 1),:);
    sen{3} = data(find(data(:, 1) == 2),:);
    sen{4} = data(find(data(:, 1) == 3),:);
    sen{5} = data(find(data(:, 1) == 4),:);
    sen{6} = data(find(data(:, 1) == 5),:);
    sen{7} = data(find(data(:, 1) == 6),:);
    switch sensor
        case 1
            sensorData=sen{1};
        case 2
            sensorData=sen{2};
        case 3
            sensorData=sen{3};
        case 4
            sensorData=sen{4};
        case 5
            sensorData=sen{5};
        case 6
            sensorData=sen{6};
        case 7
            sensorData=sen{7};
        otherwise 
            warning('POIG131:WARN_NO_GYRO_DATA_IN_FILE',sprintf('No data from gyroscope ID=%d found!',gyr.id));
            sensorData=null;
end

