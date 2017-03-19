close all;
clear all;

load('Z-normalized.mat');
train_data = train_data;
train_label = train_gnd;
% replace label -1 with 0 so the cp could work out the accuracy
train_label( train_label==-1 )=0; 
accuracy_all = [];
indices = crossvalind('Kfold',train_label,5);

%% calculate knn from k=1 to k=31 
for i = 1:2:31
    accuracy = [];
    for j = 1:5
        % select each fold as test set and iterate
        test = (indices == j); train = ~test;
        Mdl1 = fitcknn(train_data(train,:),train_label(train,:),'NumNeighbors',i);
        classes = predict(Mdl1,train_data(test,:));
        cp = classperf(train_label(test,:),classes);
        accuracy = [accuracy,cp.CorrectRate];
    end
    accuracy_all = [accuracy_all,mean(accuracy)];
end

% plot image
x = [1:2:31];
plot(x,accuracy_all,'b-o');
title('Accuracy for different k in KNN classifier')
xlabel('k')
ylabel('Accuracy')


