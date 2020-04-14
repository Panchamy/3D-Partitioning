function sorted_cluster_struct = update_cluster_struct(links, A, sorted_cluster_struct, final_cluster_struct)

if isempty(sorted_cluster_struct)
    sorted_cluster_struct = [];
else
    k = length(sorted_cluster_struct);
    for i = 1:length(sorted_cluster_struct)
        for j = 1:length(final_cluster_struct)
            current_cluster = [[sorted_cluster_struct(k).link_ids] [final_cluster_struct(j).link_ids]];
            link_indexes = find_index(links, current_cluster);
            new_A = A(link_indexes, link_indexes);
            not_connected = check_connectivity(new_A);
            if isempty(not_connected)
                sorted_cluster_struct(k).connected(j) = 1;
                %assign the speed variation here
                sorted_cluster_struct(k).var(j) = var([sorted_cluster_struct(k).speed, final_cluster_struct(j).speed]);
                sorted_cluster_struct(k).speeds(j) = mean([sorted_cluster_struct(k).speed, final_cluster_struct(j).speed]);
            else
                sorted_cluster_struct(k).connected(j) = 0;
                sorted_cluster_struct(k).var(j) = nan;
                sorted_cluster_struct(k).speeds(j) = nan;
            end
        end
        sorted_cluster_struct(k).conn_length = sum(sorted_cluster_struct(k).connected);
        k = k - 1;
    end
    %sort the cluster based on the number of links and number of connections
    % [tmp ind]=sort([cluster_struct.num_ids]);
    [tmp ind] = sortrows([{sorted_cluster_struct.num_ids}',{sorted_cluster_struct.conn_length}'], [2 1]);
    sorted_cluster_struct = sorted_cluster_struct(ind);
end


end