function f = probability_density(t)
    sigma = 3;
    mi = 10;
    f = (exp(-(t - mi)^2 / (2 * sigma^2))) / (sigma * sqrt(2 * pi));
end