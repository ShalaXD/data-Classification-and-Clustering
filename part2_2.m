
function part2_2()
    close all;
    clear all; 
    load('dim4data.mat');

    separation_index_all = [];
    rand_index_all = [];
    f_measure_all = [];
    for k = 2:15
        result = kmeans(new_fea,k);
        separation_index = get_separated_index(new_fea,result,k);
        rand_index = get_rand_index(gnd,result);
        table1 = crosstab(result,gnd);
        f_measure = getFmesure(table1);

        separation_index_all = [separation_index_all,separation_index];
        rand_index_all = [rand_index_all,rand_index];
        f_measure_all = [f_measure_all,f_measure];
    end
    separation_index_all;
    rand_index_all
    f_measure_all;
    x = 2:15;
    figure
    plot(x,separation_index_all,'b-o')
    title('separation index for k')
    xlabel('k clusters')
    ylabel('separation index')

    figure
    plot(x,rand_index_all,'b-o')
    title('randi index for k')
    xlabel('k clusters')
    ylabel('rand index')  

    figure
    plot(x,f_measure_all,'b-o')
    title('separation index for k')
    xlabel('k clusters')
    ylabel('f-measure')
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


