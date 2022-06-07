clc
close all
clear
load P_ref.mat

f = @probability_density;
a = 0;
b = 5;
fmin = f(0);
fmax = f(0);

for i = 0:5
    if f(i) < fmin
        fmin = f(i);
    elseif f(i) > fmax
        fmax = f(i);
    end
end

err_rect = [];
err_trap = [];
err_simp = [];
err_monte = [];
N = 5 : 50 : 10^4;
for i = N
    dx = (b - a) / i;
    p_rect = 0;
    p_trap = 0;
    p_simp = 0;
    N1 = 0;
    a_j = a;
    b_j = a_j + dx;
    for j = 1:i
        p_rect = p_rect + f((a_j + b_j) / 2) * dx;
        p_trap = p_trap + (f(a_j) + f(b_j)) * dx / 2;
        p_simp = p_simp + (f(a_j) + 4*f((a_j + b_j) / 2) + f(b_j)) * dx/6;

        x = rand * (b - a) + a;
        y = rand * (fmax - fmin) + fmin;
        if y <= f(x)
            N1 = N1 + 1;
        end

        a_j = a_j + dx;
        b_j = b_j + dx;
    end
    p_monte = (N1 / i) * abs(b - a) * abs(fmin - fmax);

    err_rect = [err_rect, abs(p_rect - P_ref)];
    err_trap = [err_trap, abs(p_trap - P_ref)];
    err_simp = [err_simp, abs(p_simp - P_ref)];
    err_monte = [err_monte, abs(p_monte - P_ref)];   
end

figure
loglog(N, err_rect)
title("Integration error in the rectangle method")
xlabel("Number of intervals")
ylabel("Error value")
print -dpng rect_error.png

figure
loglog(N, err_trap)
title("Integration error in the trapezoid method")
xlabel("Number of intervals")
ylabel("Error value")
print -dpng trap_error.png

figure
loglog(N, err_simp)
title("Integration error in the Simpson method")
xlabel("Number of intervals")
ylabel("Error value")
print -dpng simp_error.png

figure
loglog(N, err_monte)
title("Integration error in the Monte Carlo method")
xlabel("Number of intervals")
ylabel("Error value")
print -dpng monte_error.png

N = 10^7;
dx = (b - a) / N;
p_rect = 0;
p_trap = 0;
p_simp = 0;
N_1 = 0;

tic
for i = 1:N
    a_i = a + (i - 1) * dx;
    b_i = a_i + dx;
    p_rect = p_rect + f((a_j + b_j) / 2) * dx;
end
t_rect = toc;

tic
for i = 1:N
    a_i = a + (i - 1) * dx;
    b_i = a_i + dx;
    p_trap = p_trap + (f(a_j) + f(b_j)) * dx / 2;
end
t_trap = toc;

tic
for i = 1:N
    a_i = a + (i - 1) * dx;
    b_i = a_i + dx;
    p_simp = p_simp + (f(a_j) + 4*f((a_j + b_j) / 2) + f(b_j)) * dx/6;
end
t_simp = toc;

tic
for i = 1:N
    x = rand * (b - a) + a;
        y = rand * (fmax - fmin) + fmin;
        if y <= f(x)
            N1 = N1 + 1;
        end
end
p_monte = (N1 / N) * abs(b - a) * abs(fmin - fmax);
t_monte = toc;

figure
bar(1:4, [t_rect; t_trap; t_simp; t_monte])
set(gca, "xticklabel", ["Rectangle method", "Trapezoid method", "Simpson method", "Monte Carlo method"])
title("Time of execution of different methods, N = 10^7")
ylabel("time[s]")
print -dpng execution_time.png



