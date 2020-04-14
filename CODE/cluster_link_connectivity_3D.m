function [cluster_struct, links_rep] = cluster_link_connectivity_3D(A, cluster, speed, links)
    
    num_links = length(links);
    num_clusters = max(cluster);
    num_timeslices = length(cluster)/num_links;
    k = 1;
    cluster_struct = [];
    %%
    links_rep = links;
    for i = 1:num_timeslices-1
        links_rep(end+1:end+num_links) = links;
    end
    
    for i = 1:length(links_rep)
        links_rep(i).index = i; 
    end
    %%
    for i = 1:num_clusters
        current_cluster = find(cluster(:) == i);
        new_links = links_rep(current_cluster);
        new_A = A(current_cluster, current_cluster);
        new_speed = speed(current_cluster);
        cluster_queue = [links_rep(current_cluster).index];
        
        if isempty(current_cluster)
            continue;
        else
            while 1

                if isempty(cluster_queue)
                    break;
                end
                
                new_links = add_link_neighbors(new_links);
                not_connected = check_connectivity(new_A);

                if isempty(not_connected)
                    %remove these links from cluster queue
                    cluster_queue = setdiff(cluster_queue, [new_links.index]);  
                    [cluster_struct, k] = assign_cluster_details(...
                        cluster_struct, new_links, new_speed, i, k);
                    %update the current cluster based on cluster_queue
                    current_cluster = find_index(links_rep, cluster_queue);
                    new_links = links_rep(current_cluster);
                    new_A = A(current_cluster, current_cluster);
                    new_speed = speed(current_cluster);
                else
                    %update the current_cluster
%                     connected = setdiff([1:length(new_links)], not_connected);
%                     [cluster_struct, k] = assign_cluster_details(...
%                         cluster_struct, new_links(connected), new_speed, i, k);
%                     cluster_queue = setdiff(cluster_queue, [new_links(connected).index]);
                    current_cluster = not_connected;
                    new_links = new_links(current_cluster);
                    new_A = new_A(current_cluster, current_cluster);
                    new_speed = new_speed(current_cluster);
                end
            end
        end
    end
    
end