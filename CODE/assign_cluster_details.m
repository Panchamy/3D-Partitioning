function [cluster_struct, k] = assign_cluster_details(cluster_struct, new_links, new_speed, i, k)
    cluster_struct(k).cluster_id = i;
    cluster_struct(k).link_ids = [new_links.index];
%     cluster_struct(k).time_slice = j;
    cluster_struct(k).speed = mean(new_speed);
    cluster_struct(k).num_ids = length(new_links);
    k = k+1;
end