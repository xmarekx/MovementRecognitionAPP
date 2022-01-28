function [data] = openFile(fileName)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    fid = fopen(fileName, 'rt');
    output = textscan(fid, '%f %f %f %f %f', 'Delimiter', ' ;');
    fclose(fid);
    
    data = [output{1,1}, output{1,2}, output{1,3}, output{1,4}, output{1,5}];
end

