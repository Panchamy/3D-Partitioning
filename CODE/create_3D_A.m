function A = create_3D_A(links, num_timeslices, directed)

%directed - only for downstream neighbors 
%undirected
num_links = length(links);
A = sparse(num_links*num_timeslices, num_links*num_timeslices);    %nb links * nb period
ids = [links.id];

for i = 1:num_links
    %keep only downstream neighbor because it's directed graph
    neighbor = neighbor_amont_aval(links(i).id, links);
    %---FOR DOWNSTREAM NEIGHBOR---
    nei = neighbor.aval;
    %Find the index of nei id vector
    [~, nei_idx] = ismember(nei, ids);
    for j = 1:num_timeslices    %for each period
        i_actual = i+(num_links*(j-1));
        nei_idx_actual = nei_idx+(num_links*(j-1));
        %Add connexion spatial neighbors of a given link
        A(i_actual, nei_idx_actual) = 1;
        %----Add connexion temporal of a given link with itself t+1---
        if (j < num_timeslices)
            A(i_actual,i_actual+num_links) = 1;
        end
        %---Add connexion temporal of a given link with itself t-1---
        if (j > 1)
            A(i_actual,i_actual-num_links) = 1;
        end    
    end    
    if directed==0 
        %---FOR UPSTREAM NEIGHBOR---
        neig = links(i).neighbors;
        for r = 1:length(neighbor.aval)
            remov = find(neighbor.aval(r)==neig);
            neig(remov) = [];
        end
        nei = neig;
        clear('neig', 'remov');
        %amont neighbor are every nei except aval
        %Find the index of nei id vector
        [~, nei_idx] = ismember(nei, ids);
        for j = 1:num_timeslices        %for each period
            i_actual = i+(num_links*(j-1));
            nei_idx_actual = nei_idx+(num_links*(j-1));
            %Add connexion spatial neighbors of a given link
            A(i_actual, nei_idx_actual) = 1;
        end
    end
    
end

end
