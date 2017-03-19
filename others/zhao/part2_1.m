
function part2_1()
clear all;
load('DataF.mat');
gnd = gnd +1;
%% use PCA to reduce the dimension
[COEFF,SCORE,latent,tsquare] = pca(fea);
new_fea = SCORE(:,1:4);
c1=useWard(new_fea,10);
c2=useSigle(new_fea);
c3=useComplete(new_fea);
x =[];
%% ward
f_s1 = get_separated_index(new_fea, c1, 10);

[Acc1,rand_index1,match1]=AccMeasure(gnd,c1);
table1 = crosstab(c1,gnd);
f_f1=getFmesure(table1);
x = [x; f_s1,rand_index1, f_f1];
%% sigle
f_s2 = get_separated_index(new_fea, c2, 10);

[Acc2,rand_index2,match2]=AccMeasure(gnd,c2);
table2 = crosstab(c2,gnd);
f_f2=getFmesure(table2);
x = [x; f_s2,rand_index2, f_f2];
%% complete
f_s3 = get_separated_index(new_fea, c3, 10);

[Acc3,rand_index3,match3]=AccMeasure(gnd,c3);
table3 = crosstab(c3,gnd);
f_f3=getFmesure(table3);
x = [x; f_s3,rand_index3, f_f3];

%% bar
figure(12);
subplot(3,1,1);
bar(x(:,1),0.2);
set(gca,'XTickLabel',{'Ward','Single','Complete'});
ylabel('Separation Index');
title('Separation Index');

subplot(3,1,2);
bar(x(:,2),0.2);
set(gca,'XTickLabel',{'Ward','Single','Complete'});
ylabel('Rand Index');
title('Rand Index');

subplot(3,1,3);
bar(x(:,3),0.2);
set(gca,'XTickLabel',{'Ward','Single','Complete'});
ylabel('F-Measure');
title('F-Measure');

c_20 = [];
s = [];
f = [];
for i = 2:15
    c1=useWard(new_fea,i);
    c_20 = [c_20, c1];
    s1 = get_separated_index( new_fea, c1,i)
    table1 = crosstab(c1,gnd);
    f1=getFmesure(table1);
    f = [f, f1];
    s = [s, s1];
end
figure(13);
plot([2:1:15], s);
hold on;
plot([2:1:15], s,'o');
xlabel('K values');
ylabel('Separation index');
title('Separation indexes @different K values');
end 
function c = useWard(x, k )
Z = linkage(x,'ward','euclidean');
c = cluster(Z,'maxclust',k);
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

function si = get_separated_index(new_fea,result,k)
    dist_sum = 0;
    dist_min = inf;
    for i = 1:k
        index = find(result==i);
        current_cluster = new_fea(index,:);
        index = find(result~=i);
        rest = new_fea(index,:);
        dis_to_center = pdist2(current_cluster,mean(current_cluster,1)).^2;
        sum_to_center = sum(dis_to_center);
        dist_sum = dist_sum + sum_to_center;
        dist_cluster = pdist2(current_cluster,rest);
        dist_min = min([min(dist_cluster),dist_min]);
    end
    si = dist_sum/(length(new_fea(:,1))*dist_min);
end


