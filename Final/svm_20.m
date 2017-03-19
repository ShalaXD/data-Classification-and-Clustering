%% do classification using Neural Netork <default setup> Part1-4
%% run randomForest 20 times and get mean values and stand deviation
%% fro train_time, test_time, correct_rate, precision, recall, F_mesure
function [train_time_m,test_time_m, accuracy_m,precision_m,recall_m,...
    F_mesure_m,correct_rate_stand_Deviation, precision_stand_Deviation,...
    recall_stand_Deviation,F_mesure_stand_Deviation] = svm_20()
disp('Run SVM function...');
load('Z-normalized.mat');
train_label = train_gnd;
test_label = test_gnd;
% replace label -1 with 0 so the cp could work out the accuracy
train_label( train_label == -1 )=0;
test_label( test_label == -1) =0;

%% use k as 5 and repeat 20 times
train_time = [];
test_time =[];
precision = [];
recall = [];
F_mesure =[];
k =5;
accuracy_all = [];
cm = [];
for i = 1:20
    tic;
    SVMmodel = svmTrain(train_label,train_data,sprintf('-c %f -g %f', 10, 0.01));
    %Mdl1 = fitcknn(train_data,train_label,'NumNeighbors',k);
    t1= toc;
    train_time = [train_time, t1];
    tic;
    [classes,accuracy,prob_estimate] = svmpredict(test_label,test_data, SVMmodel);
    %classes = predict(Mdl1,test_data);
    t2 = toc;
    test_time = [test_time, t2];

    [c,cm,ind,per] = confusion(test_label',classes');
    precision_s = cm(1,1)/(cm(1,1)+cm(2,1));
    recall_s = cm(1,1)/(cm(1,1)+cm(2,2));
    precision = [precision, precision_s];
    recall = [recall, recall_s];
    f = 2 * precision_s * recall_s / (precision_s + recall_s);
    F_mesure = [F_mesure, f];
    accuracy_all = [accuracy_all; accuracy(1,:)];
    
end
train_time_m = mean(train_time)
test_time_m = mean(test_time)
accuracy_m = mean(accuracy_all)
precision_m = mean(precision)
recall_m = mean (recall)
F_mesure_m = mean(F_mesure)
correct_rate_stand_Deviation = std2(accuracy_all) 
precision_stand_Deviation = std2(precision)
recall_stand_Deviation = std2(recall)
F_mesure_stand_Deviation = std2(F_mesure)
end