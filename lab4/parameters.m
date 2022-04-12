function [t] = parameters(N)
    t = (N^1.43 + N^1.14) / 1000;
    t = t - 5000;
end