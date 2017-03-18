close all;
clear all; 
load('DataF.mat');

%% use PCA to reduce the dimension
[COEFF,SCORE,latent,tsquare] = pca(fea);
new_fea = SCORE(:,1:4);

%[mappedX, mapping] = pca2(fea, 4); 

save('dim4data','new_fea','gnd');