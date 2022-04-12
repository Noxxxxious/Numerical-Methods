function [Z] = impedance_module(w)
    R = 725;
    C = 8e-5;
    L = 2;
    Z = 1 / sqrt( 1/R^2 + ( w*C - 1/(w*L) )^2 );
    Z = Z - 75;
end