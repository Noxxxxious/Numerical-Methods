clc
close all

load trajektoria1.mat

plot3(x, y, z, 'o')
xlabel("x[m]")
ylabel("y[m]")
zlabel("z[m]")
grid on
axis equal
hold on

N = 50;
[~, x_a] = aprox_poly(n, x, N);
[~, y_a] = aprox_poly(n, y, N);
[~, z_a] = aprox_poly(n, z, N);

plot3(x_a, y_a, z_a, 'LineWidth', 4)
title(["Drone trajectory based on the system location", "and polynomial approximation, N = 50"])

print -dpng 184608_wrzosek_zad4.png