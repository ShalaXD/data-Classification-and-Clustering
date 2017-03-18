close all;
clear all; 
load('Z-normalized.mat');
train_data = train_data;
train_label = train_gnd;
% replace label -1 with 0 so the cp could work out the accuracy
train_label( train_label==-1 )=0; 
c = [0.1, 0.5, 1, 2, 5, 10, 20, 50];
sigma = [0.01, 0.05, 0.1, 0.5, 1, 2, 5, 10];
accuracy_all = zeros(8);
indices = crossvalind('Kfold',train_label,5);

%% caculate accuracy for different parameters 
for j = 1:8
    for k = 1:8
        accuracy = [];
        for i = 1:5
            test = (indices == i); train = ~test;
            Mdlsvm=svmtrain(train_data(train,:),train_label(train,:),'Kernel_Function','rbf','BoxConstraint',c(j),'rbf_sigma',sigma(k));
            classes = svmclassify(Mdlsvm,train_data(test,:));
            cp = classperf(train_label(test,:),classes);
            accuracy = [accuracy,cp.CorrectRate];
        end
        accuracy_all(j,k) = mean(accuracy);
    end
end

%% find the best accuracy and its location
[num idx] = max(accuracy_all(:));
[x y] = ind2sub(size(accuracy_all),idx);
best_accuracy = num;
best_pairs = [c(x),sigma(y)]

%% plot the ROC curves
        
Mdlsvm=svmtrain(train_data(train,:),train_label(train,:),'Kernel_Function','rbf','BoxConstraint',c(x),'rbf_sigma',sigma(y));
[classes,score] = svmclassify(Mdlsvm,train_data(test,:));
plotroc(train_label(test,:) ,classes);
