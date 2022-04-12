function [v] = rocket_velocity(t)
    g = 9.81;
    m0 = 1.5e5;
    q = 2.7e3;
    u = 2e3;
    v = u * log( m0 / (m0 - q*t) ) - g*t;
    v = v - 750;
end