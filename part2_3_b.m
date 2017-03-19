function part2_3_b()
close all;
clear all; 
load('dim4data.mat');
%% cluster the data by setting the max membership value to be 1 and the rest to be 0
options = [2.0 NaN NaN 0];
[centers,U] = fcm(new_fea,10,options);
Q = max(U);
for i = 1:size(new_fea,1)
    U(U == Q(i)) = 1;
end
U(U ~= 1) = 0;
[ROW,COL] = find(U == 1);
result = ROW';
%% evaluate clustering results
rand_index1 = get_rand_index(gnd,result);%rand index
table1 = crosstab(result,gnd);
f_measure1 = getFmesure(table1); %f-measure
separation_index1 = get_separated_index(new_fea,result,10);%seperation index

%% compare with kmeans while k = 10
k=10;
result2 = kmeans(new_fea,k);
separation_index2 = get_separated_index(new_fea,result2,k);
rand_index2 = get_rand_index(gnd,result2);
table2 = crosstab(result2,gnd);
f_measure2 = getFmesure(table2);

%% plot bar graph 
x = [separation_index1,rand_index1,f_measure1; separation_index2,rand_index2,f_measure2]; 

figure(1);
subplot(1,3,1);
bar(x(:,1),0.2);
set(gca,'XTickLabel',{'Fuzzy C-Means','K-Means'});
ylabel('Separation Index');

subplot(1,3,2);
bar(x(:,2),0.2);
set(gca,'XTickLabel',{'Fuzzy C-Means','K-Means'});
ylabel('Rand Index');

subplot(1,3,3);
bar(x(:,3),0.2);
set(gca,'XTickLabel',{'Fuzzy C-Means','K-Means'});
ylabel('F_Measure');



end

function si = get_separated_index(new_fea,result,k)
    dist_sum = 0;
    dist_min = inf;
    for i = 1:k
        index = find(result==i);
        current_cluster = new_fea(index,:);
        index = find(result~=i);
        rest = new_fea(index,:);
        dis_to_center = pdist2(current_cluster,mean(current_cluster)).^2;
        sum_to_center = sum(dis_to_center);
        dist_sum = dist_sum + sum_to_center;
        dist_cluster = pdist2(current_cluster,rest);
        dist_min = min([min(dist_cluster),dist_min]);
    end
    si = dist_sum/(length(new_fea(:,1))*dist_min);
end

function f = getFmesure(t)
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

function ri = get_rand_index(gnd,result)
    n = length(gnd);
    rand_ss1=0;
    rand_dd1=0;
    for xi=1:n-1
        for xj=xi+1:n
            rand_ss1=rand_ss1+((result(xi)==result(xj))&&(gnd(xi)==gnd(xj)));
            rand_dd1=rand_dd1+((result(xi)~=result(xj))&&(gnd(xi)~=gnd(xj)));
        end
    end
    ri=2*(rand_ss1+rand_dd1)/(n*(n-1));
end


