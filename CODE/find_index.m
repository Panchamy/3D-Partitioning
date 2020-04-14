function link_indexes  = find_index(links, id_list)
    all_ids = [links.index];
    link_indexes = find(ismember( all_ids, id_list ));
end