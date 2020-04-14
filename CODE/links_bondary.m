function [link_bondary , clust_bondary] = links_bondary(num_cluster, P, A)
%documentation into ConsensusLearning\SmallCaseStudy\readme.docx
%P is the vector partiton

%init
k = num_cluster;

%Body
B = A(:,P==k);%reducted A

%remove row of cluster k
B(P==k,:)=0;

[r,c] = find(B==1);

link_bondary = unique(r);
clust_bondary = P(link_bondary);
    
    
end