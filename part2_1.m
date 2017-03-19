
function part2_1()
clear all;
load('DataF.mat');
gnd = gnd +1;
%% use PCA to reduce the dimension
[COEFF,SCORE,latent,tsquare] = pca(fea);
new_fea = SCORE(:,1:4);
c1=useWard(new_fea);
c2=useSigle(new_fea);
c3=useComplete(new_fea);

%table = crosstab(c3,gnd)
%f_f=getFmesure(table)

f_s1 = getSeparateIndex( new_fea, c1);
f_s1;
[Acc1,rand_index1,match1]=AccMeasure(gnd,c1);
rand_index1
out = clustereval(gnd, c1, 'randindex');
out

table1 = crosstab(c1,gnd);
f_f1=getFmesure(table1)



f_s2 = getSeparateIndex( new_fea, c2);
f_s2;
[Acc2,rand_index2,match2]=AccMeasure(gnd,c2);
rand_index2;
table2 = crosstab(c2,gnd);
f_f2=getFmesure(table2)

f_s3 = getSeparateIndex( new_fea, c3);
f_s3;
[Acc3,rand_index3,match3]=AccMeasure(gnd,c3);
rand_index3;
table3 = crosstab(c3,gnd);
f_f3=getFmesure(table3)


end 

function c = useWard(x)
Z = linkage(x,'ward','euclidean');
c = cluster(Z,'maxclust',10);
end

function c = useSigle(x)
Z = linkage(x,'single');
c = cluster(Z,'maxclust',10);
end

function c = useComplete(x)
Z = linkage(x,'complete','euclidean');
c = cluster(Z,'maxclust',10);
end

function f= getFmesure(t)
t_colum = repmat(sum(t,2),1,size(t,2));
t_row = repmat(sum(t,1),size(t,1),1);

precision = t./t_colum;
recall = t./t_row;
F_mesure = 2*precision.*recall./(precision+recall);
F_mesure(isnan(F_mesure)) = 0;
max_row = max(F_mesure);
n = sum(sum(t));
f = sum(t_row(1,:).*max_row)/n;
end

function f = getSeparateIndex( fea_new, labels)
fea_mean = [];
for i = 1:10
    fea_tmp = fea_new(labels==i,:);
    if size(fea_tmp,1)>1
        fea_tmp = mean(fea_tmp);
    end
    fea_mean = [fea_mean; fea_tmp];
end 
m = 10;
c = 2/(m^2-m);
D = abs(pdist(fea_mean));
f = c*sum(sum(D));
end

function f = getRandIndex (targets, predicts)
cm = crosstab(predicts,targets);
f = value/sum(sum(cm));
end 


