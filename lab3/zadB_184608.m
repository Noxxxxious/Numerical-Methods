B = sparse(Edges(1,:), Edges(2,:), 1, N, N);
LL = zeros(N, 1);
for i = 1:N
    LL(i) = sum(B(:,i));
end
I = speye(N);
d = 0.85;
b = zeros(N,1);
b(:,:) = (1-d)/N;
A = spdiags(1./LL, 0, N, N);