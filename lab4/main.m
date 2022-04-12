%Minimal number of parameters problem
%Bisection method
[xvect, xdif, ~, ~] = bisect(1, 60000, 1e-3, @parameters);
semilogy(xvect)
title("Aproximation of N in consecutive iterations - Bisection method");
ylabel("Value of N");
xlabel("Iteration number");
%print -dpng bisect_1.png;
plot(xdif)
title("Difference between successive values ​​of N - Bisection method");
ylabel("Difference of adjacent N-s");
xlabel("Iteration number");
%print -dpng bisect_diff_1.png;
%Secant method
[xvect, xdif, ~, ~] = secant(1, 60000, 1e-3, @parameters);
semilogy(xvect)
title("Aproximation of N in consecutive iterations - Secant method");
ylabel("Value of N");
xlabel("Iteration number");
%print -dpng secant_1.png;
plot(xdif)
title("Difference between successive values ​​of N - Secant method");
ylabel("Difference of adjacent N-s");
xlabel("Iteration number");
%print -dpng secant_diff_1.png;
%Impedance module problem
%Bisection method
[xvect, xdif, ~, ~] = bisect(0, 50, 1e-12, @impedance_module);
semilogy(xvect)
title("Aproximation of ω in consecutive iterations - Bisection method");
ylabel("ω[rad/s]");
xlabel("Iteration number");
%print -dpng bisect_2.png;
plot(xdif)
title("Difference between successive values ​​of ω - Bisection method");
ylabel("Difference of adjacent ω-s");
xlabel("Iteration number");
%print -dpng bisect_diff_2.png;
%Secant method
[xvect, xdif, ~, ~] = secant(0, 50, 1e-12, @impedance_module);
semilogy(xvect)
title("Aproximation of ω in consecutive iterations - Secant method");
ylabel("ω[rad/s]");
xlabel("Iteration number");
%print -dpng secant_2.png;
plot(xdif)
title("Difference between successive values ​​of ω - Secant method");
ylabel("Difference of adjacent ω-s");
xlabel("Iteration number");
%print -dpng secant_diff_2.png;
%Rocket velocity problem
%Bisection method
[xvect, xdif, ~, ~] = bisect(0, 50, 1e-12, @rocket_velocity);
semilogy(xvect)
title("Aproximation of t in consecutive iterations - Bisection method");
ylabel("t[s]");
xlabel("Iteration number");
%print -dpng bisect_3.png;
plot(xdif)
title("Difference between successive values ​​of t - Bisection method");
ylabel("Difference of adjacent t-s");
xlabel("Iteration number");
%print -dpng bisect_diff_3.png;
%Secant method
[xvect, xdif, ~, ~] = secant(0, 50, 1e-12, @rocket_velocity);
semilogy(xvect)
title("Aproximation of t in consecutive iterations - Secant method");
ylabel("t[s]");
xlabel("Iteration number");
%print -dpng secant_3.png;
plot(xdif)
title("Difference between successive values ​​of t - Secant method");
ylabel("Difference of adjacent t-s");
xlabel("Iteration number");
%print -dpng secant_diff_3.png;

close all

opts = optimset('Display','iter');
fzero(@tan, 6, opts)
fzero(@tan, 4.5, opts)
