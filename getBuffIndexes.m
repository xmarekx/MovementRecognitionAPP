function buffIndexes= getBuffIndexes(randFeaturesSensor,groups)
%UNTITLED13 Summary of this function goes here
%   Detailed explanation goes here
if groups==0
    groups = 5;
end

indexes = 1:size(randFeaturesSensor,2);

buffIndexes = buffer(indexes, floor(size(indexes,2)/groups));
    if(size(buffIndexes) > groups)
        buffIndexes(:,end) = [];
    end
end

