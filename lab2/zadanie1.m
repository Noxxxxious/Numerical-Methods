%Zadanie A
Pages = [1 1 2 2 2 3 3 3 4 4 5 5 6 6 7];
Links = [4 6 3 4 5 5 6 7 5 6 4 6 4 7 6];
N = 7;
Edges = [Pages(:); Links(:)];
%Zadanie B
B = sparse(Links, Pages, 1, N, N);
L = zeros(N, 1);
for i = 1:N
    L(i) = sum(B(:,i));
end
I = speye(N);
d = 0.85;
b = zeros(N,1);
b(:,:) = (1-d)/N;
A = spdiags(1./L, 0, N, N);
%Zadanie C
M = I - d .* B * A;
r = M \ b;
%Zadanie D
bar(r);
