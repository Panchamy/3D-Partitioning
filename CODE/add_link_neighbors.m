function links = add_link_neighbors(links)
    
    all_o_nodes = [links.o_node];
    all_d_nodes = [links.d_node];
    
    for i = 1:length(links)
        links(i).neighbors = [];
        [~, oo_inds] = ismember(links(i).o_node, all_o_nodes);
        [~, do_inds] = ismember(links(i).o_node, all_d_nodes);
        [~, od_inds] = ismember(links(i).d_node, all_o_nodes);
        [~, dd_inds] = ismember(links(i).d_node, all_d_nodes);
        all_ids = [oo_inds,do_inds,od_inds,dd_inds];
        unique_ids = unique(all_ids);
        if isempty(unique_ids)
            continue;
        else
            for j = 1:length(unique_ids)
                if unique_ids(j) ~= i && unique_ids(j) ~= 0
                    links(i).neighbors = [links(i).neighbors links(unique_ids(j)).id];
                end
            end
        end
    end
    
end