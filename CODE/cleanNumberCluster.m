function [clusters] = cleanNumberCluster(clusters)

actual_num = unique(clusters);
for i = 1:length(clusters)
    clusters(i) = find(actual_num==clusters(i));
end

end