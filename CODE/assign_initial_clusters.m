function [ final_cluster_struct, sorted_cluster_struct ] = assign_initial_clusters( cluster_struct, num_clusters )

    if isempty(num_clusters)
        num_clusters = max([cluster_struct.cluster_id]);
    end
    cluster_ids = [cluster_struct.cluster_id];
    k = length(cluster_struct);
    final_cluster_struct = [];
    
    %sort the cluster based on the number of links
    [tmp ind]=sort([cluster_struct.num_ids]);
    sorted_cluster_struct = cluster_struct(ind);
    
    %%
    % assign the intital clusters 
    i = 1;
    while 1
        if isempty(final_cluster_struct)
            current_cluster = [];
        else
            cluster_ids = [final_cluster_struct.cluster_id];
            current_cluster = find(cluster_ids == sorted_cluster_struct(k).cluster_id);
        end
        if isempty(current_cluster)
            final_cluster_struct(i).cluster_id = sorted_cluster_struct(k).cluster_id;
            final_cluster_struct(i).link_ids = sorted_cluster_struct(k).link_ids;
            final_cluster_struct(i).speed = sorted_cluster_struct(k).speed;
            sorted_cluster_struct(k) = [];
            k = length(sorted_cluster_struct);
            i = i+1;
        else
            k = k-1;
        end
        if i > num_clusters
            break;
        end
    end

end