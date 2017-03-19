%% autoencoder
load('Z-normalized.mat');
x = train_data';
y = train_gnd';
y(y == -1) =0;
t = test_data';
m = test_gnd';
m(m == -1) = 0;
%% first layer training, hiddenSize1 == 30
hiddenSize1 = 30;
rng('default');
autoenc1 = trainAutoencoder(x,hiddenSize1, ...
    'MaxEpochs',150, ...
    'L2WeightRegularization',0.004, ...
    'SparsityRegularization',4, ...
    'SparsityProportion',0.15, ...
    'ScaleData', false);

%% the send layer training 
feat1 = encode(autoenc1,x);
hiddenSize2 = 15;
autoenc2 = trainAutoencoder(feat1,hiddenSize2, ...
    'MaxEpochs',100, ...
    'L2WeightRegularization',0.002, ...
    'SparsityRegularization',4, ...
    'SparsityProportion',0.1, ...
    'ScaleData', false);
%% the third layer: Training the final softmax layer
feat2 = encode(autoenc2,feat1);
softnet = trainSoftmaxLayer(feat2,y,'MaxEpochs',100);
% view(autoenc1);
% view(autoenc2);
% view(softnet);
%% Form a deep network
deepnet = stack(autoenc1,autoenc2,softnet);
% view(deepnet);
results = deepnet(t);
[c,cm,ind,per] = confusion(m,results);
sprintf('Correct rate:%f',1-c)
plotconfusion(m,results);
















