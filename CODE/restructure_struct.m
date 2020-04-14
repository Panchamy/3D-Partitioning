function final_struct = restructure_struct(final_cluster_struct, links, links_rep, cluster, num_clusters)

num_links = length(links);
num_timeslices = length(cluster)/num_links;
final_struct = [];

if isempty(num_clusters)
    num_clusters = length(final_cluster_struct);
end

for i = 1:num_timeslices
    temp_cluster = final_cluster_struct;
    for j = 1:num_clusters
        link_indexes = find(temp_cluster(j).link_ids >= ((i-1)*num_links)+1 & temp_cluster(j).link_ids <= (i*num_links));
        if isempty(link_indexes)
            temp_cluster(j).link_ids = [];
        else
            link_ids = [temp_cluster(j).link_ids(link_indexes)];
            temp_cluster(j).link_ids = [links_rep(link_ids).id];
        end
        temp_cluster(j).time_slice = i;
    end
    final_struct(i).cluster = temp_cluster;
end

end