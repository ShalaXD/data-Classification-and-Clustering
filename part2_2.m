close all;
clear all; 
load('dim4data.mat');

result = [];
for k = 2:15
    idx = kmeans(new_fea,k);
    result = [result,idx];
end

out = clustereval(gnd, result(:,1), 'ri')


