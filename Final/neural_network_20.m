%% do classification using Neural Netork <default setup> Part1-4
%% run randomForest 20 times and get mean values and stand deviation
%% fro train_time, test_time, correct_rate, precision, recall, F_mesure
function [train_time_m,test_time_m, accuracy_m,precision_m,recall_m,...
    F_mesure_m,correct_rate_stand_Deviation, precision_stand_Deviation,...
    recall_stand_Deviation,F_mesure_stand_Deviation] = neural_network_20()
disp('Run neural network...');
load('Z-normalized.mat');
train_gnd(train_gnd == -1) =0;
test_gnd (test_gnd == -1) =0;

x = [];
train_time_m = [];
test_time_m = [];
c_m = [];
precision_m = [];
recall_m = [];
F_mesure_m = [];
for num= 1:20
    [train_time, test_time, c, precision, recall, F_mesure]=...
    useNeuralNet(train_data', train_gnd',test_data', test_gnd');
    %sprintf('Num: %f, Error percent:%f',num ,correct_rate)
    x = [x, num];
    train_time_m = [train_time_m, train_time];
    test_time_m = [test_time_m, test_time];
    c_m =[c_m , 1-c];
    precision_m = [precision_m, precision];
    recall_m = [recall_m, recall];
    F_mesure_m = [F_mesure_m, F_mesure];
end

train_time_m = mean(train_time_m);
test_time_m = mean (test_time_m);

correct_rate_stand_Deviation = std2(c_m) ;
accuracy_m = mean (c_m);

precision_stand_Deviation = std2(precision_m);
precision_m = mean (precision_m);

recall_stand_Deviation = std2(recall_m);
recall_m = mean(recall_m);

F_mesure_stand_Deviation = std2(F_mesure_m);
F_mesure_m = mean(F_mesure_m);
end

function [train_time, test_time, c, precision, recall, F_mesure]=...
    useNeuralNet(train_data, train_gnd,test_data, test_gnd)
tic
trainFcn = 'trainscg';  % Scaled conjugate gradient backpropagation.
hiddenLayerSize =30;
net = patternnet(hiddenLayerSize);
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
net.trainParam.showWindow = false;
net.trainParam.showCommandLine = false;
[net,tr] = train(net,train_data,train_gnd);
train_time = toc;
% Test the Network
tic
pridictes = net(test_data);
test_time = toc;
pridictes(pridictes>0.5) = 1;
pridictes(pridictes<=0.5) = 0;
%figure, plotconfusion(test_gnd,pridictes);
[c,cm,ind,per] = confusion(test_gnd,pridictes);
precision = cm(1,1)/(cm(1,1)+cm(2,1));
recall = cm(1,1)/(cm(1,1)+cm(2,2));
F_mesure = 2 * precision * recall / (precision + recall);
end


