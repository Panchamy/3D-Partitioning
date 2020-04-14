function final_cluster_struct = assign_other_clusters(links, A, sorted_cluster_struct, final_cluster_struct)

sorted_cluster_struct = update_cluster_struct(links, A, sorted_cluster_struct, final_cluster_struct);

% assign the rest of the clusters 
k = length(sorted_cluster_struct);

while 1   
    if isempty(sorted_cluster_struct)
       break;
    else      
        [val, ind] = min(sorted_cluster_struct(k).var);
        final_cluster_struct(ind).link_ids = [final_cluster_struct(ind).link_ids, sorted_cluster_struct(k).link_ids];
        final_cluster_struct(ind).var = sorted_cluster_struct(k).var(ind);
        link_indexes = find_index(links, final_cluster_struct(ind).link_ids);
        new_A = A(link_indexes, link_indexes);
        not_connected = check_connectivity(new_A);
        if isempty(not_connected)
            sorted_cluster_struct(k) = [];
            sorted_cluster_struct = update_cluster_struct(links, A, sorted_cluster_struct, final_cluster_struct);
            k = length(sorted_cluster_struct);
        else
            break;
        end    
    end
end

end