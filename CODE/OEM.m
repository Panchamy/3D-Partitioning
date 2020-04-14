function [MP, converge] = OEM(NCutCommon, W, A, method, iterations)
%One Element Move [Filkov et Skiena (2004)]

%if 0iterations means it's BOK method (best of k, best partition with maximize the similarity with other partitions)
%method = 'RI' or 'NMI'
%S is 36x1 double
%Return a consensus partition: the transformed MP for minimized the S



%% Step 1: which is the median partition?
S=nan(1,size(W,1));
for i = 1:size(W,1)
    S(i) = sum(W(i,:));
end

idMP = find(S==max(S));
idMP = idMP(1);
MP = NCutCommon(idMP).clust;




%% Step 2: modidy one random element from the median partition

converge = struct('ite', {}, 'S', {});
converge(end+1).ite = 0;
converge(end).S = S(idMP);

if ~(iterations==0)

%iterations = 1515;%20% of the mean of the number of links belong to a bondary 
for ite = 1:iterations
    
    % ---init---
    MPbis = MP;
    
    
    % ---change one element---
    %vector of candidate: all links belong to bondari
    bondaries_ele = [];
    for i = 1:max(MP)
        link_bondary = links_bondary(i, MP, A);
        bondaries_ele = [bondaries_ele ; link_bondary];
    end
    clear('link_bondary')

    %randomly a element 
    k = randi([1 length(bondaries_ele)], 1, 1);%random index
    ele = bondaries_ele(k);%this is the element chosen to move
    ele_class = MP(ele);%the number of cluster of ele
    clear('k', 'bondaries_ele')
    
    %The neighbor of ele
    [r,c] = find(A(ele,:)==1);
    neighbor = c;
    clear('r','c');
    
    %Neighbor' class of different class than ele
    index = find(MP(neighbor)~= ele_class);%index of neighbor vector
    diffnei = neighbor(index); %neighbor of ele which belong to a different class than ele
    clear('index')
    diffnei_class = MP(diffnei);%value or vector (depends of the number of candidates) of new class for ele
    
    %change the class of ele
    c = randi([1 length(diffnei_class)], 1, 1);%random index
    MPbis(ele) = diffnei_class(c);
    NCutCommon(idMP).clust = MPbis;
    
    
    % ---evaluation---
    %evaluate if the element move can minimise S
    Sbis = 0;
    for i = 1:length(NCutCommon)
        if strcmp(method,'NMI')
            Sbis = Sbis + nmi(NCutCommon(idMP).clust, NCutCommon(i).clust);
        elseif strcmp(method,'RI')
            Sbis = Sbis + RI(NCutCommon(idMP).clust, NCutCommon(i).clust);
        end
    end
    
    
    % ---save modification or not---
    %if had been minimise, keep the change; otherwise back the modification
    converge(end+1).ite = ite;
    if Sbis > S(idMP)
        %disp('one element has been changed')
        MP = MPbis;
        S(idMP) = Sbis;
        converge(end).S = Sbis;
    else
        %Go back the partition
        NCutCommon(idMP).clust = MP;
        converge(end).S = S(idMP);
    end
    
    
end
end


end