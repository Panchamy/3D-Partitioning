function [eigenvectors,eigenvalues] = NCut(W)

%Step 1: summarized all the weigth of each link in D, the diagonal degree matrix
D = zeros(length(W), length(W));
for i = 1:length(W)
    %D(i,i) = sum(W(i,[(1:i-1), (i+1:end)]));%sumarized all the weight of the link i, except the weight of itself
    D(i,i) = sum(W(i,:));
end

%Step 2: compute E, the D^(-1/2)
E = zeros(length(D), length(D));
for i = 1:length(D)
    E(i,i) = 1/sqrt(D(i,i)); %D^(-1/2)
end

%Step 3: compute A, the normalized laplacian matrix  
A =  E*(D-W)*E; %Element-by-element multiplication

%Step 4: compute the eigeivalue of A
[eigenvectors,eigenvalues] = eig(A);%[V,D] = eig(A) returns diagonal matrix D of eigenvalues and matrix V whose columns are the corresponding right eigenvectors, so that A*V = V*D.

%Sort smallest eigen before return
a = NaN(length(eigenvalues), 1);
for i = 1:length(eigenvalues)
    a(i) = eigenvalues(i,i);
end
[eigenvalues, order] = sort(a);
eigenvectors =  eigenvectors(:,order);

end