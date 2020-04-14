function [sl] = S2sl(S, links)

sl = struct('id', {}, 'period', {}, 'speed', {});

nblinks = length(links);


for i = 1:length(S)
    sl(end+1).speed = S(i);
    
    bloc = ceil(i/nblinks);
    sl(end).period = bloc;
    
    index = i-(nblinks*(bloc-1));
    sl(end).id = links(index).id;
    
end




end