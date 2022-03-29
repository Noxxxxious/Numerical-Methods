L = tril(M, -1);
U = triu(M, 1);
D = diag(diag(M));

%Normal
tic
r = M \ b;
toc

%Jacobian
r = ones(length(M), 1);
C1 = -D \ (L + U);
C2 = D \ b;
iters = 0;
norm_res = norm(M * r - b);

tic
while norm_res >= 10^(-14)
    r = C1 * r + C2;
    iters = iters + 1;
    norm_res = norm(M * r - b);
end
toc

%Gauss-Seidel
r = ones(length(M), 1);
C1 = -(D + L);
C2 = (D + L) \ b;
iters = 0;
norm_res = norm(M * r - b);

tic;
while norm_res >= 10^(-14)
    r = C1 \ (U * r) + C2;
    iters = iters + 1;
    norm_res = norm(M * r - b);
end
toc




