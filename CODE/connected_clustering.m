function PT_Kmeans = connected_clustering(KmeansClust, links, speed, A, num_clusters)

num_days = length(KmeansClust);
PT_Kmeans = struct('cluster', {}, 'toc', {});

for i = 1:num_days

    cluster = KmeansClust(i).c;
    original_num_clusters =length(unique(cluster));
    speed_c = speed(i).S;
    [cluster_struct, links_rep] = cluster_link_connectivity_3D(A, cluster, speed_c, links);
    
    if num_clusters >= original_num_clusters
        num_clusters = original_num_clusters;
    end
    tic;
    % Post Treatment
    [ final_cluster_struct, sorted_cluster_struct ] = assign_initial_clusters( cluster_struct, num_clusters );
    final_cluster_struct = assign_other_clusters(links_rep, A, sorted_cluster_struct, final_cluster_struct);
    final_struct = restructure_struct(final_cluster_struct, links, links_rep, cluster, num_clusters);
    
    clusters = restructure_vector(final_struct, links);
    clusters = cleanNumberCluster(clusters);
    
    PT_Kmeans(end+1).cluster = clusters;
    PT_Kmeans(end).day = i;
    PT_Kmeans(end).toc = toc;

end

end