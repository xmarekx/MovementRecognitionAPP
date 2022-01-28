function [x, y, z] = getDataToChart(vq)
%UNTITLED16 Summary of this function goes here
%   Detailed explanation goes here
for i=1:3:21
x=vq(i,:);
y=vq(i+1,:)
z=vq(i+2,:)

end

