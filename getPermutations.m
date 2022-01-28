function [randFeaturesSensor, randLabels] = getPermutations(labels, featuresSensor)
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here
p = randperm(size(labels,2));
randFeaturesSensor = featuresSensor(:,p);
randLabels = labels(:,p);
end

