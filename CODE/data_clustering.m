function  datapointclusters = data_clustering(speed, coarse_network, k)

    datapointclusters = struct('c', {}, 'data', {}, 'toc', {});

    for theday = 1:length(coarse_network)

        %Convert S into xytspeed
        links = coarse_network(theday).links;
        nodes = coarse_network(theday).nodes;
        sl = S2sl(speed(theday).S, links);
        data = sl2xytspeed(sl, links, nodes);
        X = data;

        tic;
        y = kmeans(X',k);
        tocc = toc;

        %Save 
        datapointclusters(end+1).c = y;
        datapointclusters(end).data = data;
        datapointclusters(end).toc = tocc;
    end

end
