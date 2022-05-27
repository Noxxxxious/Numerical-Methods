clc
close all

load trajektoria1.mat

plot3(x, y, z, 'o')
xlabel("x[m]")
ylabel("y[m]")
zlabel("z[m]")
grid on
axis equal
title("Drone trajectory based on the system location");

print -dpng 184608_wrzosek_zad2.png