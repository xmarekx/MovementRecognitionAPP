function [labelsOut, featuresSensor] = makeFeatures(vq,labels,windowLength,windowOverlap)
if windowLength==0
    windowLength = 50;
end
if windowOverlap==0
    windowOverlap= 25;
end
 buffLabels = buffer(labels, windowLength, windowOverlap);
    
    labelsNew = [];
    featuresSensor = [];
    
    labelsNew = [labelsNew buffLabels((windowLength/2),:)];
    labelsNew = uint8(labelsNew);
    featuresSensor = [featuresSensor getFeatures(vq, windowLength, windowOverlap)];
    
    labelsNew(labelsNew == 0) = 1;
    labelsOut = zeros([4, size(labelsNew,2)]);
    for position=1:size(labelsNew,2)
        labelsOut(labelsNew(position), position) = 1;
    end
end

