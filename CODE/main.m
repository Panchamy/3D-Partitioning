%% load data
num_clusters = 10;
load('coarse_network.mat');
load('speed');
links = coarse_network(1).links;
num_links = length(links);
num_speed_dim = length(speed(1).S);
num_timeslices = num_speed_dim/num_links;
directed = 0;

%% data clustering
KmeansClust = data_clustering(speed, coarse_network, num_clusters);

%% 3D adjacency matrix
links = add_link_neighbors(links);
A = create_3D_A(links, num_timeslices, directed);

%% 3D partitioning
PT_Kmeans = connected_clustering(KmeansClust, links, speed, A, num_clusters);

%% consensus clustering of the days into 4 groups. The current clustering only allows for 4 clusters.
consensus = consensus_clustering(KmeansClust); 
