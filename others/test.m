load iris_dataset
net = patternnet(20);
net = train(net,irisInputs,irisTargets);
irisOutputs = sim(net,irisInputs);
[tpr,fpr,thresholds] = roc(irisTargets,irisOutputs);
plotroc(irisTargets,irisOutputs)

[X,Y] = perfcurve(train_label(test,:),scores,posclass)

