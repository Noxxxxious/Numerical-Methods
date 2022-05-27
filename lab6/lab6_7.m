clc
close all

load trajektoria2.mat

plot3(x, y, z, 'o')
xlabel("x[m]")
ylabel("y[m]")
zlabel("z[m]")
grid on
axis equal
hold on

N = 60;
x_a = aprox_tryg(n, x, N);
y_a = aprox_tryg(n, y, N);
z_a = aprox_tryg(n, z, N);

plot3(x_a, y_a, z_a, 'LineWidth', 4)
title(["Drone trajectory based on the system location", "and trigonometric approximation, N = 60"])
print -dpng 184608_zad7.png
hold off

M = size(n, 2);
N = (1:71);
err = zeros(size(N, 1));
for i = N
    x_a = aprox_tryg(n, x, i);
    y_a = aprox_tryg(n, y, i);
    z_a = aprox_tryg(n, z, i);
    err(i) = (sqrt(sum((x - x_a).^2)) + sqrt(sum((y - y_a).^2)) + sqrt(sum((z - z_a).^2))) / M;
end

figure
semilogy(err)
title("Trigonometric approximation error")
xlabel("N value")
ylabel("Error value")
print -dpng 184608_zad7_b.png

%% 
clc
close all
clear 

load trajektoria2.mat

M = size(n, 2);
N = 0;
err = Inf;
eps = 10^-2;
while err > eps
    N = N + 1;
    x_a = aprox_tryg(n, x, N);
    y_a = aprox_tryg(n, y, N);
    z_a = aprox_tryg(n, z, N);
    err = (sqrt(sum((x - x_a).^2)) + sqrt(sum((y - y_a).^2)) + sqrt(sum((z - z_a).^2))) / M;
end

plot3(x, y, z, 'o')
grid on
axis equal
hold on
plot3(x_a, y_a, z_a, 'LineWidth', 4)
title(["Drone trajectory based on the system location", "and trigonometric approximation, N = " + N])
xlabel("x[m]")
ylabel("y[m]")
zlabel("z[m]")
print -dpng 184608_zad7_c.png
