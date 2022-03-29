N = [500, 1000, 3000, 6000, 12000];
d = 0.85;

Iters = zeros(1, length(N));
Times = zeros(1, length(N));
Norms = [];
for j = 1:length(N)
    Edges = generate_network(N(j), density);
    B = sparse(Edges(1,:), Edges(2,:), 1, N(j), N(j));

    LL = zeros(N(j), 1);
    for i = 1:N(j)
        LL(i) = sum(B(:,i));
    end

    I = speye(N(j));
    b = zeros(N(j),1);
    b(:,:) = (1-d)/N(j);
    A = spdiags(1./LL, 0, N(j), N(j));

    M = I - d .* B * A;
    r = ones(N(j), 1);
    L = tril(M, -1);
    U = triu(M, 1);
    D = diag(diag(M));
    C1 = -D \ (L + U);
    C2 = D \ b;
    iters = 0;
    norm_res = norm(M * r - b);

    t0 = tic;
    while norm_res >= 10^(-14)
        r = C1 * r + C2;
        iters = iters + 1;
        norm_res = norm(M * r - b);
        if N(j) == 1000
            Norms(iters) = norm_res;
        end
    end
    tj = toc(t0);
    Times(j) = tj;
    Iters(j) = iters;
end
figure
plot(N, Iters);
title("Number of iterations in Jacobian method");
xlabel("Matrix size");
ylabel("Number of iterations");
%print -dpng zadE_184608_1.png;
figure
plot(N, Times);
title("Time elapsed in Jacobian method");
xlabel("Matrix size");
ylabel("Time [s]");
%print -dpng zadE_184608_2.png;
figure
semilogy(Norms);
title("Residuum norm in Jacobian method");
xlabel("Iteration");
ylabel("Norm");
%print -dpng zadE_184608_3.png;




