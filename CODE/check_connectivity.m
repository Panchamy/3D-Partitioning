function not_connected = check_connectivity(G)

%How many connex component?
[p,q,r] = dmperm(G'+speye(size(G)));
S = numel(r)-1;
C = cumsum(full(sparse(1,r(1:end-1),1,1,size(G,1))));
C(p) = C;
%Should return 1 component for a fully connected network
u_C = unique(C);

if length(u_C)==1
%     disp('The network is fully connected')
    not_connected = [];
else
%     disp('The network is not fully connected, links are the following :')
    not_connected = find(C==2);
end

end