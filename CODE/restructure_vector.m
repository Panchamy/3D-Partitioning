function cluster = restructure_vector(final_struct, links)

num_links = length(links);
num = length(final_struct);
cluster = zeros(1, num*num_links);

for i = 1:num
    current_cluster = final_struct(i).cluster;
    temp = zeros(1, num_links);
    for j = 1:length(current_cluster)
        link_ids = current_cluster(j).link_ids;
        all_ids = [links.id];
        link_indexes = find(ismember( all_ids, link_ids ));
        temp(link_indexes) = current_cluster(j).cluster_id;
    end
    cluster(((i-1)*num_links)+1 : (i*num_links)) = temp;
end

end