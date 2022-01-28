function accuracy = corssValidation(buffIndexes, randFeaturesSensor, randLabels, groups,hiddenSizeLayers)
%UNTITLED14 Summary of this function goes here
%   Detailed explanation goes here

accuracy = [];
for i=1:groups
    teachingSet = buffIndexes;
    testSet = buffIndexes(:,i);
    teachingSet(:,i) = [];
    
    %% Inicjalizacja i uczenie sieci
    net = feedforwardnet(hiddenSizeLayers);
    net = train(net,randFeaturesSensor(:, teachingSet), randLabels(:, teachingSet));
    
    %% Testowanie sieci
    y = net(randFeaturesSensor(:, testSet));
    
    [~, Iy] = max(y);
    [~, Ilabels] = max(randLabels(:, testSet));
  
    %% Tablica pomyłek
%     figure
%     plotconfusion(categorical(Iy),categorical(Ilabels))
   
    %% Pseudomiara
    accuracy = [accuracy sum(Iy == Ilabels)/size(Iy,2)];
    
    
end
end

