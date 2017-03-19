close all;
clear all; 
load('dim4data.mat');

%% cluster the data
M = [2.0];
options = [M NaN NaN 0];
[centers,U] = fcm(new_fea,10,options);

%% find the average cluster membership values for digit1 and digit8
oneclass = find(gnd == 1);
eightclass = find(gnd == 8);
index1 = U(:,oneclass);
index8 = U(:,eightclass);
avg1 = mean(index1,2);
avg8 = mean(index8,2);

%% plot the bar graph 
y = [avg1,avg8];
bar(y);
legend('digit1','digit8');


