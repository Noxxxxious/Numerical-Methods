clc
close all
clear

load dane_jezioro
surf(XX,YY,FF)
shading interp
axis equal

N = 1e5;
fmax = 0;
fmin = -44;
x_range = 100;
y_range = 100;
z_range = -55;
N1 = 0;
for i = 1:N
    x = rand * x_range;
    y = rand * y_range;
    z = rand * z_range;
    if z >= glebokosc(x, y)
        N1 = N1 + 1;
    end
end
P = (N1 / N) * abs(x_range) * abs(y_range) * abs(z_range);