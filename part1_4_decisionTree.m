%% do classification using Decision Tree <default setup> 
close all;
clc;
load('Z-normalized.mat');
train_gnd( train_gnd == -1)=0;
test_gnd(test_gnd == -1)=0;
tic
Md = fitctree( train_data, train_gnd);
train_time = toc
tic
classes = predict(Md,test_data);
test_time = toc
[c,cm,ind,per] = confusion(test_gnd',classes');
correct_rate = 1-c
precision = cm(1,1)/(cm(1,1)+cm(2,1))
recall = cm(1,1)/(cm(1,1)+cm(2,2))
F_mesure = 2 * precision * recall / (precision + recall)

