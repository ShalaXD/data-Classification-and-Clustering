load 'DataD.mat';

%Z-Score normalization

data_new = zscore(fea);

%split the normalized data into two halves

train_data = data_new(1:1100,:);
train_gnd = gnd(1:1100,:);
test_data = data_new(1101:2200,:);
test_gnd = gnd(1101:2200,:);

save('Z-normalized','train_data','train_gnd','test_data','test_gnd');
