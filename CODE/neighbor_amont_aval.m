function[neighbor] = neighbor_amont_aval(id, links)
%return the upstream and downstream neighbor of a given id link

%links = coarse_network(i).links;




%Save the origin and destination node of the given id link
index = find([links.id]==id);
o = links(index).o_node;
d = links(index).d_node;


%For its neighbors, check if they below to upstream or downstream
nei = links(index).neighbors;
amont = [];
aval = [];
for i = 1:length(nei)
    %check downstream
    if links([links.id]==nei(i)).o_node == d%if the o neighbor is the same then the d given link
        aval = [aval nei(i)];
    end
    %check upstream
    if links([links.id]==nei(i)).d_node == o
        amont = [amont nei(i)];
    end
end


%Return
neighbor.amont = amont;%upstream
neighbor.aval = aval;%downstream



end