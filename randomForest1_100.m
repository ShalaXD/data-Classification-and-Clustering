%% do classification using Random Forest <default setup>
%% run randomForest, change tree numbers from 1 to 100, get values
%% of train_time, test_time, correct_rate, precision, recall, F_mesure 
%% plot them

function randomForest1_100()
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
for num= 1:100
    [train_time, test_time, c, precision, recall, F_mesure]=...
        useTreeBagger(num, train_data, train_gnd,test_data, test_gnd);
    %sprintf('Num: %f, Error percent:%f',num ,correct_rate)
    x = [x, num];
    train_time_m = [train_time_m, train_time];
    test_time_m = [test_time_m, test_time];
    c_m =[c_m , 1-c];
    precision_m = [precision_m, precision];
    recall_m = [recall_m, recall];
    F_mesure_m = [F_mesure_m, F_mesure];
end
subplot(3, 2, 1), plot(x, train_time_m), title('Train time'),xlabel('Nunmber of tress'), ylabel('Train time(s)'), grid on;
subplot(3, 2, 2), plot(x, test_time_m), title('Test time'),xlabel('Nunmber of tress'), ylabel('Test time(s)'), grid on;

subplot(3, 2, 3), plot(x, c_m), title('Correct rate'),xlabel('Nunmber of tress'), ylabel('Correct rate'), grid on;
subplot(3, 2, 4), plot(x, precision_m), title('Precision'),xlabel('Nunmber of tress'), ylabel('Precision'), grid on;

subplot(3, 2, 5), plot(x, recall_m), title('Recall'),xlabel('Nunmber of tress'), ylabel('Recall rate'), grid on;
subplot(3, 2, 6), plot(x, F_mesure_m), title('F_mesure'),xlabel('Nunmber of tress'), ylabel('F-mesure'), grid on;
% plot(x, test_time_m);
% plot(x, c_m);
% plot(x, precision_m);
% plot(x, recall_m);
% plot(x, F_mesure_m);

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


