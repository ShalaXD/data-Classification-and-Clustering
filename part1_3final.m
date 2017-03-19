close all;
clear all; 
load('Z-normalized.mat');

train_label = train_gnd;
test_label = test_gnd;

% replace label -1 with 0 so the cp could work out the accuracy
train_label( train_label==-1 )=0; 
c = [0.1, 0.5, 1, 2, 5, 10, 20, 50];
sigma = [0.01, 0.05, 0.1, 0.5, 1, 2, 5, 10];
Accuracy_all = zeros(8);
indices = crossvalind('Kfold',train_label,5);
 
%% caculate accuracy for different parameters 
for j = 1:8
    for k = 1:8
        Accuracy = [];
        for i = 1:5
            test = (indices == i); train = ~test;
            SVMmodel = svmTrain(train_label(train,:),train_data(train,:),sprintf('-c %f -g %f', c(j), sigma(k)));
            [predict_label,accuracy,prob_estimate] = svmpredict(train_label(test,:),train_data(test,:), SVMmodel);
            Accuracy = [Accuracy;accuracy(1)];
        end
        Accuracy_all(j,k) = mean(Accuracy);
    end
end

%% find the best accuracy and its location
[num idx] = max(Accuracy_all(:));
[x y] = ind2sub(size(Accuracy_all),idx);
best_Accuracy = num;
best_pairs = [c(x),sigma(y)]

%% plot the ROC curves
SVMmodel = svmTrain(train_label(train,:),train_data(train,:),sprintf('-c %f -g %f', c(x), sigma(y)));
[predict_label,accuracy,prob_estimate] = svmpredict(train_label(test,:),train_data(test,:), SVMmodel);
[tpr,fpr,thresholds] = roc([train_label(test,:)].', prob_estimate');
figure;
plotroc([train_label(test,:)].', prob_estimate');