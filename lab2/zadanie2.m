a = 1;
r_max = 0.1;
n_max = 100;

X = zeros(1, n_max);
Y = zeros(1, n_max);
R = zeros(1, n_max);
S = zeros(1, n_max);
D = zeros(1, n_max);
area = 0;

axis equal
hold on
valid = false;
n = 1;
while n <= n_max
    draws = 0;
    while ~valid
        c_X = a * rand;
        c_Y = a * rand;
        r = r_max * rand;
        draws = draws + 1;

        if c_X - r > 0 && c_X + r < a && c_Y - r > 0 && c_Y + r < a
            if n ~= 1
                for i = 1:n
                    intersecting = false;
                    d_center = sqrt((c_X - X(i))^2 + (c_Y - Y(i))^2);
                    r_sum = r + R(i);
                    if d_center < r_sum
                        intersecting = true;
                        break
                    end
                end
                if ~intersecting
                    valid = true;
                end
            else
                valid = true;
            end
        end

    end
    
    X(n) = c_X;
    Y(n) = c_Y;
    R(n) = r;
    area = area + pi * r^2;
    S(n) = area;
    D(n) = draws;
    plot_circle (c_X, c_Y, r);

    %fprintf(1, ' %s%5d%s%.3g\r ', 'n =',  n, ' S = ', area)
    
    valid = false;
    n = n + 1;
end
display_statistics(S, D);




function plot_circle(X, Y, R)
    theta = linspace(0, 2*pi);
    x = R * cos(theta) + X;
    y = R * sin(theta) + Y;
    plot(x,y);
end

function display_statistics(S_log, D_log)
    figure('Name', "Total Surface Area");
    semilogx(S_log);
    xlabel("n");
    title("Total Surface Area")

    figure('Name', "Average Draws Count");
    loglog(cumsum(D_log));
    xlabel("n");
    title("Average Draws Count")
end

