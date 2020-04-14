function consensus = consensus_clustering(KmeansClust)

    nbclass = 4;
    
    partitions = struct('date', {}, 'clust', {});
    for j = 1:length(KmeansClust)
            partitions(end+1).date = KmeansClust(j).date;
            partitions(end).clust = KmeansClust(j).c;
    end

    %Compute the similarity
    W = NaN(length(partitions),length(partitions));
    for i = 1:size(W,1)
        for j = 1:size(W,2)
            W(i,j) = nmi(partitions(i).clust, partitions(j).clust);
        end
    end

    %3D representative consensus maps
    method_sim = 'NMI';
    iteOEM = 100;
    tic;
    
    tempW = W;
    tempPartitions = partitions;

    %%clustering into 4 groups
    [eigenvectors,~] = NCut(tempW); %[eigenvectors,eigenvalues];
    clustering = ones(size(eigenvectors,2),1);
    clustering(eigenvectors(:,2)<0&eigenvectors(:,3)<0) = 2;
    clustering(eigenvectors(:,2)<0&eigenvectors(:,3)>0) = 3;
    clustering(eigenvectors(:,2)>0&eigenvectors(:,3)<0) = 4;

    %Create the consensus for each class
    consensus = struct('class',  {}, 'consensus', {}, 'results', {}, 'speed', {});
    
    for i = 1:nbclass
        index = find(clustering == i);
        Wi = tempW(index,index);

        %Run consensus partition at a number of iteration
        optimum = struct('consensus', {}, 'S', {});
        [MP, converge] = OEM(tempPartitions(index), Wi, A, method_sim, iteOEM);

        %Save
        optimum(end+1).consensus = MP;
        optimum(end).converge = converge;
        %optimum(end).toc = tocc;
        optimum(end).S = converge(end).S;

        %Pick up the best one
        index = find([optimum.S]==max([optimum(end).S]));
        index = index(1);%if several minimized the S, take arbitrarly the first one

        %Save
        consensus(end+1).class = i;
        consensus(end).consensus = optimum(index).consensus;
        consensus(end).results = optimum;
    end
    toc;
    
end
