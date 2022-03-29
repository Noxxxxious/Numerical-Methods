N = [500, 1000, 3000, 6000, 12000];
density = 10;
T = zeros(1, length(N));
for j = 1:length(N)
    Edges = generate_network(N(j), density);
    B = sparse(Edges(1,:), Edges(2,:), 1, N(j), N(j));
    LL = zeros(N(j), 1);
    for i = 1:N(j)
        LL(i) = sum(B(:,i));
    end
    I = speye(N(j));
    d = 0.85;
    b = zeros(N(j),1);
    b(:,:) = (1-d)/N(j);
    A = spdiags(1./LL, 0, N(j), N(j));
    M = I - d .* B * A;
    t0 = tic;
    r = M \ b;
    tj = toc(t0);
    T(j) = tj;
end
X = categorical(string(N));
X = reordercats(X, string(N));
bar(X, T);
print -dpng zadD_184608.png;




