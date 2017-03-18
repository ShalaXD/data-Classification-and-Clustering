%% do classification using Random Forest <default setup>
%% run randomForest 20 times and get mean values and stand deviation
%% fro train_time, test_time, correct_rate, precision, recall, F_mesure 

function randomForest()
close all;
clc;
load('Z-normalized.mat');
train_gnd( train_gnd == -1)=0;
test_gnd(test_gnd == -1)=0;
x = [];
train_time_m = [];
test_time_m = [];
c_m = [];
precision_m = [];
recall_m = [];
F_mesure_m = [];
for num= 1:20
    [train_time, test_time, c, precision, recall, F_mesure]=...
        useTreeBagger(20, train_data, train_gnd,test_data, test_gnd);
    %sprintf('Num: %f, Error percent:%f',num ,correct_rate)
    x = [x, num];
    train_time_m = [train_time_m, train_time];
    test_time_m = [test_time_m, test_time];
    c_m =[c_m , 1-c];
    precision_m = [precision_m, precision];
    recall_m = [recall_m, recall];
    F_mesure_m = [F_mesure_m, F_mesure];
end
%plot(x, c_rate);
train_time_mean = mean(train_time_m)
test_time_mean = mean (test_time_m)
correct_rate = mean (c_m)
correct_rate_stand_Deviation = std2(c_m) 
precision_mean = mean (precision_m)
precision_stand_Deviation = std2(precision_m)
recall_mean = mean(recall_m)
recall_stand_Deviation = std2(recall_m)
F_mesure_mean = mean(F_mesure_m)
F_mesure_stand_Deviation = std2(F_mesure_m)
end
    
function [train_time, test_time, c, precision, recall, F_mesure]=...
    useTreeBagger(num, train_data, train_gnd,test_data, test_gnd)
tic;
Md = TreeBagger(num,train_data, train_gnd);
train_time = toc;
tic;
classes = predict(Md,test_data);
classes = cellfun(@str2num, classes);
test_time = toc;
[c,cm,ind,per] = confusion(test_gnd',classes');
precision = cm(1,1)/(cm(1,1)+cm(2,1));
recall = cm(1,1)/(cm(1,1)+cm(2,2));
F_mesure = 2 * precision * recall / (precision + recall);
end


