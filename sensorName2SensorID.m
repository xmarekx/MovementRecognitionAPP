function [sensorID] = sensorName2SensorID(sensorName)
%UNTITLED17 Summary of this function goes here
%   Detailed explanation goes here
switch sensorName
        case 'accelerometer'
            sensorID = 1;
        case 'gyroscope'
            sensorID = 2;
        case 'gravity sensor'
             sensorID = 3;
        case 'linear acceleration sensor'
             sensorID = 4;
        case 'vector of geomagnetic rotation'
             sensorID = 5;
        case 'magnetic field sensor'
              sensorID = 6;
        case 'rotation vector'
              sensorID = 7;
end

