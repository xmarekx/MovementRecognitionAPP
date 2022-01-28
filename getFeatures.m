function features = getFeatures(signal, windowLength, windowOverlap)

subframesCount = round(size(signal,2)/(windowLength - windowOverlap));
features = zeros([210, subframesCount]);

index = 1;
for j=1:size(signal,1)
    buffSignal = buffer(signal(j,:), windowLength, windowOverlap);
    for k=1:size(buffSignal,2)
        temp = buffSignal(:,k);
        features(index,k) = max(temp);
        features(index+1,k) = min(temp);
        features(index+2,k) = mean(temp);
        features(index+3,k) = std(temp);
        features(index+4,k) = prctile(temp, 20);
        features(index+5,k) = prctile(temp, 50);
        features(index+6,k) = prctile(temp, 80);
        features(index+7,k) = skewness(temp);
        features(index+8,k) = kurtosis(temp);
        features(index+9,k) = rms(temp);
    end
    index = index + 10;
end
end