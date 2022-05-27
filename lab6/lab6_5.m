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
[~, x_a] = aprox_poly(n, x, N);
[~, y_a] = aprox_poly(n, y, N);
[~, z_a] = aprox_poly(n, z, N);

plot3(x_a, y_a, z_a, 'LineWidth', 4)
title(["Drone trajectory based on the system location", "and polynomial approximation, N = 60"])
print -dpng 184608_zad5.png
hold off

M = size(n, 2);
N = (1:71);
err = zeros(size(N, 1));
for i = N
    [~, x_a] = aprox_poly(n, x, i);
    [~, y_a] = aprox_poly(n, y, i);
    [~, z_a] = aprox_poly(n, z, i);
    err(i) = (sqrt(sum((x - x_a).^2)) + sqrt(sum((y - y_a).^2)) + sqrt(sum((z - z_a).^2))) / M;
end

figure
semilogy(err)
title("Polynomial approximation error")
xlabel("N value")
ylabel("Error value")
print -dpng 184608_zad5_b.png

