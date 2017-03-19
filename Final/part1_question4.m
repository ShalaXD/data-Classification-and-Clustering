function part1_question4() 
% x =[train_time_m,test_time_m, accuracy_m,precision_m,recall_m,...
%    F_mesure_m,correct_rate_stand_Deviation, precision_stand_Deviation,...
%    recall_stand_Deviation,F_mesure_stand_Deviation]

%% knn function 

[train_time_m1,test_time_m1, accuracy_m1,precision_m1,recall_m1,...
    F_mesure_m1,correct_rate_stand_Deviation1, precision_stand_Deviation1,...
    recall_stand_Deviation1,F_mesure_stand_Deviation1]= knn_20();

%% svm function
[train_time_m2,test_time_m2, accuracy_m2,precision_m2,recall_m2,...
    F_mesure_m2,correct_rate_stand_Deviation2, precision_stand_Deviation2,...
    recall_stand_Deviation2,F_mesure_stand_Deviation2]  = svm_20();
% decisionTree function
[train_time_m3,test_time_m3, accuracy_m3,precision_m,recall_m3,...
    F_mesure_m3,correct_rate_stand_Deviation3, precision_stand_Deviation3,...
    recall_stand_Deviation3,F_mesure_stand_Deviation3]  = decisionTree_20();
%% randomForest function
[train_time_m4,test_time_m4, accuracy_m4,precision_m4,recall_m4,...
    F_mesure_m4,correct_rate_stand_Deviation4, precision_stand_Deviation4,...
    recall_stand_Deviation4,F_mesure_stand_Deviation4]  = randomForest_20();
%% neural network function
[train_time_m5,test_time_m5, accuracy_m5,precision_m5,recall_m5,...
    F_mesure_m5,correct_rate_stand_Deviation5, precision_stand_Deviation5,...
    recall_stand_Deviation5,F_mesure_stand_Deviation5]  = neural_network_20();
%% plot all the images
x = [ [train_time_m1,test_time_m1, accuracy_m1,precision_m1,recall_m1,...
    F_mesure_m1,correct_rate_stand_Deviation1, precision_stand_Deviation1,...
    recall_stand_Deviation1,F_mesure_stand_Deviation1];
    [train_time_m2,test_time_m2, accuracy_m2,precision_m2,recall_m2,...
    F_mesure_m2,correct_rate_stand_Deviation2, precision_stand_Deviation2,...
    recall_stand_Deviation2,F_mesure_stand_Deviation2];
    [train_time_m3,test_time_m3, accuracy_m3,precision_m,recall_m3,...
    F_mesure_m3,correct_rate_stand_Deviation3, precision_stand_Deviation3,...
    recall_stand_Deviation3,F_mesure_stand_Deviation3];
    [train_time_m4,test_time_m4, accuracy_m4,precision_m4,recall_m4,...
    F_mesure_m4,correct_rate_stand_Deviation4, precision_stand_Deviation4,...
    recall_stand_Deviation4,F_mesure_stand_Deviation4];
    [train_time_m5,test_time_m5, accuracy_m5,precision_m5,recall_m5,...
    F_mesure_m5,correct_rate_stand_Deviation5, precision_stand_Deviation5,...
    recall_stand_Deviation5,F_mesure_stand_Deviation5]
    ];
%% train_time and test_time plot
figure(1);
subplot(2,1,1);
bar(x(:,1),0.3);
set(gca,'XTickLabel',{'KNN','SVM','Decision Tree','Random Forest','Neural Network'});
ylabel('Time / s');
title('Train time');
subplot(2,1,2);
bar(x(:,2),0.3);
set(gca,'XTickLabel',{'KNN','SVM','Decision Tree','Random Forest','Neural Network'});
ylabel('Time / s');
title('Test time');
%% accuracy and stand deviation
figure(2);
subplot(2,1,1);
bar(x(:,3),0.3);
set(gca,'XTickLabel',{'KNN','SVM','Decision Tree','Random Forest','Neural Network'});
ylabel('Accuracy');
title('Accuracy Index');

subplot(2,1,2);
bar(x(:,7),0.3);
set(gca,'XTickLabel',{'KNN','SVM','Decision Tree','Random Forest','Neural Network'});
ylabel('Accuracy stand deviation');
title('Accuracy stand deviation Index');

%% precision and stand deviation
figure(3);
subplot(2,1,1);
bar(x(:,4),0.3);
set(gca,'XTickLabel',{'KNN','SVM','Decision Tree','Random Forest','Neural Network'});
ylabel('Precision ');
title('Precision Index');

subplot(2,1,2);
bar(x(:,8),0.3);
set(gca,'XTickLabel',{'KNN','SVM','Decision Tree','Random Forest','Neural Network'});
ylabel('Precision stand deviation');
title('Precision stand deviation Index');

%% recall and stand deviation
figure(4);
subplot(2,1,1);
bar(x(:,5),0.3);
set(gca,'XTickLabel',{'KNN','SVM','Decision Tree','Random Forest','Neural Network'});
ylabel('Recall');
title('Recall Index');

subplot(2,1,2);
bar(x(:,9),0.3);
set(gca,'XTickLabel',{'KNN','SVM','Decision Tree','Random Forest','Neural Network'});
ylabel('Recall stand deviation');
title('Recall stand deviation Index');

%% f- and stand deviation
figure(5);
subplot(2,1,1);
bar(x(:,6),0.3);
set(gca,'XTickLabel',{'KNN','SVM','Decision Tree','Random Forest','Neural Network'});
ylabel('F-Measure');
title('F-Measure Index');

subplot(2,1,2);
bar(x(:,10),0.3);
set(gca,'XTickLabel',{'KNN','SVM','Decision Tree','Random Forest','Neural Network'});
ylabel('F-Measure stand deviation');
title('F-Measure stand deviation Index');
end